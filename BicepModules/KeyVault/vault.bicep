//version:v1
@description('Required. Name of the key vault.')
param name string

@description('Optional. Location of the keyvault.')
param location string = resourceGroup().location

@description('Optional. SKU of Azure KeyVault. Default \'Standard\'')
param sku string = 'standard'

@description('Optional. ID of the tenant for the KeyVault. Default \'tenant of current subscription\'')
param tenantId string = subscription().tenantId

@description('Optional. Tags for the keyvault.')
param tags object = {}


resource keyVault 'Microsoft.KeyVault/vaults@2023-02-01' = {
  name: name
  location: location
  tags: tags
  properties:{
    tenantId: tenantId
    sku: {
      family:'A'
      name: sku
    }
  }
}

@description('[String] ID of the keyvault created.')
output KeyVaultId string = keyVault.id
@description('[String] Name of the keyvault created.')
output KeyVaultName string = keyVault.name
