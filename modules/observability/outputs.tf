output "cloudtrail_id" {
  description = "ID del CloudTrail creado"
  value       = aws_cloudtrail.trail.id
}

# output "config_recorder_name" {
#   description = "Nombre del Configuration Recorder"
#   value       = aws_config_configuration_recorder.recorder.name
# }


