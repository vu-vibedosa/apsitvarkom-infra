resource "google_cloud_run_service" "cr_services" {
  for_each = toset(["apsitvarkom-be", "apsitvarkom-fe"])
  name     = each.key
  location = "us-east1"

  template {
    spec {
      containers {
        image = "${google_artifact_registry_repository.docker_repo.location}-docker.pkg.dev/${var.project_name}-${var.project_environment}/docker-${var.project_name}-${var.project_environment}/${each.key}"
      }
      ports {
        container_port = 80
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

resource "google_cloud_run_service_iam_policy" "cd_noauth_services" {
  for_each = toset(["apsitvarkom-be", "apsitvarkom-fe"])
  location = google_cloud_run_service.cr_services[each.key].location
  service  = google_cloud_run_service.cr_services[each.key].name

  policy_data = data.google_iam_policy.noauth.policy_data
}
