[CmdletBinding()]
param(
     [Parameter()]
     [string]$targetDirectory,
     [Parameter()]
     [string]$registryServer
)

Write-Host "targetDirectory: $targetDirectory"
Write-Host "registryServer: $registryServer"

az bicep install
az bicep version

$bicepFiles = Get-ChildItem $targetDirectory -Filter "*.bicep" -Recurse

Foreach ($file in $bicepFiles) {
    $buildNumber = 'v1'
    $folderName = (($file.FullName -split '/')[-2]).tolower()
    $fileName = (Split-Path -Path $file.FullName -LeafBase).tolower() 
    $targetRepository = "/bicep/modules/$folderName/$fileName"
    write-host "pushing: $fileName with Version: $buildNumber"
    az bicep publish --file $file.FullName --target br:$($registryServer)$($targetRepository):$buildNumber
}