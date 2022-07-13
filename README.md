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
| artifactName                  | Name of the published artifact to download       | string |                         |                                                       | 
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
  - template: ./terraform/apply.yml@templates
    parameters:
      artifactName: preview.terraform.plan
```
