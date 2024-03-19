output "app_service_id" {
  value = docker_service.app.id
}

output "db_service_id" {
  value = docker_service.db.id
}

output "web_service_id" {
  value = docker_service.web.id
}
