terraform {
  required_providers {
    gitcrypt = {
      source = "bcdtriptech/gitcrypt"
    }
    google = {
      source = "hashicorp/google"
    }
  }
}

provider "gitcrypt" {
}

provider "google" {
  project = "pacific-ethos-402708"
  region  = "us-east1"
}

data "gitcrypt_encrypted_file" "secret_file" {
  file_path = "./main_secret"
}

resource "google_secret_manager_secret" "super-secret" {
  secret_id = "secret"

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "super-secret-v1" {
  secret = google_secret_manager_secret.super-secret.id
  secret_data = data.gitcrypt_encrypted_file.secret_file.secrets.secret
}