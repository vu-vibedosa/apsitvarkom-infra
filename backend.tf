terraform {
  backend "gcs" {
    bucket = "apsitvarkom-staging-bucket-tfstate"
    prefix = "terraform/state"
  }
}
