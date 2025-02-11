variable "azure_tenant_id" {
  type        = string
  description = "The Azure Tenant ID"
  nullable    = false
}

variable "azure_subscription_name" {
  type        = string
  description = "The Azure Subscription Name"
  nullable    = false
}

variable "azure_subscription_id" {
  type        = string
  description = "The Azure Subscription ID"
  nullable    = false
}

variable "azure_devops_org_name" {
  type        = string
  description = "The Azure DevOps Organization Name"
  nullable    = false
}

variable "azure_resourcegroup_name" {
  type        = string
  description = "The Azure Resource Group Name"
  default     = "rg-maester-prod"
}

variable "azure_resourcegroup_location" {
  type        = string
  description = "The Azure Resource Group Location"
  default     = "West Europe"
}

variable "azure_devops_project_name" {
  type        = string
  description = "The Azure DevOps Project Name"
  default     = "Maester"
}

variable "azure_devops_service_connection_name" {
  type        = string
  description = "The Azure DevOps Service Connection Name"
  default     = "sc-maester-wif" 
}

variable "graph_app_roles" {
    type = list(string)
    description = "The list of Graph API app roles to assign to the Azure DevOps Service Connection Principal"
    default = [
        "Directory.Read.All",
        "DirectoryRecommendations.Read.All",
        "IdentityRiskEvent.Read.All",
        "Policy.Read.All",
        "Policy.Read.ConditionalAccess",
        "PrivilegedAccess.Read.AzureAD",
        "Reports.Read.All",
        "RoleEligibilitySchedule.Read.Directory",
        "RoleManagement.Read.All",
        "SharePointTenantSettings.Read.All",
        "UserAuthenticationMethod.Read.All"
    ]
}