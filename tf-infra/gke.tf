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

resource "google_container_cluster" "gke" {
  provider            = google
  name                = "guacamole-gke${var.name_suffix}"
  location            = var.region
  networking_mode     = "VPC_NATIVE"
  network             = google_compute_network.vpc.id
  subnetwork          = google_compute_subnetwork.subnet.id
  deletion_protection = false

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = var.nwr_master_node
  }

  enable_autopilot = true

  ip_allocation_policy {}

  maintenance_policy {
    recurring_window {
      start_time = "2026-01-01T00:00:00Z" # Standardized start time
      end_time   = "2026-01-02T00:00:00Z"
      recurrence = "FREQ=WEEKLY;BYDAY=SU" # Limit upgrades to Sundays
    }
  }
}
