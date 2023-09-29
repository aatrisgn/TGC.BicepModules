//version: v2
@description('Required. Name of the new subscription.')
param subscriptionName string
@description('Required. Provide the full resource ID of billing scope to use for subscription creation.')
param billingScope string
@description('Optional. Provide the ID of the associated Azure Management Group. Default is none.')
param managementGroupId string = ''
@description('Optional. Tags for the subscription. Default is none.')
param tags object = {}

resource subscriptionAlias 'Microsoft.Subscription/aliases@2021-10-01' = {
  scope: tenant()
  name: subscriptionName
  properties: {
    workload: 'Production'
    displayName: subscriptionName
    billingScope: billingScope
    additionalProperties: {
      managementGroupId: managementGroupId
      tags: tags
    }
  }
}

@description('[String] ID of created subscription alias.')
output subscriptionId string = subscriptionAlias.id
@description('[String] name of created subscription alias.')
output subscriptionName string = subscriptionAlias.name
