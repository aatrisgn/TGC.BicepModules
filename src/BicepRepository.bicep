param location string = resourceGroup().location

module containerRegistry '../BicepModules/Container/ContainerModule.bicep' = {
   name: 'ContainerRegistry'
   params:{
    location: location
    name: 'BicepModulesRegistry'
    sku: 'Basic'
    publicNetworkAccess: 'Enabled'
   }
}
