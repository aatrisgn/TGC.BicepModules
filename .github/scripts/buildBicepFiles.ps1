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

        # Check if the current line contains "@description("
        if ($line.StartsWith('@description\(')) {
            $descriptionLine = $line
            continue
        }

        # Check if the current line starts with "param" or "output" and the previous line had "@description("
        if (($line -match '^param|^output') -and ($descriptionLine -ne $null)) {
            Write-Host "Found line: $line"
            Write-Host "Description line: $descriptionLine"
            $descriptionLine = $null
            # You can add your desired actions or logic here
        }

        if (($line -match '^param|^output') -and ($descriptionLine -eq $null)) {
            throw "Found line: $line but no description for parameter/output. Each parameter/output needs to have @description as its nearest decorator."            
        }
    }
}