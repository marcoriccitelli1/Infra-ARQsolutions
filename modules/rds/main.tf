// Grupo de subredes privadas para RDS
resource "aws_db_subnet_group" "subnet_group" {
  name       = "${var.ecommerce}-rds-subnet-group"
  subnet_ids = var.subredes_privadas_ids

  tags = {
    Name = "${var.ecommerce}-rds-subnet-group"
  }
}

// Instancia RDS principal con Multi-AZ y optimizaciones para alta carga
resource "aws_db_instance" "principal" {
  identifier              = "${var.ecommerce}-db"
  allocated_storage       = var.almacenamiento
  max_allocated_storage   = var.almacenamiento * 3  # Auto-scaling de storage
  engine                  = var.motor
  engine_version          = var.version_motor
  instance_class          = var.instancia
  username                = var.usuario
  password                = var.clave
  db_name                 = var.nombre_db
  multi_az                = true
  publicly_accessible     = false
  vpc_security_group_ids  = [var.sg_rds_id]
  db_subnet_group_name    = aws_db_subnet_group.subnet_group.name
  storage_encrypted       = true
  kms_key_id              = var.kms_key_arn
  skip_final_snapshot     = true
  deletion_protection     = false
  
  # Optimizaciones para alta carga
  backup_retention_period = 7
  backup_window          = "03:00-04:00"
  maintenance_window     = "sun:04:00-sun:05:00"
  
  # Performance Insights para monitoreo (deshabilitado para free tier)
  performance_insights_enabled = false
  performance_insights_retention_period = 0
  
  # Configuraciones de performance
  monitoring_interval = 60
  monitoring_role_arn = aws_iam_role.rds_enhanced_monitoring.arn

  tags = {
    Proyecto = var.ecommerce
  }
}

# IAM Role para Enhanced Monitoring
resource "aws_iam_role" "rds_enhanced_monitoring" {
  name = "${var.ecommerce}-rds-monitoring-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "monitoring.rds.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "rds_enhanced_monitoring" {
  role       = aws_iam_role.rds_enhanced_monitoring.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

// Read Replica opcional para redundancia y lectura
resource "aws_db_instance" "replica" {
  count                   = var.crear_replica ? 1 : 0
  identifier              = "${var.ecommerce}-replica"
  replicate_source_db     = aws_db_instance.principal.id
  instance_class          = var.instancia
  publicly_accessible     = false
  storage_encrypted       = true
  kms_key_id              = var.kms_key_arn
  db_subnet_group_name    = aws_db_subnet_group.subnet_group.name
  vpc_security_group_ids  = [var.sg_rds_id]

  depends_on              = [aws_db_instance.principal]

  tags = {
    Proyecto = "${var.ecommerce}-replica"
  }
}
