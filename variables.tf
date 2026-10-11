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

variable "azure_subscription_role" {
  type        = string
  description = "Azure RBAC role assigned to the Maester managed identity on the subscription. Reader is sufficient for service connection verification and Maester's Graph-based tests."
  default     = "Reader"
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

variable "azure_managed_identity_name" {
  type        = string
  description = "Name of the User Assigned Managed Identity used for the Workload Identity Federation service connection. Created in azure_resourcegroup_name."
  default     = "id-maester-wif"
}

variable "graph_app_roles" {
  type        = list(string)
  description = "The list of Graph API app roles to assign to the Azure DevOps Service Connection Principal"
  default = [
    "AuditLog.Read.All",
    "DeviceManagementConfiguration.Read.All",
    "DeviceManagementManagedDevices.Read.All",
    "DeviceManagementRBAC.Read.All",
    "DeviceManagementServiceConfig.Read.All",
    "Directory.Read.All",
    "DirectoryRecommendations.Read.All",
    "EntitlementManagement.Read.All",
    "IdentityRiskEvent.Read.All",
    "NetworkAccess.Read.All",
    "OnPremDirectorySynchronization.Read.All",
    "OrgSettings-AppsAndServices.Read.All",
    "OrgSettings-Forms.Read.All",
    "Policy.Read.All",
    "Policy.Read.ConditionalAccess",
    "PrivilegedAccess.Read.AzureAD",
    "Reports.Read.All",
    "ReportSettings.Read.All",
    "RoleEligibilitySchedule.Read.Directory",
    "RoleManagement.Read.All",
    "RoleManagementAlert.Read.Directory",
    "SecurityIdentitiesHealth.Read.All",
    "SecurityIdentitiesSensors.Read.All",
    "SharePointTenantSettings.Read.All",
    "ThreatHunting.Read.All",
    "UserAuthenticationMethod.Read.All"
  ]
}
