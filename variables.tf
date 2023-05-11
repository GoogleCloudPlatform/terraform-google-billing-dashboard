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

#created by blueprints https://github.com/terraform-google-modules/terraform-google-module-template
variable "project-id" {
  description = "Project ID to deploy to"
  type        = string
}

variable "bq-billing-export-table-id" {
  type        = string
  description = "Standard billing export BigQuery table name INCLUDING project id and dataset id. Can be found in BigQuery table details under table id."
}

variable "bq-dashboard-dataset-name" {
  type        = string
  description = "Bigquery dataset where the dashboard view will be created. Should already exist."
}

variable "looker-studio-service-agent-name" {
  type        = string
  default     = null
  description = "Looker studio service agent name to be used with the looker studio dashboard. Can be copied from https://lookerstudio.google.com/c/serviceAgentHelp. If empty no gcp service account will be created and looker dashboard will be used with the executor's personal gcp account only."
}

variable "bq-dashboard-view-name" {
  type        = string
  default     = "billing-export-view"
  description = "Bigquery view name for the billing export to be created."
}

variable "billing-data-interval" {
  type        = number
  default     = 13
  description = "Time interval in month to be showed in billing dashboard."
}

variable "looker-studio-service-account-name" {
  type        = string
  default     = "looker-studio-sa"
  description = "Gcp service account name used to execute looker requests on behalf of looker service agent."
}

variable "looker-studio-report-name" {
  type        = string
  default     = "billing-report"
  description = "Copied report name."
}

variable "bq-dashboard-view-labels" {
  type        = map(string)
  description = "A map of labels to apply to bigquery view."
  default     = {}
}
