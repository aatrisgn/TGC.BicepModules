param servicePrincipalId string
param roleId string

resource symbolicname 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: 'string'
  scope: resourceGroup() //resourceSymbolicName or tenant()
  properties: {
    //condition: 'string'
    //conditionVersion: 'string'
    // delegatedManagedIdentityResourceId: 'string'
    // description: 'string'
    principalId: servicePrincipalId
    // principalType: 'string'
    roleDefinitionId: roleId
  }
}
