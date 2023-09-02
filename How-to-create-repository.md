# TGC.BicepModules - How to?

This article contains a guide describing how this registry has been setup from start to end.

I got a lot of inspiration from this article, so a low of credit goes to [this article](https://www.miru.ch/how-to-build-a-bicep-module-library/) by Michael Rueefli.


## How to guide

This section will guide you through how I configured everything and which sources I used.

### Introduction - What to know before getting started

Before starting on this, I would recommend that you are at least knowledgeable about the following areas:

- Azure Portal & Identity management
- Github Actions
- Bicep
- Azure Container Registry
- Powershell scripting
- AZ CLI

If you know about the above, the guide should be fairly easy to follow. If you do not want to do that, you can always just copy all of my files.

It is assumed that you know your way around Github and have a repository created.

### Setting up Azure Service Connection

Before getting started, you need to create a service principal in Azure which has the right permissions.

I used this AZ CLI command to create the service connection:

    az ad sp create-for-rbac --name "my_service_connection_name" --role owner --scopes /subscriptions/{subscription-id}/resourceGroups/{resource-group} --sdk-auth

Once the command has executed, you will be prompted with a json object which you need to copy.

See more ways to create service connections between Github and Azure [here](https://learn.microsoft.com/en-us/azure/developer/github/connect-from-azure?tabs=azure-portal%2Cwindows#use-the-azure-login-action-with-a-service-principal-secret).

### Initial configuration of Github Action

### Deploying Azure Container Registry

### Creating a Bicep Module

### locating, building and deploying modules

### Versioning

### Using the modules

## Ensure testing

To-be-written