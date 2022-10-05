resource "google_service_account" "ga_cd_account" {
  account_id   = "ga-delivery"
  display_name = "Continuous service delivery from GitHub Actions"
}

resource "google_project_iam_member" "artifact_registry_repo_admin_binding" {
  project = "${var.project_name}-${var.project_environment}"
  role    = "roles/artifactregistry.repoAdmin"
  member  = "serviceAccount:${google_service_account.ga_cd_account.email}"
}