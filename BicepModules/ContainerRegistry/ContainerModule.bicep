param name string
param location string = resourceGroup().location

@allowed([
  'Basic'
  'Standard'
  'Premium'
])
param sku string
@allowed([
  'Enabled'
  'Disabled'
])
param publicNetworkAccess string


resource acr 'Microsoft.ContainerRegistry/registries@2023-06-01-preview' = {
  name: name
  location: location
  identity:{
    type: 'SystemAssigned'    
  }
  sku:{
    name:sku
  }
  properties:{
    publicNetworkAccess:publicNetworkAccess
    zoneRedundancy: 'Disabled'    
  }
}


output registryId string = acr.id
output azureRegistryUrl string = acr.properties.loginServer
