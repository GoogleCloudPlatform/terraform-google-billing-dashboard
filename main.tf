/**
 * Copyright 2021 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

locals {
  #Google template looker report id.
  looker-template-report-id = "64387229-05e0-4951-aa3f-e7349bbafc07"
  #extract dataset name if user is providing project_id.dataset_id
  bq-dashboard-dataset-name = element(split(".", var.bq-dashboard-dataset-name), length(split(".",var.bq-dashboard-dataset-name))-1)
}

resource "google_bigquery_table" "target_view_name" {
  project    = var.project-id
  dataset_id = local.bq-dashboard-dataset-name
  table_id   = var.bq-dashboard-view-name

  #needed to be able to recreate the view when terraform changes are applyed terraform
  deletion_protection = false

  view {
    use_legacy_sql = false
    query          = <<EOF
      SELECT *, 
      COALESCE((SELECT SUM(x.amount) FROM UNNEST(source.credits) x),0) AS credits_sum_amount, 
      COALESCE((SELECT SUM(x.amount) FROM UNNEST(source.credits) x),0) + cost as net_cost, 
      PARSE_DATE('%Y%m', invoice.month) AS Invoice_Month,
      _PARTITIONDATE AS date 
      FROM `${var.bq-billing-export-table-id}` source 
      WHERE _PARTITIONDATE > DATE_SUB(CURRENT_DATE(), INTERVAL ${var.billing-data-interval} MONTH)
EOF
  }
  labels = var.bq-dashboard-view-labels
}

#service account to be used with looker studio service agent
resource "google_service_account" "looker_studio" {
  count        = var.looker-studio-service-agent-name != null ? 1 : 0
  project      = var.project-id
  account_id   = var.looker-studio-service-account-name
  display_name = "Service Account to be used by looker studio for billing dashboard"
}

resource "google_project_iam_binding" "looker_studio_sa_bq_viewer" {
  count   = var.looker-studio-service-agent-name != null ? 1 : 0
  project = var.project-id
  role    = "roles/bigquery.dataViewer"

  members = [
    "serviceAccount:${google_service_account.looker_studio[0].email}"
  ]
}

resource "google_project_iam_binding" "looker_studio_sa_bq_job_user" {
  count   = var.looker-studio-service-agent-name != null ? 1 : 0
  project = var.project-id
  role    = "roles/bigquery.jobUser"

  members = [
    "serviceAccount:${google_service_account.looker_studio[0].email}"
  ]
}

resource "google_service_account_iam_binding" "token-creator-iam" {
  count              = var.looker-studio-service-agent-name != null ? 1 : 0
  service_account_id = google_service_account.looker_studio[0].id
  role               = "roles/iam.serviceAccountTokenCreator"
  members = [
    "serviceAccount:${var.looker-studio-service-agent-name}",
  ]
}