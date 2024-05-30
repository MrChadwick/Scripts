$interval = 1800000 # 30 minutes in milliseconds

while ($true) {
    $exeFiles = Get-ChildItem -Path $PWD -Filter "*.exe" -Recurse

    if ($exeFiles) {
        Write-Host "Found the following .exe files:"
        $exeFiles | ForEach-Object { Write-Host $_.FullName }

        $confirmation = Read-Host "Do you want to delete these files? (y/n)"
        if ($confirmation -eq 'y') {
            $exeFiles | Remove-Item -Force
            Write-Host "Files deleted."
        } else {
            Write-Host "Files not deleted."
        }
    } else {
        Write-Host "No .exe files found."
    }

    Write-Host "Waiting for $interval milliseconds..."
    Start-Sleep -Milliseconds $interval
}
