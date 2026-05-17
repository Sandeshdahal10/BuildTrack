$files = Get-ChildItem -Path src/main/webapp/WEB-INF/views -Recurse -Filter *.jsp
foreach ($f in $files) {
    $content = Get-Content $f.FullName -Raw
    $changed = $false
    
    # Fix sidebar container
    if ($content -match '<div class="fixed inset-y-0 left-0( z-[0-9]+)? w-56( border-r.*)?( bg-.*)?">') {
        $content = $content -replace '<div class="fixed inset-y-0 left-0( z-[0-9]+)? w-56( border-r[^"]*)?( bg-[^"]*)?">', '<div id="sidebar-container" class="fixed inset-y-0 left-0 z-50 w-56 transform -translate-x-full transition-transform duration-300 md:translate-x-0$2$3">'
        $changed = $true
    }
    
    # Fix main content margin
    if ($content -match 'class="ml-56\b([^"]*)"') {
        $content = $content -replace 'class="ml-56\b([^"]*)"', 'class="ml-0 md:ml-56 w-full max-w-full overflow-hidden flex-1$1"'
        $changed = $true
    }
    
    if ($changed) {
        Set-Content -Path $f.FullName -Value $content -NoNewline
        Write-Host "Updated $($f.FullName)"
    }
}
