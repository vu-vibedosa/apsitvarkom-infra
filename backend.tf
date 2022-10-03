terraform {
  backend "gcs" {
    bucket = "apsitvarkom-dev-bucket-tfstate"
    prefix = "terraform/state"
  }
}
