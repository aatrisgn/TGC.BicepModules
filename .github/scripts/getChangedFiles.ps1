[CmdletBinding()]
param(
     [Parameter()]
     [bool]$buildOnlychangedModules,
     [Parameter()]
     [string]$modulesDirectory,
     [Parameter()]
     [string]$targetDirectory
)

function CopyFiles{
    param( [string]$source )

    $target = $targetDirectory + $source

    New-Item -Force $target
    copy-item $source $target -Force
}

If ($buildOnlychangedModules -eq $true) {
    $changes = git diff --name-only HEAD HEAD~2
}
else {
    $changes = Get-ChildItem $modulesDirectory -Filter "*.bicep" -Recurse
}

Write-Host $changes

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