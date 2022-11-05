resource "google_service_account" "ga_cd_account" {
  account_id   = "ga-delivery"
  display_name = "Continuous service delivery from GitHub Actions"
}

resource "google_project_iam_member" "artifact_registry_repo_admin_ga_cd_binding" {
  project = "${var.project_name}-${var.project_environment}"
  role    = "roles/artifactregistry.repoAdmin"
  member  = "serviceAccount:${google_service_account.ga_cd_account.email}"
}

resource "google_project_iam_member" "token_creator_ga_cd_binding" {
  project = "${var.project_name}-${var.project_environment}"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:${google_service_account.ga_cd_account.email}"
}

resource "google_project_iam_member" "cloud_run_admin_ga_cd_binding" {
  project = "${var.project_name}-${var.project_environment}"
  role    = "roles/run.admin"
  member  = "serviceAccount:${google_service_account.ga_cd_account.email}"
}

resource "google_project_iam_member" "service_account_user_ga_cd_binding" {
  project = "${var.project_name}-${var.project_environment}"
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${google_service_account.ga_cd_account.email}"
}

resource "google_service_account" "postgresql_vm_account" {
  account_id   = "postgresql-vm"
  display_name = "PostgreSQL virtual machine service account"
}
