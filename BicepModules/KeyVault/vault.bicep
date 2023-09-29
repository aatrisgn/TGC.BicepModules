//version:v1
@description('Name of the key vault.')
param name string

@description('Optional. Location of the keyvault.')
param location string = resourceGroup().location

@description('Optional. Tags for the keyvault.')
param tags object = {}

resource keyVault 'Microsoft.KeyVault/vaults@2023-02-01' = {
  name: name
  location: location
  tags: tags
}

@description('[String] ID of the keyvault created.')
output KeyVaultId string = keyVault.id
@description('[String] Name of the keyvault created.')
output KeyVaultName string = keyVault.name
