resource "google_compute_instance" "postgresql" {
  name         = "postgresql"
  machine_type = "e2-micro"
  zone         = "us-east1-b"

  tags = ["postgresql"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      type  = "pd-standard"
      size  = 20
    }
  }

  network_interface {
    network = "default"
    access_config {
      network_tier = "PREMIUM" // Free tier uses on PREMIUM network tier
    }
  }

  metadata_startup_script = file("${path.module}/postgresql-init.sh")

  service_account {
    email  = google_service_account.postgresql_vm_account.email
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_firewall" "all_to_postgresql" {
  name        = "all-to-postgresql"
  network     = "default"
  description = "Firewall rule to allow cloud run services to communicate with PostgreSQL VM"

  allow {
    protocol = "tcp"
    ports    = ["5432"]
  }

  target_tags   = google_compute_instance.postgresql.tags
  source_ranges = ["0.0.0.0/0"]
}
