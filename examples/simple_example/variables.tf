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

variable "project-id" {
  description = "The project ID to deploy to"
  type        = string
}

variable "bq-billing-export-table-id" {
  type        = string
  description = "Standard billing export bigquery table id."
}

variable "bq-dashboard-dataset-name" {
  type        = string
  description = "Bigquery dataset id where the dashboard view will be created. Should already exist."
}

variable "looker-studio-service-agent-name" {
  type        = string
  description = "Looker studio service agent name to be used with the looker studio dashboard. Can be copied from https://lookerstudio.google.com/c/serviceAgentHelp. If empty no gcp service account will be created and looker dashboard will be used with the executor's personal gcp account only."
  default     = null
}