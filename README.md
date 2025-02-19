# Terraform Module for Deploying Maester on Azure DevOps

This Terraform Module will help you through setting up Maester in Azure DevOps and automate the running of tests using Azure DevOps Pipelines. 🔥

## Permissions
Ensure you have Global Administrator and permissions within Azure DevOps.
- You can temporary use a PAT to deploy the resources.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuredevops"></a> [azuredevops](#requirement\_azuredevops) | 1.6.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 3.1.0 |
| <a name="provider_azuredevops"></a> [azuredevops](#provider\_azuredevops) | 1.6.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.18.0 |

## Modules

No modules.

### Resources

The following resources are created by this configuration:

| Name | Type |
|------|------|
| [azuread_app_role_assignment.app_role_assignments](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/app_role_assignment) | resource |
| [azuread_service_principal.ado_service_connection_principal](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) | resource |
| [azuread_service_principal.ms_graph](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) | resource |
| [azuredevops_build_definition.maester_build](https://registry.terraform.io/providers/microsoft/azuredevops/1.6.0/docs/resources/build_definition) | resource |
| [azuredevops_git_repository.maester_repository](https://registry.terraform.io/providers/microsoft/azuredevops/1.6.0/docs/resources/git_repository) | resource |
| [azuredevops_git_repository_file.maester_pipeline](https://registry.terraform.io/providers/microsoft/azuredevops/1.6.0/docs/resources/git_repository_file) | resource |
| [azuredevops_project.maester_project](https://registry.terraform.io/providers/microsoft/azuredevops/1.6.0/docs/resources/project) | resource |
| [azuredevops_serviceendpoint_azurerm.maester_service_connection](https://registry.terraform.io/providers/microsoft/azuredevops/1.6.0/docs/resources/serviceendpoint_azurerm) | resource |
| [azurerm_resource_group.maester_resourcegroup](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azuread_application_published_app_ids.well_known](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/application_published_app_ids) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azure_devops_org_name"></a> [azure\_devops\_org\_name](#input\_azure\_devops\_org\_name) | The Azure DevOps Organization Name | `string` | n/a | yes |
| <a name="input_azure_devops_project_name"></a> [azure\_devops\_project\_name](#input\_azure\_devops\_project\_name) | The Azure DevOps Project Name | `string` | `"Maester"` | no |
| <a name="input_azure_devops_service_connection_name"></a> [azure\_devops\_service\_connection\_name](#input\_azure\_devops\_service\_connection\_name) | The Azure DevOps Service Connection Name | `string` | `"sc-maester-wif"` | no |
| <a name="input_azure_resourcegroup_location"></a> [azure\_resourcegroup\_location](#input\_azure\_resourcegroup\_location) | The Azure Resource Group Location | `string` | `"West Europe"` | no |
| <a name="input_azure_resourcegroup_name"></a> [azure\_resourcegroup\_name](#input\_azure\_resourcegroup\_name) | The Azure Resource Group Name | `string` | `"rg-maester-prod"` | no |
| <a name="input_azure_subscription_id"></a> [azure\_subscription\_id](#input\_azure\_subscription\_id) | The Azure Subscription ID | `string` | n/a | yes |
| <a name="input_azure_subscription_name"></a> [azure\_subscription\_name](#input\_azure\_subscription\_name) | The Azure Subscription Name | `string` | n/a | yes |
| <a name="input_azure_tenant_id"></a> [azure\_tenant\_id](#input\_azure\_tenant\_id) | The Azure Tenant ID | `string` | n/a | yes |
| <a name="input_graph_app_roles"></a> [graph\_app\_roles](#input\_graph\_app\_roles) | The list of Graph API app roles to assign to the Azure DevOps Service Connection Principal | `list(string)` | <pre>[<br/>  "Directory.Read.All",<br/>  "DirectoryRecommendations.Read.All",<br/>  "IdentityRiskEvent.Read.All",<br/>  "Policy.Read.All",<br/>  "Policy.Read.ConditionalAccess",<br/>  "PrivilegedAccess.Read.AzureAD",<br/>  "Reports.Read.All",<br/>  "RoleEligibilitySchedule.Read.Directory",<br/>  "RoleManagement.Read.All",<br/>  "SharePointTenantSettings.Read.All",<br/>  "UserAuthenticationMethod.Read.All"<br/>]</pre> | no |

## Outputs

No outputs.

## Contributors
- Original author: [Merill Fernando](https://www.linkedin.com/in/merill/) | Microsoft Product Manager
- Co-author: [Brian Veldman](https://www.linkedin.com/in/brian-veldman/) | Technology Enthusiast
