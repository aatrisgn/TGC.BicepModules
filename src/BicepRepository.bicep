param servicePrincipalId string
param location string = resourceGroup().location

module containerRegistry '../BicepModules/Container/ContainerModule.bicep' = {
   name: 'ContainerRegistry'
   params:{
    location: location
    name: 'TGCBicepModulesRegistry'
    sku: 'Basic'
    publicNetworkAccess: 'Enabled'
   }
}

module acrPushRole '../BicepModules/Identity/RoleAssignment.bicep' = {
  name: 'acrPushRole'
  params:{
    roleId: '8311e382-0749-4cb8-b61a-304f252e45ec'
    servicePrincipalId: servicePrincipalId
  }
}

module acrPullRole '../BicepModules/Identity/RoleAssignment.bicep' = {
  name: 'acrPullRole'
  params:{
    roleId: '7f951dda-4ed3-4680-a7ca-43fe172d538d'
    servicePrincipalId: servicePrincipalId
  }
}
