# PowerShell script to update navigation links in all HTML files

$projectDir = "c:\Users\nilna\OneDrive\Desktop\shopping site"

# Get all HTML files in the project
$htmlFiles = Get-ChildItem -Path $projectDir -Filter *.html -Recurse

foreach ($file in $htmlFiles) {
    Write-Host "Processing $($file.FullName)..."
    
    # Read file content
    $content = Get-Content -Path $file.FullName -Raw
    
    # Replace absolute paths with relative paths
    if ($file.DirectoryName -eq $projectDir) {
        # Files in root directory
        $updatedContent = $content -replace 'href="/index.html"', 'href="index.html"'
        $updatedContent = $updatedContent -replace 'href="/Pages/', 'href="Pages/'
        $updatedContent = $updatedContent -replace 'href="/Products/', 'href="Products/'
        $updatedContent = $updatedContent -replace 'href="/Images/', 'href="Images/'
        $updatedContent = $updatedContent -replace 'window.location.href = "/index.html"', 'window.location.href = "index.html"'
    } else {
        # Files in subdirectories
        $relativePath = "../" * ([Regex]::Matches($file.DirectoryName.Substring($projectDir.Length), '\\').Count)
        $updatedContent = $content -replace 'href="/index.html"', ('href="' + $relativePath + 'index.html"')
        $updatedContent = $updatedContent -replace 'href="/Pages/', ('href="' + $relativePath + 'Pages/')
        $updatedContent = $updatedContent -replace 'href="/Products/', ('href="' + $relativePath + 'Products/')
        $updatedContent = $updatedContent -replace 'href="/Images/', ('href="' + $relativePath + 'Images/')
        $updatedContent = $updatedContent -replace 'window.location.href = "/index.html"', ('window.location.href = "' + $relativePath + 'index.html"')
    }
    
    # Write updated content back to file
    Set-Content -Path $file.FullName -Value $updatedContent
    
    Write-Host "Updated $($file.FullName)"
}

Write-Host "All navigation links updated successfully."