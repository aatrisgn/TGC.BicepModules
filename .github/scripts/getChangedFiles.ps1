[CmdletBinding()]
param(
     [Parameter()]
     [string]$modulesDirectory,
     [Parameter()]
     [string]$targetDirectory,
     [Parameter()]
     [string]$acrName
)

function CopyFiles{
    param( [string]$source )
    
    $filePath = "$targetDirectory/$source"
    [Void] (New-Item -Force $filePath)
    Copy-Item $source "$targetDirectory/$source" -Force
}

function DetectVersion()
{
    param( [string]$source )

    if(($source -like "*.bicep*") -and ($source -like "*BicepModules*")){
        # Split the string by "/"
        $parts = $source -split '/'

        # Get the last two values
        $lastTwoValues = $parts[-2], $parts[-1]

        # Remove file extension from the last value
        $lastValueWithoutExtension = $lastTwoValues[-1] -replace '\..*'

        Write-Host "Executing az acr repository show --name $acrName --repository 'bicep/modules/$($parts[-2].toLower())/$($lastValueWithoutExtension.toLower())'"

        $existingModule = (az acr repository show --name $acrName --repository "bicep/modules/$($parts[-2])/$lastValueWithoutExtension") | ConvertFrom-Json
        if (!$?) {
            Write-Host "Could not locate any existing module"
        } else {
            $existingModule
            $currentModuleVersion = $existingModule.tagCount

            $firstLine = Get-Content $source -First 1
            $buildNumber = $firstLine.substring($firstLine.Length -2)

            if($currentModuleVersion -eq "v$buildNumber"){
                throw "Module has changed but file version has not been updated."
            }
        }
    }
}

$changes = (git diff --name-only --relative HEAD HEAD~2) # Get-ChildItem $modulesDirectory -Filter "*.bicep" -Recurse

Write-Host "Files detected for change: $changes"

if ($changes -is [string]){ 
    DetectVersion $changes
    CopyFiles $changes 
}
else {
    if ($changes -is [array])
    {       
        foreach ($change in $changes)
        { 
            DetectVersion $change
            CopyFiles $change 
        }
    }
}