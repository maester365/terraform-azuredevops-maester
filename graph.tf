data "azuread_application_published_app_ids" "well_known" {}

resource "azuread_service_principal" "ms_graph" {
  client_id    = data.azuread_application_published_app_ids.well_known.result["MicrosoftGraph"]
  use_existing = true
}

resource "azuread_service_principal" "ado_service_connection_principal" {
  client_id    = azuredevops_serviceendpoint_azurerm.maester_service_connection.service_principal_id
  use_existing = true
}

resource "azuread_app_role_assignment" "app_role_assignments" {
  for_each            = toset(var.graph_app_roles)
  app_role_id         = azuread_service_principal.ms_graph.app_role_ids[each.key]
  principal_object_id = azuread_service_principal.ado_service_connection_principal.object_id
  resource_object_id  = azuread_service_principal.ms_graph.object_id
}