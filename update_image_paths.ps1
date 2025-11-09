# PowerShell script to update image paths in all HTML files

$sourceDir = "C:\Users\nilna\OneDrive\Desktop\shopping site"
$newImagePath = "C:/Users/nilna/Downloads/CSW Project/CSW Project/Images"

# Get all HTML files recursively
$htmlFiles = Get-ChildItem -Path $sourceDir -Filter "*.html" -Recurse

foreach ($file in $htmlFiles) {
    Write-Host "Processing $($file.FullName)..."
    
    # Read the content of the file
    $content = Get-Content -Path $file.FullName -Raw
    
    # Replace image paths in src attributes
    $updatedContent = $content -replace 'src="/Images/', "src=`"$newImagePath/"
    
    # Replace image paths in background-image styles
    $updatedContent = $updatedContent -replace 'url\("/Images/', "url(`"$newImagePath/"
    
    # Write the updated content back to the file
    Set-Content -Path $file.FullName -Value $updatedContent
    
    Write-Host "Updated $($file.FullName)"
}

Write-Host "All files have been updated successfully."