## Billboard Dashboard Overview
Billing Dashboard is a Looker Studio report, which uses Billing Export of the [Standard Usage Cost](https://cloud.google.com/billing/docs/how-to/export-data-bigquery-setup) into a BigQuery dataset, and offers drill down and slice and dice capabilities to analyze GCP spend using charts, tables and filters.

This tutorial will walk you through the configuration steps needed to create gcp resources and configure Looker Studio.

## Validate requirements

### Existing Standard Billing Export to BigQuery

Go to [GCP Billing](https://pantheon.corp.google.com/billing)
Choose your **billing account** from the list
Go to **billing export**
**Standard usage cost** should be **Enabled** 

### Validate enabled APIs

Following Google APIs need to be enabled:

- [BigQuery API](https://console.cloud.google.com/apis/api/bigquery.googleapis.com) `bigquery.googleapis.com`
- [Identity and Access Management (IAM) API](https://console.cloud.google.com/apis/api/iam.googleapis.com) `iam.googleapis.com`(https://pantheon.corp.google.com/apis/library/iam.googleapis.com)

You can get the list of enabled APIs with this gcloud command:
```
gcloud services list --project=<YOUR GCP PROJECT>
```

### Required IAM permissions

You must have the following roles on the project:

- roles/bigquery.dataEditor
- roles/iam.serviceAccountAdmin
- roles/iam.projectIamAdmin

You can list assigned iam roles with this command:
```
gcloud projects get-iam-policy <YOUR GCP PROJECT ID>  \
--flatten="bindings[].members" \
--format='table(bindings.role)' \
--filter="bindings.members:<YOUR GOOGLE ACCOUNT>"
```

## Find your project id
```
gcloud projects list --filter='NAME=<YOUR GCP PROJECT NAME>'
```
Store it to the env variable:
```
export PROJECT_ID=<YOUR GCP PROJECT ID>
```

## Find your billing export table

Go to [GCP Billing](https://pantheon.corp.google.com/billing)
Choose your **billing account** from the list
Go to **billing export**
In **Standard usage cost** click on **Dataset name**
Copy **Dataset ID** from **Dataset info**

Store it to the env variable:
```
export BQ_BILLING_EXPORT_TABLE_ID=<BQ BILLING EXPORT TABLE ID>
```

## Find or create your BigQuery dataset for the view

You can use the same BigQuery dataset as the one used for the billing export.

If you want to create new dataset use the following command:
```
bq --location=<DATASET LOCATION> mk --dataset <YOUR GCP PROJECT ID>:<BQ DATASET NAME>
```
[More](https://cloud.google.com/bigquery/docs/locations) on BigQuery dataset locations.

Store it to the env variable:
```
export BQ_DASHBOARD_DATASET_NAME=<BQ DATASET NAME>
```

## Get your Looker Studio service agent name

You can find the Service Agent name from the [Looker Studio Service Agent page](https://lookerstudio.google.com/c/serviceAgentHelp)

Store it to the env variable:
```
export LOOKER_STUDIO_SERVICE_AGENT_NAME=<LOOKER STUDIO SERVICE AGENT NAME>
```

## Prepare terraform variables file

Copy the following code in the terraform variables file replacing placeholdes with actual information found on previous steps:
```
cat << EOF > variables.tfvars
  project-id  = "${PROJECT_ID}"
  bq-billing-export-table-id = "${BQ_BILLING_EXPORT_TABLE_ID}"
  bq-dashboard-dataset-name = "${BQ_DASHBOARD_DATASET_NAME}"
  looker-studio-service-agent-name = "${LOOKER_STUDIO_SERVICE_AGENT_NAME}"
EOF
```

## Apply changes via terraform
Initialise terraform working directory
```
terraform init 
```

Run terraform plan step 
```
terraform plan -var-file=variables.tfvars
```

Run terraform apply step 
```
terraform apply -var-file=variables.tfvars
```

## Finish Looker Studio dashboard configuration 
Click the Looker Studio Linking API link to open the dashboard.
In Looker Studio, click Edit and share to save the dashboard. When you're prompted to add data sources to the report, click Add to report.
[Configure Looker Studion](https://support.google.com/looker-studio/answer/10835295) to use created gcp service account copied from the Terraform output.