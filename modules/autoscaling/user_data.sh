#!/bin/bash

# Script de inicialización para instancias de ecommerce
# Optimizado para alta disponibilidad y performance

# Actualizar sistema
yum update -y

# Instalar herramientas básicas
yum install -y htop iotop nload

# Configurar Nginx (ejemplo de aplicación web)
yum install -y nginx

# Crear directorio para la aplicación
mkdir -p /var/www/${ecommerce}

# Configurar Nginx para la aplicación
cat > /etc/nginx/conf.d/${ecommerce}.conf << EOF
server {
    listen 80;
    server_name _;
    
    location / {
        root /var/www/${ecommerce};
        index index.html;
        try_files \$uri \$uri/ =404;
    }
    
    # Health check endpoint
    location /health {
        access_log off;
        return 200 "healthy\n";
        add_header Content-Type text/plain;
    }
}
EOF

# Crear página de ejemplo
cat > /var/www/${ecommerce}/index.html << EOF
<!DOCTYPE html>
<html>
<head>
    <title>${ecommerce} - Ecommerce</title>
</head>
<body>
    <h1>Bienvenido a ${ecommerce}</h1>
    <p>Instancia: \$(hostname)</p>
    <p>Fecha: \$(date)</p>
</body>
</html>
EOF

# Configurar permisos
chown -R nginx:nginx /var/www/${ecommerce}
chmod -R 755 /var/www/${ecommerce}

# Iniciar y habilitar Nginx
systemctl start nginx
systemctl enable nginx

# Configurar CloudWatch agent para monitoreo
yum install -y amazon-cloudwatch-agent

# Crear configuración básica de CloudWatch
cat > /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json << EOF
{
    "metrics": {
        "namespace": "CWAgent",
        "metrics_collected": {
            "cpu": {
                "measurement": ["cpu_usage_idle", "cpu_usage_iowait", "cpu_usage_user", "cpu_usage_system"],
                "metrics_collection_interval": 60
            },
            "disk": {
                "measurement": ["used_percent"],
                "metrics_collection_interval": 60,
                "resources": ["*"]
            },
            "mem": {
                "measurement": ["mem_used_percent"],
                "metrics_collection_interval": 60
            }
        }
    }
}
EOF

# Iniciar CloudWatch agent
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
    -a fetch-config \
    -m ec2 \
    -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json \
    -s

# Log de inicialización
echo "$(date): Instancia ${ecommerce} inicializada correctamente" >> /var/log/user-data.log
