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

output "looker_studio_report_link" {
  description = "Looker Studio Linking API link."
  value       = "https://datastudio.google.com/reporting/create?c.reportId=${local.looker-template-report-id}&r.reportName=${var.looker-studio-report-name}&ds.ds8.refreshFields=false&ds.ds8.connector=bigQuery&ds.ds8.projectId=${var.project-id}&ds.ds8.type=TABLE&ds.ds8.datasetId=${var.bq-dashboard-dataset-name}&ds.ds8.tableId=${var.bq-dashboard-view-name}"
}

output "gcp_service_account_name" {
  description = "Gcp service account name to be used with Looker Studio dashboard as datasource credentials."
  value       = var.looker-studio-service-agent-name != null ? google_service_account.looker_studio[0].email : null
}
