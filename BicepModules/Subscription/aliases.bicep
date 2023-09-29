//version: v1
@description('Required. Name of the new subscription.')
param subscriptionName string
@description('Required. Provide the full resource ID of billing scope to use for subscription creation.')
param billingScope string

targetScope = 'managementGroup'

resource subscriptionAlias 'Microsoft.Subscription/aliases@2021-10-01' = {
  scope: tenant()
  name: subscriptionName
  properties: {
    workload: 'Production'
    displayName: subscriptionName
    billingScope: billingScope
  }
}
