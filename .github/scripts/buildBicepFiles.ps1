[CmdletBinding()]
param(
     [Parameter()]
     [string]$targetDirectory
)

az bicep install
az bicep version

Get-ChildItem -Path $targetDirectory -Recurse

$bicepFiles = Get-ChildItem $targetDirectory -Filter "*.bicep" -Recurse
Foreach ($file in $bicepFiles) {
    write-host "Building: $($file.FullName)"
    az bicep build --file $file.FullName
}