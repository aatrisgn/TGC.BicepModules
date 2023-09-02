//version:v1
@description('Name for the static web app resource.')
param staticSiteName string

@description('Tags for resource')
param tags object = {}

@description('SKU object for static web app.')
param sku object = {}

@description('Optional. Default is location of resource group. Location for resources.')
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

@description('ID of Azure Static Web App.')
output staticWebAppId string = staticWebApp.id

@description('Name of Azure Static Web App.')
output staticWebAppName string = staticWebApp.name
