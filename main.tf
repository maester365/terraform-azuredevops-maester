resource "azuredevops_project" "maester_project" {
  name               = var.azure_devops_project_name
  visibility         = "private"
  version_control    = "Git"
  work_item_template = "Agile"
  description        = "Maester"
}

resource "azuredevops_git_repository" "maester_repository" {
  project_id = azuredevops_project.maester_project.id
  name       = "Maester-tests"
  initialization {
    init_type   = "Import"
    source_type = "Git"
    source_url  = "https://github.com/maester365/maester-tests"
  }
}

resource "azuredevops_git_repository_file" "maester_pipeline" {
  repository_id       = azuredevops_git_repository.maester_repository.id
  file                = "azure-pipelines.yml"
  content             = templatefile("${path.module}/azure-pipelines.yml", {})
  branch              = "refs/heads/main"
  commit_message      = "Add Maester pipeline"
  overwrite_on_create = false
}

resource "azuredevops_build_definition" "maester_build" {
  project_id = azuredevops_project.maester_project.id
  name       = "Maester Daily Tests"
  ci_trigger {
    use_yaml = true
  }
  repository {
    repo_type   = "TfsGit"
    repo_id     = azuredevops_git_repository.maester_repository.id
    branch_name = azuredevops_git_repository.maester_repository.default_branch
    yml_path    = "azure-pipelines.yml"
  }
}

resource "azurerm_resource_group" "maester_resourcegroup" {
  name     = var.azure_resourcegroup_name
  location = var.azure_resourcegroup_location
}

# User Assigned Managed Identity (UAMI) used as the WIF principal for the ADO service connection.
# Using an explicit identity avoids the automatic-creation flow that fails on VSES
# subscriptions ("GetUserAccessToken: Failed to obtain an access token of identity ...").
resource "azurerm_user_assigned_identity" "maester_wif" {
  name                = var.azure_managed_identity_name
  resource_group_name = azurerm_resource_group.maester_resourcegroup.name
  location            = azurerm_resource_group.maester_resourcegroup.location
}

# Grants the UAMI the minimum Azure RBAC role needed for the ADO service connection
# to verify and for pipelines to read subscription metadata. In automatic WIF mode
# Azure DevOps assigned this role implicitly; in explicit mode we own it.
resource "azurerm_role_assignment" "maester_wif_subscription" {
  scope                = "/subscriptions/${var.azure_subscription_id}"
  role_definition_name = var.azure_subscription_role
  principal_id         = azurerm_user_assigned_identity.maester_wif.principal_id
}

# Service connection uses the UAMI's client_id as the WIF principal.
# The `credentials` block puts the connection into explicit (manual) WIF mode;
# without it the provider falls back to automatic mode, which requires Azure DevOps
# to call back into Azure to create its own managed identity — that call fails on
# certain subscription types (e.g. VSES).
resource "azuredevops_serviceendpoint_azurerm" "maester_service_connection" {
  project_id                             = azuredevops_project.maester_project.id
  service_endpoint_name                  = var.azure_devops_service_connection_name
  service_endpoint_authentication_scheme = "WorkloadIdentityFederation"
  azurerm_spn_tenantid                   = var.azure_tenant_id
  azurerm_subscription_id                = var.azure_subscription_id
  azurerm_subscription_name              = var.azure_subscription_name
  description                            = "Service connection for Maester"

  credentials {
    serviceprincipalid = azurerm_user_assigned_identity.maester_wif.client_id
  }
}

# Federated identity credential that trusts Azure DevOps's OIDC issuer for this
# specific service connection and pipeline. Both issuer and subject are read back
# from the service connection resource after it is created.
resource "azurerm_federated_identity_credential" "maester_wif" {
  name                = "maester-ado-oidc"
  resource_group_name = azurerm_resource_group.maester_resourcegroup.name
  parent_id           = azurerm_user_assigned_identity.maester_wif.id
  audience            = ["api://AzureADTokenExchange"]
  issuer              = azuredevops_serviceendpoint_azurerm.maester_service_connection.workload_identity_federation_issuer
  subject             = azuredevops_serviceendpoint_azurerm.maester_service_connection.workload_identity_federation_subject
}
