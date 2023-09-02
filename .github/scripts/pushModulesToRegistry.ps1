[CmdletBinding()]
param(
     [Parameter()]
     [string]$targetDirectory,
     [Parameter()]
     [string]$registryServer
)

az bicep install
az bicep version

Get-ChildItem -Path $targetDirectory -Recurse
$bicepFiles = Get-ChildItem $targetDirectory -Filter "*.bicep" -Recurse

Foreach ($file in $bicepFiles) {
    $folderName = (($file.FullName -split '/')[-2]).tolower()
    $fileName = (Split-Path -Path $file.FullName -LeafBase).tolower()

    $firstLine = Get-Content $file -First 1
    $buildNumber = $firstLine.substring($firstLine.Length -2)

    $targetRepository = "/bicep/modules/$folderName/$fileName"
    write-host "pushing: $fileName with Version: $buildNumber"
    az bicep publish --file $file.FullName --target br:$($registryServer)$($targetRepository):$buildNumber
}