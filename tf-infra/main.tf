# 
# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

locals {
  gke_service_account_roles = [
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    "roles/monitoring.viewer",
    "roles/stackdriver.resourceMetadata.writer",
    "roles/artifactregistry.reader"
  ]

  remote_url = var.external_url == "sslip.io" ? lookup(data.external.wildcard-dns-url.result, "certdomain", "unknown") : var.external_url
}

resource "random_id" "suffix" {
  byte_length = 5
}

resource "random_password" "db_password" {
  length  = 16
  special = false
}

resource "random_password" "db_root_password" {
  length  = 16
  special = false
}

resource "random_password" "keystore_password" {
  length  = 16
  special = false
}

module "project-services" {
  source = "terraform-google-modules/project-factory/google//modules/project_services"

  project_id = var.project_id

  activate_apis = toset(var.required_apis)
}

data "google_compute_default_service_account" "default" {}

data "google_client_openid_userinfo" "me" {}

data "google_client_config" "provider" {}

data "google_project" "project" {}

data "external" "wildcard-dns-url" {
  program = ["${path.module}/bin/sslip-io-url.sh"]

  query = {
    externalip = google_compute_global_address.guacamole-external.address
  }
}
