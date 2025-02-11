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

resource "azuredevops_serviceendpoint_azurerm" "maester_service_connection" {
  project_id                             = azuredevops_project.maester_project.id
  service_endpoint_name                  = var.azure_devops_service_connection_name
  service_endpoint_authentication_scheme = "WorkloadIdentityFederation"
  azurerm_spn_tenantid      = var.azure_tenant_id
  azurerm_subscription_id   = var.azure_subscription_id
  azurerm_subscription_name = var.azure_subscription_name
  description = "Service connection for Maester"
  resource_group = azurerm_resource_group.maester_resourcegroup.name
}