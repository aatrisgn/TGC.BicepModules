//version:v1
@description('Name of the user assigned identity')
param name string

@description('Optional. Location of the managed identity.')
param location string = resourceGroup().location

@description('Optional. Tags for the managed identity.')
param tags object = {}

resource symbolicname 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: name
  location: location
  tags:tags
}
