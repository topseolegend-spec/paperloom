# Local preview server - site folder ko http://localhost:8080 par serve karta hai.
# Rokne ke liye: is window mein Ctrl+C dabayein.

param([int]$Port = 8080)

$root = Join-Path (Split-Path -Parent $MyInvocation.MyCommand.Path) 'docs'
if (-not (Test-Path $root)) { throw "docs folder nahi mila - pehle build.ps1 chalayein." }

$types = @{
  '.html' = 'text/html; charset=utf-8'; '.css' = 'text/css; charset=utf-8'
  '.js' = 'text/javascript; charset=utf-8'; '.svg' = 'image/svg+xml'
  '.xml' = 'application/xml'; '.txt' = 'text/plain; charset=utf-8'
  '.png' = 'image/png'; '.jpg' = 'image/jpeg'; '.ico' = 'image/x-icon'
}

$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$Port/")
$listener.Start()
Write-Output "Serving $root at http://localhost:$Port/"

while ($listener.IsListening) {
  $ctx = $listener.GetContext()
  $rel = [System.Uri]::UnescapeDataString($ctx.Request.Url.AbsolutePath).TrimStart('/')
  if ($rel -eq '' -or $rel.EndsWith('/')) { $rel += 'index.html' }
  $path = Join-Path $root ($rel -replace '/', '\')
  if ((Test-Path $path -PathType Container)) { $path = Join-Path $path 'index.html' }

  if (Test-Path $path -PathType Leaf) {
    $bytes = [System.IO.File]::ReadAllBytes($path)
    $ext = [System.IO.Path]::GetExtension($path).ToLower()
    $ctx.Response.ContentType = if ($types.ContainsKey($ext)) { $types[$ext] } else { 'application/octet-stream' }
    $ctx.Response.StatusCode = 200
  } else {
    $notFound = Join-Path $root '404.html'
    $bytes = if (Test-Path $notFound) { [System.IO.File]::ReadAllBytes($notFound) } else { [System.Text.Encoding]::UTF8.GetBytes('404') }
    $ctx.Response.ContentType = 'text/html; charset=utf-8'
    $ctx.Response.StatusCode = 404
  }
  $ctx.Response.ContentLength64 = $bytes.Length
  $ctx.Response.OutputStream.Write($bytes, 0, $bytes.Length)
  $ctx.Response.OutputStream.Close()
}

