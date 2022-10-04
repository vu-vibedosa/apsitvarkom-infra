resource "google_storage_bucket" "terraform_state_bucket" {
  name          = "${var.project_name}-${var.project_environment}-bucket-tfstate"
  force_destroy = false
  location      = "us-east1"
  storage_class = "STANDARD"
}

resource "google_artifact_registry_repository" "docker_repo" {
  location      = "us-east1"
  repository_id = "docker-${var.project_name}-${var.project_environment}"
  description   = "Docker repository for storing images of ${var.project_name} (${var.project_environment}) services"
  format        = "docker"
}
