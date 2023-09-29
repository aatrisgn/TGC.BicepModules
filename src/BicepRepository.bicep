param servicePrincipalId string
param location string = resourceGroup().location

module containerRegistry '../BicepModules/ContainerRegistry/azureContainerRegistry.bicep' = {
   name: 'ContainerRegistry'
   params:{
    location: location
    name: 'TGCBicepModulesRegistry'
    sku: 'Basic'
    publicNetworkAccess: 'Enabled'
   }
}

resource acr 'Microsoft.ContainerRegistry/registries@2023-07-01' existing = {
  name: containerRegistry.name
}

resource roleDefinition 'Microsoft.Authorization/roleDefinitions@2022-04-01' existing = {
  scope: acr
  name: 'acdd72a7-3385-48ef-bd42-f606fba81ae7'
}

resource symbolicname 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(resourceGroup().id, servicePrincipalId, roleDefinition.id)
  scope: resourceGroup()
  properties: {
    principalId: servicePrincipalId
    principalType: 'ServicePrincipal'
    roleDefinitionId: roleDefinition.id
  }
}


module acrPushRole '../BicepModules//Authorization/RoleAssignment.bicep' = {
  name: 'acrPushRole'
  params:{
    roleId: '8311e382-0749-4cb8-b61a-304f252e45ec'
    servicePrincipalId: servicePrincipalId
    principalType: 'ServicePrincipal'
  }
}

module acrPullRole '../BicepModules/Authorization/RoleAssignment.bicep' = {
  name: 'acrPullRole'
  params:{
    roleId: '7f951dda-4ed3-4680-a7ca-43fe172d538d'
    servicePrincipalId: servicePrincipalId
    principalType: 'ServicePrincipal'
  }
}

output azureRegistryUrl string = containerRegistry.outputs.azureRegistryUrl
output azureRegistryName string = containerRegistry.outputs.azureRegistryName
