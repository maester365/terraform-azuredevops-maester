data "azuread_application_published_app_ids" "well_known" {}

resource "azuread_service_principal" "ms_graph" {
  client_id    = data.azuread_application_published_app_ids.well_known.result["MicrosoftGraph"]
  use_existing = true
}

# The UAMI's principal_id IS the object ID of its service principal in Entra ID.
# We use it directly here — managed identity SPs are type "ManagedIdentity" and
# cannot be imported through azuread_service_principal.
resource "azuread_app_role_assignment" "app_role_assignments" {
  for_each            = toset(var.graph_app_roles)
  app_role_id         = azuread_service_principal.ms_graph.app_role_ids[each.key]
  principal_object_id = azurerm_user_assigned_identity.maester_wif.principal_id
  resource_object_id  = azuread_service_principal.ms_graph.object_id
}
