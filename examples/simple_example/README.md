# Simple Example

This example illustrates how to use the `billing-dashboard` module.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 4.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_billing_dashboard"></a> [billing\_dashboard](#module\_billing\_dashboard) | git::https://github.com/GoogleCloudPlatform/terraform-google-billing-dashboard.git | main |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bq-billing-export-table-name"></a> [bq-billing-export-table-name](#input\_bq-billing-export-table-name) | Standard billing export bigquery table name. | `string` | n/a | yes |
| <a name="input_bq-dashboard-dataset-name"></a> [bq-dashboard-dataset-name](#input\_bq-dashboard-dataset-name) | Bigquery dataset where the dashboard view will be created. Should already exist. | `string` | n/a | yes |
| <a name="input_looker-studio-service-agent-name"></a> [looker-studio-service-agent-name](#input\_looker-studio-service-agent-name) | Looker studio service agent name to be used with the looker studio dashboard. Can be copied from https://lookerstudio.google.com/c/serviceAgentHelp. If empty no gcp service account will be created and looker dashboard will be used with the executor's personal gcp account only. | `string` | null | no |
| <a name="input_project-id"></a> [project-id](#input\_project-id) | The project ID to deploy to | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_gcp_service_account_name"></a> [gcp\_service\_account\_name](#output\_gcp\_service\_account\_name) | Gcp service account name to be used with looker dashboard as datasource credentials. |
| <a name="output_looker_studio_report_link"></a> [looker\_studio\_report\_link](#output\_looker\_studio\_report\_link) | Looker Linking API url. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

To provision this example, run the following from within this directory:
- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure
