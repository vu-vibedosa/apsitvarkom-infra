resource "google_storage_bucket" "terraform_state_bucket" {
  name          = "apsitvarkom-dev-bucket-tfstate"
  force_destroy = false
  location      = "us-east1"
  storage_class = "STANDARD"
}
