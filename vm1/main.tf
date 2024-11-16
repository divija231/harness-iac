terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.11.2"
    }
  }
}

provider "google" {
  project     = "dev-bivouac-441702-t4"
  region      = "us-central1"
  zone        = "us-central1-c"
  credentials = file("/harness/gcp_credentials.json")
}

resource "google_compute_instance" "default" {
  name         = "my-instance-from-harness"
  machine_type = "e2-medium"
  zone         = "us-central1-c"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata = {
    foo = "bar"
  }

  metadata_startup_script = "echo hi > /test.txt"

  service_account {
    email  = "admin-created@dev-bivouac-441702-t4.iam.gserviceaccount.com"  # Replace with your service account email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}
