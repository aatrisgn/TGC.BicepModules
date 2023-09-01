@description('Name for the static web app resource.')
param staticSiteName string

@description('Tags for resource')
param tags object = {}

@description('SKU object for static web app.')
param sku object = {}

@description('Optional. Location for resources. Default is resource group location')
param location string = resourceGroup().location

resource staticWebApp 'Microsoft.Web/staticSites@2022-09-01' = {
  name: staticSiteName
  location: location
  tags: tags
  sku: sku
  properties:{
    stagingEnvironmentPolicy:'Enabled'
    allowConfigFileUpdates:true
    provider:'None'
    enterpriseGradeCdnStatus:'Disabled'
    buildProperties:{
      skipGithubActionWorkflowGeneration: true
    }
  } 
}

output staticWebAppId string = staticWebApp.id
output staticWebAppName string = staticWebApp.name
