param servicePrincipalId string
param roleId string
param principalType string

resource roleDefinition 'Microsoft.Authorization/roleDefinitions@2022-05-01-preview' existing = {
  scope: resourceGroup()
  name: roleId
}

resource symbolicname 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(resourceGroup().id, servicePrincipalId, roleId)
  scope: resourceGroup() //resourceSymbolicName or tenant()
  properties: {
    //condition: 'string'
    //conditionVersion: 'string'
    // delegatedManagedIdentityResourceId: 'string'
    // description: 'string'
    principalId: servicePrincipalId
    principalType: principalType
    roleDefinitionId: roleDefinition.id
  }
}
