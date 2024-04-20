Write-Host `n
$index = 1
$registryPath = "HKCU:\Software\Microsoft\Terminal Server Client\Servers"


# Get all subfolders
$subFolders = Get-ChildItem -Path $registryPath -ErrorAction SilentlyContinue | Where-Object { $_.PsIsContainer }

# Enter each subfolder
foreach ($subFolder in $subFolders) {
    $shortPath = $subFolder.Name -replace "HKEY_CURRENT_USER", "HKCU:"

    #Print IP
    $printIP = $shortPath -replace "HKCU:\\Software\\Microsoft\\Terminal Server Client\\Servers\\", "" 
    Write-Host IP($index++) : $printIP


    # Get all properties of the specified registry key
    $keyProperties = Get-ItemProperty -Path $shortPath

    # Output key properties
    foreach ($property in $keyProperties.PSObject.Properties) {

        if ($($property.Name) -notmatch "PSPath|PSParentPath|PSChildName|PSDrive|PSProvider") {
            #Skip default keys
            Write-Host "$($property.Name): $($property.Value)"
        }
    }

    Write-Host `n`n
}

