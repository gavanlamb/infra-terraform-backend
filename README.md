# Terraform Backend Infrastructure

This repository is for infrastructure relating to Terraform backend


## Azure DevOps
### Templates
#### Variables

#### Tasks
##### Apply
Apply the changes described in the `.tfplan` file

This template will:
1. Download the specified artifact
2. Extract the files from the downloaded artifact
3. Install the specified Terraform version
4. Apply the Terraform changes

The [apply](./pipelines/templates/tasks/apply.yml) template is a [step](https://docs.microsoft.com/en-us/azure/devops/pipelines/process/templates?view=azure-devops#step-reuse) template meaning it needs to be nested under a `steps:` block.

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
  - template: ./terraform/apply.yml@terraform-templates
```


##### Destroy
Destroy infrastructure and delete the relevant workspace

This template will:
1. Install the specified Terraform version
2. Initialise the Terraform
3. Select the relevant workspace
4. Destroy the infrastructure
5. Delete the workspace

##### Parameters
| Name                         | Description                                              | Type   | Default                                    | Default                                               |
|:-----------------------------|:---------------------------------------------------------|:-------|:-------------------------------------------|:------------------------------------------------------|
| awsAccessKeyId               | AWS access key id                                        | string | `$(AWS_ACCESS_KEY_ID)`                     | Variable group named `{{environment}}.{{AWS region}}` |
| awsSecretKeyId               | AWS secret key id                                        | string | `$(AWS_SECRET_KEY_ID)`                     | Variable group named `{{environment}}.{{AWS region}}` |
| awsDefaultRegion             | AWS default region                                       | string | `$(AWS_DEFAULT_REGION)`                    | Variable group named `{{environment}}.{{AWS region}}` |
| destroyAdditionalArguments   | Additional command options for Terraform destroy command | string | " "                                        |                                                       |
| initAdditionalCommandOptions | Additional command options for Terraform init command    | string | " "                                        |                                                       |
| initArgs                     | Initialise arguments for Terraform                       | string | `$(TF_CLI_ARGS_INIT)`                      | Terraform variable file                               |
| version                      | Terraform version to download and install                | string | 1.0.2                                      |                                                       |
| workingDirectory             | Directory where Terraform files are located              | string | `$(Build.SourcesDirectory)/infrastructure` |                                                       |
| workspaceName                | Terraform workspace                                      | string |                                            |                                                       |



##### Example
```yaml
- template: ./terraform/destroy.yml@templates
  parameters:
    workspaceName: time-preview-23
```
