# Terraform Backend Infrastructure

This repository is for infrastructure relating to Terraform backend

## Azure DevOps
### Templates
#### Variables
Non-secret variables will be automatically added as environment variables which can be consumed without any mapping. The variables listed below are the minimum needed to use all templates.

| Name               | Description                                                                                     |
|:-------------------|:------------------------------------------------------------------------------------------------|
| `TF_ARTIFACT_NAME` | Name of terraform artifact                                                                      |
| `TF_CLI_ARGS_INIT` | Arguments for Terraform init command. Generally this will include backend configuration values. |

* [preview.ap-southeast-2.yml](./pipelines/aws/templates/variables/preview.ap-southeast-2.yml)  
* [preview.us-east-1.yml](./pipelines/aws/templates/variables/preview.us-east-1.yml)  
* [production.ap-southeast-2.yml](./pipelines/aws/templates/variables/production.ap-southeast-2.yml)  
* [production.us-east-1.yml](./pipelines/aws/templates/variables/production.us-east-1.yml)  

##### Example
```yaml
resources:
  repositories:
    - repository: terraform-templates
      type: github
      name: expensely/infrastructure-terraform-backend
      endpoint: expensely

variables:
  - template: pipelines/aws/templates/variables/production.ap-southeast-2.yml@terraform-templates
```

#### Tasks
##### Apply
Apply the changes described in the `.tfplan` file

This template will:
1. Download the specified artifact
2. Extract the files from the downloaded artifact
3. Install the specified Terraform version
4. Apply the Terraform changes

The [apply](./pipelines/aws/templates/tasks/apply.yml) template is a [step](https://docs.microsoft.com/en-us/azure/devops/pipelines/process/templates?view=azure-devops#step-reuse) template meaning it needs to be nested under a `steps:` block.

###### Parameters
| Name                          | Description                                      | Type   | Default                 | Default value found in                                |
|:------------------------------|:-------------------------------------------------|:-------|:------------------------|-------------------------------------------------------|
| awsAccessKeyId                | AWS access key id                                | string | `$(AWS_ACCESS_KEY_ID)`  | Variable group named `{{environment}}.{{AWS region}}` |
| awsSecretKeyId                | AWS secret key id                                | string | `$(AWS_SECRET_KEY_ID)`  | Variable group named `{{environment}}.{{AWS region}}` |
| awsDefaultRegion              | AWS default region                               | string | `$(AWS_DEFAULT_REGION)` | Variable group named `{{environment}}.{{AWS region}}` |
| applyAdditionalCommandOptions | Additional command options for Terraform apply   | string | " "                     |                                                       |
| artifactName                  | Name of the published artifact to download       | string | `$(TF_ARTIFACT_NAME)`   | Terraform variable file                               | 
| version                       | Terraform version to download and install        | string | 1.0.2                   |                                                       |
| workingDirectory              | Working directory                                | string | `$(Pipeline.Workspace)` |                                                       |


###### Example
```yaml
resources:
  repositories:
    - repository: terraform-templates
      type: github
      name: expensely/infrastructure-terraform-backend
      endpoint: expensely
      
steps:
  - template: ./pipelines/aws/templates/tasks/apply.yml@terraform-templates
```

##### Destroy
Destroy infrastructure and delete the relevant workspace

This template will:
1. Install the specified Terraform version
2. Initialise the Terraform
3. Select the relevant workspace
4. Destroy the infrastructure
5. Delete the workspace

The [destroy](./pipelines/aws/templates/tasks/destroy.yml) template is a [step](https://docs.microsoft.com/en-us/azure/devops/pipelines/process/templates?view=azure-devops#step-reuse) template meaning it needs to be nested under a `steps:` block.

###### Parameters
| Name                         | Description                                              | Type   | Default                                    | Default value found in                                |
|:-----------------------------|:---------------------------------------------------------|:-------|:-------------------------------------------|:------------------------------------------------------|
| awsAccessKeyId               | AWS access key id                                        | string | `$(AWS_ACCESS_KEY_ID)`                     | Variable group named `{{environment}}.{{AWS region}}` |
| awsSecretKeyId               | AWS secret key id                                        | string | `$(AWS_SECRET_KEY_ID)`                     | Variable group named `{{environment}}.{{AWS region}}` |
| awsDefaultRegion             | AWS default region                                       | string | `$(AWS_DEFAULT_REGION)`                    | Variable group named `{{environment}}.{{AWS region}}` |
| destroyAdditionalArguments   | Additional command options for Terraform destroy command | string | " "                                        |                                                       |
| initAdditionalCommandOptions | Additional command options for Terraform init command    | string | " "                                        |                                                       |
| initArgs                     | Initialise arguments for Terraform                       | string | `$(TF_CLI_ARGS_INIT)`                      | Terraform variable file                               |
| version                      | Terraform version to download and install                | string | 1.0.2                                      |                                                       |
| workingDirectory             | Directory where Terraform files are located              | string | `$(Build.SourcesDirectory)/infrastructure` |                                                       |
| workspace                    | Terraform workspace                                      | string |                                            |                                                       |

###### Example
```yaml
resources:
  repositories:
    - repository: terraform-templates
      type: github
      name: expensely/infrastructure-terraform-backend
      endpoint: expensely

steps:
  - template: ./pipelines/aws/templates/tasks/destroy.yml@terraform-templates
    parameters:
      workspace: time-preview-23
```

##### Infracost
Get a cost breakdown of the infrastructure

This template will:
1. Install Infracost
2. Run Infracost Breakdown
3. Generate HTML report
4. Destroy the infrastructure
5. Publish Infracost HTML report

The [infracost](./pipelines/aws/templates/tasks/infracost.yml) template is a [step](https://docs.microsoft.com/en-us/azure/devops/pipelines/process/templates?view=azure-devops#step-reuse) template meaning it needs to be nested under a `steps:` block.

###### Parameters
| Name                              | Description                                                | Type    | Default                                    | Default value found in                                |
|:----------------------------------|:-----------------------------------------------------------|:--------|:-------------------------------------------|:------------------------------------------------------|
| awsAccessKeyId                    | AWS access key id                                          | string  | `$(AWS_ACCESS_KEY_ID)`                     | Variable group named `{{environment}}.{{AWS region}}` |
| awsSecretKeyId                    | AWS secret key id                                          | string  | `$(AWS_SECRET_KEY_ID)`                     | Variable group named `{{environment}}.{{AWS region}}` |
| awsDefaultRegion                  | AWS default region                                         | string  | `$(AWS_DEFAULT_REGION)`                    | Variable group named `{{environment}}.{{AWS region}}` |
| apiKey                            | Infracost api key                                          | string  | `$(INFRACOST_API_KEY)`                     | Variable group named `infracost`                      |
| version                           | Infracost version to install                               | string  | `0.10.x`                                   |                                                       |
| breakdownAdditionalCommandOptions | Additional command options for Infracost breakdown command | string  | " "                                        | Terraform variable file                               |
| enableDashboard                   | Enable Infracost dashboard                                 | boolean | `true`                                     |                                                       |
| currency                          | Currency to show cost in                                   | string  | `AUD`                                      |                                                       |
| workingDirectory                  | Directory where Terraform files are located                | string  | `$(Build.SourcesDirectory)/infrastructure` |                                                       |

###### Example
```yaml
resources:
  repositories:
    - repository: terraform-templates
      type: github
      name: expensely/infrastructure-terraform-backend
      endpoint: expensely

steps:
  - template: ./pipelines/aws/templates/tasks/infracost.yml@terraform-templates
    parameters:
      breakdownAdditionalCommandOptions: --terraform-var-file variables/${{ variables.ENVIRONMENT }}.${{ variables.AWS_DEFAULT_REGION }}.tfvars
```

##### Plan
Create a Terraform plan.

This template will:
1. Install the specified Terraform version
2. Initialise the Terraform
3. Select or create the relevant workspace
4. Plan the changes and save them to a file
5. Archive the changes to tar.gz
6. Publish the archive

This template will install the specified Terraform version, initialise Terraform, and apply the changes described in `.tfplan` file.

The [plan](./pipelines/aws/templates/tasks/plan.yml) template is a [step](https://docs.microsoft.com/en-us/azure/devops/pipelines/process/templates?view=azure-devops#step-reuse) template meaning it needs to be nested under a `steps:` block.

###### Parameters
| Name                         | Description                                                                          | Type   | Default                                    | Default value found in                                |
|:-----------------------------|:-------------------------------------------------------------------------------------|:-------|:-------------------------------------------|-------------------------------------------------------|
| awsAccessKeyId               | AWS access key id                                                                    | string | `$(AWS_ACCESS_KEY_ID)`                     | Variable group named `{{environment}}.{{AWS region}}` |
| awsSecretKeyId               | AWS secret key id                                                                    | string | `$(AWS_SECRET_KEY_ID)`                     | Variable group named `{{environment}}.{{AWS region}}` |
| awsDefaultRegion             | AWS default region                                                                   | string | `$(AWS_DEFAULT_REGION)`                    | Variable group named `{{environment}}.{{AWS region}}` |
| artifactName                 | Name of the published artifact, that contains the plan file, to download and extract | string | `$(TF_ARTIFACT_NAME)`                      | Terraform variable file                               |
| initAdditionalCommandOptions | Additional command options for Terraform init                                        | string | " "                                        |                                                       |
| planAdditionalCommandOptions | Additional command options for the Terraform plan                                    | string | " "                                        |                                                       |
| version                      | Terraform version to download and install                                            | string | 1.0.2                                      |                                                       |
| workingDirectory             | Directory where Terraform files are located                                          | string | `$(Build.SourcesDirectory)/infrastructure` |                                                       |
| workspace                    | Terraform workspace                                                                  | string |                                            |                                                       |

###### Example
```yaml
resources:
  repositories:
    - repository: terraform-templates
      type: github
      name: expensely/infrastructure-terraform-backend
      endpoint: expensely

steps: 
  - template: ./pipelines/aws/templates/tasks/plan.yml@terraform-templates
    parameters:
      workspace: time-preview-23
```

##### Tfsec
Static analysis of your terraform code to spot potential misconfigurations

This template will:
1. Install the specified tfsec version
2. Run tfsec
3. Publish HTML report

The [tfsec](./pipelines/aws/templates/tasks/tfsec.yml) template is a [step](https://docs.microsoft.com/en-us/azure/devops/pipelines/process/templates?view=azure-devops#step-reuse) template meaning it needs to be nested under a `steps:` block.

If you are going to use this to apply changes to infrastructure in AWS you will need to configure the credentials using the [configure](#configure) template.

###### Parameters
| Name             | Description                                                    | Type   | Default                                    | Default value found in |
|:-----------------|:---------------------------------------------------------------|:-------|:-------------------------------------------|------------------------|
| version          | Terraform Static code Analyzer version to download and install | string | `1.26.0`                                   |                        |
| commandOptions   | Command options                                                | string |                                            |                        |
| workspace        | Terraform workspace                                            | string |                                            |                        |
| workingDirectory | Directory where Terraform files are located                    | string | `$(Build.SourcesDirectory)/infrastructure` |                        |

###### Example
```yaml
resources:
  repositories:
    - repository: terraform-templates
      type: github
      name: expensely/infrastructure-terraform-backend
      endpoint: expensely

steps:
  - template: ./pipelines/aws/templates/tasks/tfsec.yml@terraform-templates
    parameters:
      commandOptions: -var-file="variables/${{ variables.ENVIRONMENT }}.${{ variables.AWS_DEFAULT_REGION }}.tfvars"
```

##### Terraform Plan & Apply
Job:  
1. Plan  
    a. Run the [plan](#plan) template  
    b. Run the [infracost](#infracost) template  
    c. Run the [tfsec](#tfsec) template  
2. Manually validate the Terraform plan  
3. Apply  
    a. Run the [apply](#apply) template

The [plan-and-approve](./pipelines/aws/templates/tasks/plan-and-approve.yml) template is a [job](https://docs.microsoft.com/en-us/azure/devops/pipelines/process/templates?view=azure-devops#job-reuse) template meaning it needs to be nested under a `jobs:` block.

If you are going to use this to apply changes to infrastructure in AWS you will need to configure the credentials using the [configure](#configure) template.

###### Parameters
| Name                                       | Description                                                    | Type    | Default                                     | Default value found in                                |
|:-------------------------------------------|:---------------------------------------------------------------|:--------|:--------------------------------------------|-------------------------------------------------------|
| awsAccessKeyId                             | AWS access key id                                              | string  | `$(AWS_ACCESS_KEY_ID)`                      | Variable group named `{{environment}}.{{AWS region}}` |
| awsSecretKeyId                             | AWS secret key id                                              | string  | `$(AWS_SECRET_KEY_ID)`                      | Variable group named `{{environment}}.{{AWS region}}` |
| awsDefaultRegion                           | AWS default region                                             | string  | `$(AWS_DEFAULT_REGION)`                     | Variable group named `{{environment}}.{{AWS region}}` |
| environment                                | Name of the environment to deploy to                           | string  |                                             |                                                       |
| infracostApiKey                            | API key for Infracost                                          | string  | `$(INFRACOST_API_KEY)`                      |                                                       |
| infracostBreakdownAdditionalCommandOptions | Additional command options for Infracost breakdown command     | string  | " "                                         |                                                       |
| infracostEnableDashboard                   | Enable Infracost dashboard                                     | boolean | `true`                                      |                                                       |
| infracostVersion                           | Infracost version to install                                   | string  | `0.10.x`                                    |                                                       |
| infracostCurrency                          | Currency to show cost in                                       | string  | `AUD`                                       |                                                       |
| runInfracost                               | Run Infracost?                                                 | boolean | `true`                                      |                                                       |
| runTfsec                                   | Run TFSEC?                                                     | boolean | `true`                                      |                                                       |
| runTerraformApply                          | Run Terraform Apply?                                           | boolean | `true`                                      |                                                       |
| terraformArtifactName                      | Name of the Terraform plan artifact                            | string  | `$(TF_ARTIFACT_NAME)`                       |                                                       |
| terraformWorkspace                         | Name of the Terraform workspace                                | string  |                                             |                                                       |
| terraformApplyAdditionalCommandOptions     | Additional options for Terraform apply command                 | string  | " "                                         |                                                       |
| terraformInitAdditionalCommandOptions      | Additional options for Terraform init command                  | string  | " "                                         |                                                       |
| terraformPlanAdditionalCommandOptions      | Additional options for the Terraform plan command              | string  | " "                                         |                                                       |
| terraformVariablesFile                     | Terraform variable file                                        | string  |                                             |                                                       |
| terraformVersion                           | Terraform version to install                                   | string  | `1.0.2`                                     |                                                       |
| tfsecCommandOptions                        | Command options                                                | string  | " "                                         |                                                       |
| tfsecVersion                               | Terraform Static Code Analyzer version to download and install | string  | `1.26.0`                                    |                                                       |
| workingDirectory                           | Directory where Terraform files are located                    | string  | `$(Build.SourcesDirectory)/infrastructure ` |                                                       |

###### Example
```yaml
resources:
  repositories:
    - repository: terraform-templates
      type: github
      name: expensely/infrastructure-terraform-backend
      endpoint: expensely

jobs:
  - template: ./pipelines/aws/templates/tasks/plan-and-approve.yml@terraform-templates
    parameters:
      terraformVariablesFile: variables/${{ variables.ENVIRONMENT }}.${{ variables.AWS_DEFAULT_REGION }}.tfvars
      terraformWorkspace: time-production
      environment: production
```
