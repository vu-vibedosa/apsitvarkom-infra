resource "google_compute_instance" "postgresql" {
  name         = "postgresql"
  machine_type = "e2-micro"
  zone         = "us-east1-b"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      type  = "pd-standard"
      size  = 20
    }
  }

  network_interface {
    network = "default"
  }

  metadata_startup_script = file("${path.module}/postgresql-init.sh")

  service_account {
    email  = google_service_account.postgresql_vm_account.email
    scopes = ["cloud-platform"]
  }
}
