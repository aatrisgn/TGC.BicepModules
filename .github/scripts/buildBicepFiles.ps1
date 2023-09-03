[CmdletBinding()]
param(
     [Parameter()]
     [string]$targetDirectory
)

az bicep install
az bicep version

$bicepFiles = Get-ChildItem $targetDirectory -Filter "*.bicep" -Recurse
Foreach ($file in $bicepFiles) {
    write-host "Building: $($file.FullName)"
    az bicep build --file $file.FullName

    $lines = Get-Content -Path $file.FullName

    $descriptionLine = $null

    for ($i = 0; $i -lt $lines.Count; $i++) {
        $line = $lines[$i]

        if ($line.StartsWith('@description\(')) {
            $descriptionLine = $line
            continue
        }

        if (($line -match '^param|^output') -and ( $null -ne $descriptionLine )) {
            Write-Host "Found line: $line"
            Write-Host "Description line: $descriptionLine"
            $descriptionLine = $null
            continue
        }

        if (($line -match '^param|^output') -and ($null -eq $descriptionLine)) {
            throw "Found line: $line but no description for parameter/output. Each parameter/output needs to have @description as its nearest decorator."            
        }
    }
}