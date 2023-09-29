//version:v1
@description('Name of container registry.')
param name string

@description('Optional. Azure location of Container Registry.')
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

resource acr 'Microsoft.ContainerRegistry/registries@2023-07-01' = {
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
