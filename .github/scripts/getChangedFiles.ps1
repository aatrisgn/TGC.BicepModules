[CmdletBinding()]
param(
     [Parameter()]
     [string]$modulesDirectory,
     [Parameter()]
     [string]$targetDirectory
)

function CopyFiles{
    param( [string]$source )
    $filePath = "$targetDirectory/$source"
    [Void] (New-Item -Force $filePath)
    Copy-Item $source "$targetDirectory/$source" -Force
}

$changes = Get-ChildItem $modulesDirectory -Filter "*.bicep" -Recurse

Write-Host "Files detected for change: $changes"

if ($changes -is [string]){ 
    CopyFiles $changes 
}
else {
    if ($changes -is [array])
    {       
        foreach ($change in $changes)
        { 
            CopyFiles $change 
        }
    }
}