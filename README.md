# Terraform Google Billing Dashboard

This module automates creation of the GCP resources required to deploy the [Billing Dashboard](https://datastudio.google.com/reporting/64387229-05e0-4951-aa3f-e7349bbafc07/page/p_l3qef1s8rc). 
Billing Dashboard is a Looker Studio report, which uses Billing Export of the [Standard Usage Cost](https://cloud.google.com/billing/docs/how-to/export-data-bigquery-setup) into a BigQuery dataset, and offers drill down and slice and dice capabilities to analyze GCP spend using charts, tables and filters.

This terraform module supports creating:

1. BigQuery View for the Standard Usage Cost export BigQuery table.
1. If the Looker Studio Service Agent name is provided, then this module will create the following components:
    - GCP Service Account to be impersonated by the Looker Studio Service Agent  
    - `roles/iam.serviceAccountTokenCreator`, `roles/bigquery.jobUser` and `roles/bigquery.dataViewer` roles binding for the GCP service account

Due to the Looker Studio API limitations, the output of this script will generate a [Looker Studio Linking API](https://developers.google.com/looker-studio/integrate/linking-api#linking_api_user_experience) link. You need to click the link from terraform output to accept and save the report.


### Requirements
1. To deploy this blueprint you must have an active billing account and billing permissions.
1. Verify or enable GCP Billing Exports - standard or detailed usage costs export (if enabling for first time, await export tables to be created before proceeding to next step)
1. If you plan to share the report in your organization and use a Service Account instead of your own credentials to access the BigQuery View, copy the Service Agent name from the [Looker Studio Service Agent page](https://lookerstudio.google.com/c/serviceAgentHelp) and pass it to the script via the `looker-studio-service-agent-name` parameter.

## Usage

Basic usage of this module is as follows:

```hcl
module "billing_dashboard" {
  source  = "terraform-google-modules/billing-dashboard/google"
  version = "~> 0.1"

  project_id                        = "<PROJECT ID>"
  bq-billing-export-table-name      = "<BILLING EXPORT TABLE>"
  bq-dashboard-dataset-name         = "<BIGQUERY DATASET>"
  looker-studio-service-agent-name  = "<LOOKER STUDIO SERVICE AGENT>"
}
```

Functional examples are included in the
[examples](./examples/) directory.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 3.53, < 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.54.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_bigquery_table.target_view_name](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_table) | resource |
| [google_project_iam_binding.looker_studio_sa_bq_job_user](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_binding) | resource |
| [google_project_iam_binding.looker_studio_sa_bq_viewer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_binding) | resource |
| [google_service_account.looker_studio](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_iam_binding.token-creator-iam](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_binding) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing-data-interval"></a> [billing-data-interval](#input\_billing-data-interval) | Time interval in month to be showed in billing dashboard. | `number` | `13` | no |
| <a name="input_bq-billing-export-table-name"></a> [bq-billing-export-table-name](#input\_bq-billing-export-table-name) | Standard billing export BigQuery table name. | `string` | n/a | yes |
| <a name="input_bq-dashboard-dataset-name"></a> [bq-dashboard-dataset-name](#input\_bq-dashboard-dataset-name) | BigQuery dataset where the dashboard view will be created. Should already exist. | `string` | n/a | yes |
| <a name="input_bq-dashboard-view-labels"></a> [bq-dashboard-view-labels](#input\_bq-dashboard-view-labels) | A map of labels to apply to BigQuery view. | `map(string)` | `{}` | no |
| <a name="input_bq-dashboard-view-name"></a> [bq-dashboard-view-name](#input\_bq-dashboard-view-name) | BigQuery view name for the billing export to be created. | `string` | `"billing-export-view"` | no |
| <a name="input_looker-studio-report-name"></a> [looker-studio-report-name](#input\_looker-studio-report-name) | Copied report name. | `string` | `"billing-report"` | no |
| <a name="input_looker-studio-service-account-name"></a> [looker-studio-service-account-name](#input\_looker-studio-service-account-name) | Gcp service account name used to execute looker requests on behalf of looker service agent. | `string` | `"looker-studio-sa"` | no |
| <a name="input_looker-studio-service-agent-name"></a> [looker-studio-service-agent-name](#input\_looker-studio-service-agent-name) | Looker studio service agent name to be used with the looker studio dashboard. Can be copied from https://lookerstudio.google.com/c/serviceAgentHelp. If empty no gcp service account will be created and looker dashboard will be used with the executor's personal gcp account only. | `string` | `null` | no |
| <a name="input_project-id"></a> [project-id](#input\_project-id) | Project ID to deploy to | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_gcp_service_account_name"></a> [gcp\_service\_account\_name](#output\_gcp\_service\_account\_name) | Gcp service account name to be used with looker dashboard as datasource credentials. |
| <a name="output_looker_studio_report_link"></a> [looker\_studio\_report\_link](#output\_looker\_studio\_report\_link) | Looker Linking API url. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

### Service Account
In order to execute this module you must have a Service Account with the following roles on the project:

- roles/bigquery.dataEditor
- roles/iam.serviceAccountAdmin
- roles/iam.projectIamAdmin

The [Project Factory module][project-factory-module] and the
[IAM module][iam-module] may be used in combination to provision a
service account with the necessary roles applied.

### Org policies that could block the deployment

Org policies that could block the deployment of this solution

- constraints/iam.disableServiceAccountCreation

### APIs

A project with the following APIs enabled must be used to host the
resources of this module:

- Google Cloud APIs `cloudapis.googleapis.com`
- BigQuery API `bigquery.googleapis.com`
- Cloud Resource Manager API `cloudresourcemanager.googleapis.com`

The [Project Factory module][project-factory-module] can be used to
provision a project with the necessary APIs enabled.

### Software

The following dependencies must be available:

- [Terraform][terraform] v0.13
- [Terraform Provider for GCP][terraform-provider-gcp] plugin v3.0

## Contributing

Refer to the [contribution guidelines](./CONTRIBUTING.md) for
information on contributing to this module.

[iam-module]: https://registry.terraform.io/modules/terraform-google-modules/iam/google
[project-factory-module]: https://registry.terraform.io/modules/terraform-google-modules/project-factory/google
[terraform-provider-gcp]: https://www.terraform.io/docs/providers/google/index.html
[terraform]: https://www.terraform.io/downloads.html

## Security Disclosures

Please see our [security disclosure process](./SECURITY.md).
