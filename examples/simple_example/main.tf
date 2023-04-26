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

module "billing_dashboard" {
  source = "git::https://github.com/GoogleCloudPlatform/terraform-google-billing-dashboard.git?ref=main"

  project-id  = var.project-id
  bq-billing-export-table-name = "data-analytics-pocs.public.billing_dashboard_export"
  bq-dashboard-dataset-name = "billing_test"
  looker-studio-service-agent-name = "service-org-test@gcp-sa-datastudio.iam.gserviceaccount.com"
}
