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
  #https://developers.google.com/looker-studio/integrate/linking-api
  description = "Looker Linking API url."
  value       = module.billing_dashboard.looker_studio_report_link
}

output "gcp_service_account_name" {
  #https://developers.google.com/looker-studio/integrate/linking-api
  description = "Gcp service account name to be used with looker dashboard as datasource credentials."
  value       = module.billing_dashboard.gcp_service_account_name
}