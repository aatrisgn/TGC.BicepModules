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
@description('Optional. SKU of Azure Container Registry. Default is \'basic\'.')
param sku string = 'Basic'

@allowed([
  'Enabled'
  'Disabled'
])
// @description('Optional. Whether or not the container registry should be publicly accessible. Default is \'disabled\'.')
param publicNetworkAccess string = 'Disabled'

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
