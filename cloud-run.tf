resource "google_cloud_run_service" "be_service" {
  name     = "apsitvarkom-be"
  location = "us-east1"

  template {
    spec {
      containers {
        image = "${google_artifact_registry_repository.docker_repo.location}-docker.pkg.dev/${var.project_name}-${var.project_environment}/docker-${var.project_name}-${var.project_environment}/apsitvarkom-be"
        env {
          name  = "ASPNETCORE_ENVIRONMENT"
          value = "Development"
        }
        ports {
          container_port = 80
        }
      }
    }
  }
}

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "be_service_noauth" {
  location = google_cloud_run_service.be_service.location
  project  = google_cloud_run_service.be_service.project
  service  = google_cloud_run_service.be_service.name

  policy_data = data.google_iam_policy.noauth.policy_data
}