// Grupo de subredes privadas para RDS
resource "aws_db_subnet_group" "subnet_group" {
  name       = "${var.ecommerce}-rds-subnet-group"
  subnet_ids = var.subredes_privadas_ids

  tags = {
    Name = "${var.ecommerce}-rds-subnet-group"
  }
}

// Instancia RDS principal con Multi-AZ
resource "aws_db_instance" "principal" {
  identifier              = "${var.ecommerce}-db"
  allocated_storage       = var.almacenamiento
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

  tags = {
    Proyecto = var.ecommerce
  }
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
