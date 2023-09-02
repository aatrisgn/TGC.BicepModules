//version:v1
@description('Object ID of the the principal you want to assign a role.')
param servicePrincipalId string

@description('ID of the role the service principal should be assigned')
param roleId string

@description('Optional. Default is \'ServicePrincipal\'. Type of principal the role should be assigned.')
@allowed(['Device'
  'ForeignGroup'
  'Group'
  'ServicePrincipal'
  'User'])
param principalType string = 'ServicePrincipal'

resource roleDefinition 'Microsoft.Authorization/roleDefinitions@2022-05-01-preview' existing = {
  scope: resourceGroup()
  name: roleId
}

resource symbolicname 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(resourceGroup().id, servicePrincipalId, roleId)
  scope: resourceGroup()
  properties: {
    principalId: servicePrincipalId
    principalType: principalType
    roleDefinitionId: roleDefinition.id
  }
}