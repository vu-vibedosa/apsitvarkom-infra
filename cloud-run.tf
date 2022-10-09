resource "google_cloud_run_service" "be_service" {
  name     = "apsitvarkom-be"
  location = "us-east1"
}

resource "google_cloud_run_service" "fe_service" {
  name     = "apsitvarkom-fe"
  location = "us-east1"
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

resource "google_cloud_run_service_iam_policy" "fe_service_noauth" {
  location = google_cloud_run_service.fe_service.location
  project  = google_cloud_run_service.fe_service.project
  service  = google_cloud_run_service.fe_service.name

  policy_data = data.google_iam_policy.noauth.policy_data
}
