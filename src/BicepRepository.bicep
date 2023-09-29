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
