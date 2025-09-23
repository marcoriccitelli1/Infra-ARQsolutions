# 🚀 INFRAESTRUCTURA ESCALABLE - ECOMMERCE

## 🎯 **Objetivo**
Demostrar una infraestructura escalable que puede manejar desde tráfico normal hasta picos masivos como Black Friday.

## 📁 **Estructura del Proyecto**

```
environments/
├── free-tier/      # 🟢 Operación Normal (Costo: ~$16/mes)
└── black-friday/   # 🔴 Picos de Tráfico (Costo: ~$200-300/mes)
```

## 🚀 **Demostración de Escalado**

### **🟢 Operación Normal (Free Tier)**
```bash
# Desplegar configuración básica
cd environments/free-tier
terraform apply -var-file="terraform.tfvars"
```
**Características:**
- 1-2 instancias EC2 (t2.micro - GRATIS)
- RDS t3.micro (GRATIS)
- Costo: ~$16/mes
- Capacidad: 100-500 usuarios/hora

### **🔴 Black Friday (Escalado)**
```bash
# Escalar para picos de tráfico
cd environments/black-friday
terraform apply -var-file="terraform.tfvars"
```
**Características:**
- 3-20 instancias EC2 (t3.medium)
- RDS Multi-AZ + réplicas
- CloudFront habilitado
- Costo: ~$200-300/mes
- Capacidad: 10,000+ usuarios/hora

## 📊 **Comparación de Escalado**

| Métrica | Free Tier | Black Friday | Escalado |
|---------|-----------|--------------|----------|
| **Instancias** | 1-2 | 3-20 | 10x |
| **Costo/mes** | $16 | $200-300 | 12x |
| **Usuarios/hora** | 500 | 10,000+ | 20x |
| **Tiempo respuesta** | <2s | <2s | Mantenido |

## 🎯 **Conceptos Demostrados**

1. **Auto Scaling**: Escalado automático basado en métricas
2. **Load Balancing**: Distribución de carga con ALB
3. **CDN**: CloudFront para cache global
4. **Base de Datos**: RDS Multi-AZ para alta disponibilidad
5. **Monitoreo**: CloudWatch y alertas en tiempo real
6. **Costo**: Optimización según demanda

## 🔄 **Flujo de Escalado**

```
Tráfico Normal → Detección de Pico → Escalado Automático → Black Friday
     ↓                ↓                    ↓                    ↓
  1-2 instancias    Alertas activadas    3-20 instancias    10,000+ usuarios
  $16/mes          CloudWatch           $200-300/mes        <2s respuesta
```

## 🚀 **Comandos de Demostración**

### **Paso 1: Desplegar Operación Normal**
```bash
terraform apply -var-file="environments/free-tier/terraform.tfvars"
```

### **Paso 2: Simular Pico de Tráfico**
```bash
terraform apply -var-file="environments/black-friday/terraform.tfvars"
```

### **Paso 3: Volver a Normal**
```bash
terraform apply -var-file="environments/free-tier/terraform.tfvars"
```

## 📋 **Recursos Creados**

- **VPC**: Red privada con subredes públicas y privadas
- **ALB**: Application Load Balancer para distribución de carga
- **Auto Scaling**: Escalado automático de instancias
- **RDS**: Base de datos gestionada con alta disponibilidad
- **CloudFront**: CDN para distribución global (Black Friday)
- **Monitoreo**: CloudWatch con alertas y dashboards
###