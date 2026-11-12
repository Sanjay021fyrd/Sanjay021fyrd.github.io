# Tiny static file server for previewing the portfolio locally.
# Usage:  powershell -ExecutionPolicy Bypass -File serve.ps1 [-Port 8080]
# Then open http://localhost:8080  (Ctrl+C to stop)
param([int]$Port = 8080)

$root = $PSScriptRoot
$types = @{
  '.html' = 'text/html; charset=utf-8'; '.css' = 'text/css; charset=utf-8'
  '.js' = 'application/javascript; charset=utf-8'; '.json' = 'application/json'
  '.png' = 'image/png'; '.jpg' = 'image/jpeg'; '.jpeg' = 'image/jpeg'; '.svg' = 'image/svg+xml'
  '.pdf' = 'application/pdf'; '.ico' = 'image/x-icon'; '.webp' = 'image/webp'
}

$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$Port/")
$listener.Start()
Write-Host "Serving $root at http://localhost:$Port/  (Ctrl+C to stop)"

try {
  while ($listener.IsListening) {
    $ctx = $listener.GetContext()
    $rel = [Uri]::UnescapeDataString($ctx.Request.Url.AbsolutePath).TrimStart('/')
    if ([string]::IsNullOrEmpty($rel)) { $rel = 'index.html' }
    $path = [IO.Path]::GetFullPath((Join-Path $root $rel))

    # Block path traversal and the server script itself
    if (-not $path.StartsWith($root) -or $path -eq $PSCommandPath -or -not (Test-Path $path -PathType Leaf)) {
      $ctx.Response.StatusCode = 404
      $bytes = [Text.Encoding]::UTF8.GetBytes('404 Not Found')
    } else {
      $ext = [IO.Path]::GetExtension($path).ToLower()
      $ctx.Response.ContentType = if ($types.ContainsKey($ext)) { $types[$ext] } else { 'application/octet-stream' }
      $bytes = [IO.File]::ReadAllBytes($path)
    }
    $ctx.Response.ContentLength64 = $bytes.Length
    $ctx.Response.OutputStream.Write($bytes, 0, $bytes.Length)
    $ctx.Response.Close()
  }
} finally { $listener.Stop() }
