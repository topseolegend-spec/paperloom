# =============================================================================
#  Paperloom - static site generator
#  Chalane ka tareeqa:   powershell -ExecutionPolicy Bypass -File build.ps1
#  Output "docs" folder mein banta hai - GitHub Pages isi ko serve karta hai.
# =============================================================================

$ErrorActionPreference = 'Stop'
$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
$Out  = Join-Path $Root 'docs'
. (Join-Path $Root 'content.ps1')
. (Join-Path $Root 'content-business.ps1')
. (Join-Path $Root 'content-greeting.ps1')
. (Join-Path $Root 'content-marketing.ps1')
. (Join-Path $Root 'content-education.ps1')
. (Join-Path $Root 'content-personal.ps1')
. (Join-Path $Root 'ornaments.ps1')

# Weddings ke subcategories purane format mein hain - unhein wahi defaults de dein
# jo baaki system expect karta hai.
foreach ($s in $Subcats) {
  if (-not $s.kind)   { $s.kind = 'card' }
  if (-not $s.fields) { $s.fields = $FieldsCard }
  if (-not $s.size)   { $s.size = 'sz-5x7' }
}

$Categories = @(
  @{ meta = $Category;    subs = $Subcats },
  @{ meta = $BizCategory; subs = $BizSubcats },
  @{ meta = $GCategory;   subs = $GSubcats },
  @{ meta = $MCategory;   subs = $MSubcats },
  @{ meta = $ECategory;   subs = $ESubcats },
  @{ meta = $PCategory;   subs = $PSubcats }
)
$AllGuides = @($Guides) + @($BizGuides) + @($GGuides) + @($MGuides) + @($EGuides) + @($PGuides)

$Today = (Get-Date).ToString('yyyy-MM-dd')
$Year  = (Get-Date).Year
# GitHub Pages project site "/paperloom" par serve hoti hai; apne domain par ye khali ho jayega.
$BasePath = ([System.Uri]$Site.Url).AbsolutePath.TrimEnd('/')
$Urls  = New-Object System.Collections.ArrayList

# html2canvas (jo PNG export karta hai) color-mix() parse nahi kar sakta, is liye
# CSS rgba(var(--x-rgb), a) use karti hai. Yahan hex se RGB components nikalte hain.
function HexRgb($hex) {
  $h = "$hex".TrimStart('#')
  if ($h.Length -eq 3) { $h = "$($h[0])$($h[0])$($h[1])$($h[1])$($h[2])$($h[2])" }
  if ($h.Length -lt 6) { return '0,0,0' }
  $r = [Convert]::ToInt32($h.Substring(0,2), 16)
  $g = [Convert]::ToInt32($h.Substring(2,2), 16)
  $b = [Convert]::ToInt32($h.Substring(4,2), 16)
  "$r,$g,$b"
}

function CardVars($t) {
  "--c-bg:$($t.bg);--c-ink:$($t.ink);--c-accent:$($t.accent);--c-soft:$($t.soft);" +
  "--c-accent-rgb:$(HexRgb $t.accent);--c-ink-rgb:$(HexRgb $t.ink);--c-bg-rgb:$(HexRgb $t.bg)"
}

function Write-File($path, $text) {
  $dir = Split-Path -Parent $path
  if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Force $dir | Out-Null }
  [System.IO.File]::WriteAllText($path, $text, (New-Object System.Text.UTF8Encoding($false)))
}

# --- shared chrome -----------------------------------------------------------

function Get-Rel($depth) { if ($depth -gt 0) { '../' * $depth } else { '' } }

function Get-Nav($depth, $current) {
  $r = Get-Rel $depth
  $cHome    = if ($current -eq 'home')    { ' aria-current="page"' } else { '' }
  $cGuides  = if ($current -eq 'guides')  { ' aria-current="page"' } else { '' }
  $cAbout   = if ($current -eq 'about')   { ' aria-current="page"' } else { '' }
  $cContact = if ($current -eq 'contact') { ' aria-current="page"' } else { '' }

  # One dropdown listing the categories, rather than one dropdown each. At six
  # categories a per-category header no longer fits on a line, and search now
  # covers getting to a specific template quickly.
  $cards = ''
  foreach ($cat in $Categories) {
    $m = $cat.meta
    $count = 0
    foreach ($s in $cat.subs) { $count += $s.templates.Count }
    $cards += @"
<a class="dd-cat" href="${r}$($m.slug)/">
              <span class="dd-cat-name">$($m.name)</span>
              <span class="dd-cat-blurb">$($m.blurb)</span>
              <span class="dd-cat-count">$count templates</span>
            </a>
"@
  }
@"
<nav class="nav" aria-label="Main">
        <a class="nav-link" href="$r"$cHome>Home</a>
        <div class="has-dropdown">
          <button class="dropdown-toggle" aria-expanded="false" aria-haspopup="true" data-dd="1">Templates
            <svg class="caret" width="10" height="6" viewBox="0 0 10 6" aria-hidden="true"><path d="M1 1l4 4 4-4" fill="none" stroke="currentColor" stroke-width="1.5"/></svg>
          </button>
          <div class="dropdown-panel dropdown-wide" data-dd-panel="1" hidden>
            <p class="panel-head">Browse by category</p>
            $cards
          </div>
        </div>
        <a class="nav-link" href="${r}guides/"$cGuides>Guides</a>
        <a class="nav-link" href="${r}about/"$cAbout>About</a>
        <a class="nav-link" href="${r}contact/"$cContact>Contact</a>
      </nav>
"@
}

function Get-Header($depth, $current) {
  $r = Get-Rel $depth
  $nav = Get-Nav $depth $current
@"
<header class="site-header">
    <div class="wrap header-inner">
      <a class="brand" href="$r">
        <svg class="brand-mark" viewBox="0 0 32 32" aria-hidden="true">
          <rect x="3" y="5" width="26" height="22" rx="2" fill="none" stroke="#2e5d4b" stroke-width="1.6"/>
          <path d="M3 7l13 10L29 7" fill="none" stroke="#a8823f" stroke-width="1.6"/>
        </svg>
        <span class="brand-name">$($Site.Name)</span>
      </a>
      <button class="search-open" type="button" aria-label="Search templates">
        <svg width="17" height="17" viewBox="0 0 18 18" aria-hidden="true"><circle cx="7.5" cy="7.5" r="5.5" fill="none" stroke="currentColor" stroke-width="1.7"/><path d="M11.5 11.5L16 16" stroke="currentColor" stroke-width="1.7" stroke-linecap="round"/></svg>
      </button>
      <button class="nav-toggle" aria-expanded="false" aria-label="Menu">
        <svg width="20" height="14" viewBox="0 0 20 14" aria-hidden="true"><path d="M0 1h20M0 7h20M0 13h20" stroke="currentColor" stroke-width="1.6"/></svg>
      </button>
      $nav
    </div>
  </header>
"@
}

function Get-Footer($depth) {
  $r = Get-Rel $depth
  $cols = ''
  foreach ($cat in $Categories) {
    $m = $cat.meta
    $links = ($cat.subs | Select-Object -First 5 | ForEach-Object {
      "<li><a href=`"${r}$($m.slug)/$($_.slug)/`">$($_.nav)</a></li>" }) -join ''
    $cols += "<div><h3>$($m.name)</h3><ul>$links<li><a href=`"${r}$($m.slug)/`">See all</a></li></ul></div>"
  }
  $gds = ($AllGuides | ForEach-Object { "<li><a href=`"${r}guides/$($_.slug)/`">$($_.h1)</a></li>" }) -join ''
@"
<footer class="site-footer">
    <div class="wrap">
      <div class="footer-grid">
        <div class="footer-brand">
          <span class="brand-name" style="font-family:var(--display);font-size:21px;">$($Site.Name)</span>
          <p>Printable card and document templates, drawn in-house so every design is free to
             print, share and adapt.</p>
        </div>
        $cols
        <div>
          <h3>Guides</h3>
          <ul>$gds</ul>
        </div>
        <div>
          <h3>Site</h3>
          <ul>
            <li><a href="${r}about/">About</a></li>
            <li><a href="${r}contact/">Contact</a></li>
            <li><a href="${r}privacy-policy/">Privacy policy</a></li>
            <li><a href="${r}terms/">Terms of use</a></li>
          </ul>
        </div>
      </div>
      <div class="footer-bottom">
        <span>&copy; $Year $($Site.Name). All designs drawn in-house.</span>
        <span>$($Site.Tagline)</span>
      </div>
    </div>
  </footer>
"@
}

# Header aur footer sirf depth (aur header ke liye current page) par depend karte
# hain, magar har page ke liye dobara bante the - aur har baar saari categories
# aur subcategories par loop karte the. Do sau pages par ye build ka sabse bara
# hissa ban gaya tha, is liye cache kar diya.
$ChromeCache = @{}

function Get-Chrome($kind, $depth, $current) {
  $key = "$kind|$depth|$current"
  if (-not $ChromeCache.ContainsKey($key)) {
    $ChromeCache[$key] = if ($kind -eq 'header') { Get-Header $depth $current } else { Get-Footer $depth }
  }
  $ChromeCache[$key]
}

function Save-Page($depth, $path, $title, $desc, $body, $current, $extraHead, $extraScripts) {
  $r = Get-Rel $depth
  $canonical = if ($path) { "$($Site.Url)/$path/" } else { "$($Site.Url)/" }
  $header = Get-Chrome 'header' $depth $current
  $footer = Get-Chrome 'footer' $depth ''
  if (-not $extraHead) { $extraHead = '' }
  if (-not $extraScripts) { $extraScripts = '' }
  $html = @"
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>$title</title>
<meta name="description" content="$desc">
<link rel="canonical" href="$canonical">
<meta property="og:type" content="website">
<meta property="og:title" content="$title">
<meta property="og:description" content="$desc">
<meta property="og:url" content="$canonical">
<meta property="og:site_name" content="$($Site.Name)">
<meta property="og:image" content="$($Site.Url)/assets/og-image.png">
<meta property="og:image:width" content="1200">
<meta property="og:image:height" content="630">
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:title" content="$title">
<meta name="twitter:description" content="$desc">
<meta name="twitter:image" content="$($Site.Url)/assets/og-image.png">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link rel="stylesheet" href="$Fonts">
<link rel="stylesheet" href="${r}assets/css/style.css">
<link rel="stylesheet" href="${r}assets/css/cards.css">
<link rel="stylesheet" href="${r}assets/css/docs.css">
<link rel="stylesheet" href="${r}assets/css/promo.css">
<link rel="stylesheet" href="${r}assets/css/school.css">
<link rel="stylesheet" href="${r}assets/css/personal.css">
<link rel="icon" href="${r}assets/favicon.svg" type="image/svg+xml">
$extraHead
</head>
<body data-root="$r">
<a class="skip-link" href="#main">Skip to content</a>
<div class="search-overlay" hidden>
  <div class="search-panel" role="dialog" aria-modal="true" aria-label="Search templates">
    <div class="search-bar">
      <svg width="18" height="18" viewBox="0 0 18 18" aria-hidden="true"><circle cx="7.5" cy="7.5" r="5.5" fill="none" stroke="currentColor" stroke-width="1.7"/><path d="M11.5 11.5L16 16" stroke="currentColor" stroke-width="1.7" stroke-linecap="round"/></svg>
      <input type="search" id="search-input" placeholder="Search templates - CV, invoice, nikah, poster..." autocomplete="off">
      <button type="button" class="search-close" aria-label="Close search">Esc</button>
    </div>
    <div class="search-results" role="listbox" aria-label="Results"></div>
  </div>
</div>
$header
<main id="main">
$body
</main>
$footer
<script src="${r}assets/js/main.js"></script>
<script src="${r}assets/js/search.js" defer></script>
$extraScripts
</body>
</html>
"@
  $file = if ($path) { Join-Path $Out "$path\index.html" } else { Join-Path $Out 'index.html' }
  Write-File $file $html
  [void]$Urls.Add($canonical)
}

function Get-Card($t, $extraClass, $allArt) {
  # Editor pages carry every ornament so the switcher can swap them with no
  # round trip; grid thumbnails carry only the one they use.
  $art = Get-ArtLayer $t $allArt
  $corners = '<span class="corner tl"></span><span class="corner br"></span>'
  $b = $t.body
  $bgs  = if ($t.bgstyle) { $t.bgstyle } else { 'bg-plain' }
  $foil = if ($t.foil) { ' is-foil' } else { '' }
  $note = if ($b.note) { $b.note } else { '' }
  $style = CardVars $t
  if (-not $extraClass) { $extraClass = '' }
@"
<div class="card-preview $($t.design) $($t.font) $bgs sz-5x7$foil $extraClass" style="$style" data-art="$($t.art)">
        <div class="card-art">$art</div>$corners
        <div class="card-body">
          <p class="c-pre" data-field="pre">$($b.pre)</p>
          <p class="c-name" data-field="title">$($b.title)</p>
          <p class="c-mid" data-field="mid">$($b.mid)</p>
          <span class="c-rule"></span>
          <p class="c-date" data-field="date">$($b.date)</p>
          <p class="c-venue" data-field="venue">$($b.venue)</p>
          <p class="c-note" data-field="note">$note</p>
        </div>
      </div>
"@
}

# =============================================================================
#  Document templates (CV, invoice, certificate, business card, letter, menu,
#  letterhead). Cards ki tarah hi: HTML sirf fields ko data-field ke sath rakhta
#  hai, layout poora CSS (docs.css) mein hai.
# =============================================================================

# Ek field ko uske wrapper ke sath likhta hai. Khali field CSS se chhup jati hai.
function Fld($b, $id, $cls, $tag) {
  $v = ''
  if ($b -and $b.ContainsKey($id)) { $v = $b[$id] }
  "<$tag class=`"$cls`" data-field=`"$id`">$v</$tag>"
}

$ArtLayerCache = @{}

function Get-ArtLayer($t, $allArt) {
  if ($allArt) {
    # Editor pages carry every ornament so the switcher can swap them with no
    # round trip. The markup only varies by which one is active, so it is built
    # once per active ornament rather than once per page.
    $key = "all|$($t.art)"
    if (-not $ArtLayerCache.ContainsKey($key)) {
      $ArtLayerCache[$key] = ($ArtKinds | Where-Object { $_.id -ne 'none' } | ForEach-Object {
        $on = if ($_.id -eq $t.art) { ' is-on' } else { '' }
        "<span class=`"art$on`" data-art=`"$($_.id)`">" + (Get-Art $_.id) + '</span>'
      }) -join ''
    }
    return $ArtLayerCache[$key]
  }
  if ($t.art) { return "<span class=`"art is-on`" data-art=`"$($t.art)`">" + (Get-Art $t.art) + '</span>' }
  ''
}

function Doc-Shell($s, $t, $extraClass, $allArt, $inner) {
  $art  = Get-ArtLayer $t $allArt
  $size = if ($s.size) { $s.size } else { 'sz-a4' }
  $bgs  = if ($t.bgstyle) { $t.bgstyle } else { 'bg-plain' }
  $foil = if ($t.foil) { ' is-foil' } else { '' }
  if (-not $extraClass) { $extraClass = '' }
  $style = CardVars $t
  "<div class=`"doc-preview $($t.design) $($t.font) $bgs $size$foil $extraClass`" style=`"$style`" data-art=`"$($t.art)`">" +
  "<div class=`"card-art`">$art</div><div class=`"doc-inner`">$inner</div></div>"
}

function Get-Resume($s, $t, $ec, $aa) {
  $b = $t.body
  $jobs = ''
  foreach ($n in 1..3) {
    $jobs += '<div class="d-item">' + (Fld $b "exp${n}role" 'd-item-t' 'p') +
             (Fld $b "exp${n}meta" 'd-item-m' 'p') + (Fld $b "exp${n}desc" 'd-item-d' 'div') + '</div>'
  }
  $edu = ''
  foreach ($n in 1..2) {
    $edu += '<div class="d-item">' + (Fld $b "edu$n" 'd-item-t' 'p') + (Fld $b "edu${n}meta" 'd-item-m' 'p') + '</div>'
  }
  # Five sections as direct children, so each design can place them with grid
  # (sidebar, split columns) or just stack them (the plain layouts).
  $inner =
    '<header class="d-head">' + (Fld $b 'name' 'd-name' 'p') + (Fld $b 'role' 'd-role' 'p') +
      (Fld $b 'contact' 'd-lines' 'div') + '</header>' +
    '<section class="d-block d-profile">' + (Fld $b 'secProfile' 'd-sec' 'p') +
      '<div class="d-items">' + (Fld $b 'summary' 'd-text' 'p') + '</div></section>' +
    '<section class="d-block d-exp">' + (Fld $b 'secExp' 'd-sec' 'p') +
      "<div class=`"d-items`">$jobs</div></section>" +
    '<section class="d-block d-edu">' + (Fld $b 'secEdu' 'd-sec' 'p') +
      "<div class=`"d-items`">$edu</div></section>" +
    '<section class="d-block d-skills">' + (Fld $b 'secSkills' 'd-sec' 'p') +
      '<div class="d-items">' + (Fld $b 'skills' 'd-lines' 'div') + '</div></section>'
  Doc-Shell $s $t $ec $aa $inner
}

function Get-Letter($s, $t, $ec, $aa) {
  $b = $t.body
  $inner = '<header class="d-head">' + (Fld $b 'name' 'd-name' 'p') + (Fld $b 'role' 'd-role' 'p') +
      (Fld $b 'contact' 'd-lines' 'div') + '</header>' +
    '<div class="l-main">' + (Fld $b 'date' 'l-meta' 'p') + (Fld $b 'recipient' 'l-to' 'div') +
      (Fld $b 'greeting' 'l-greet' 'p') + (Fld $b 'body' 'l-body' 'div') +
      (Fld $b 'signoff' 'l-signoff' 'p') + (Fld $b 'signname' 'l-signname' 'p') + '</div>'
  Doc-Shell $s $t $ec $aa $inner
}

function Get-Cert($s, $t, $ec, $aa) {
  $b = $t.body
  $signs = ''
  foreach ($n in 1..2) {
    $signs += '<div class="ct-sign"><span class="ct-line"></span>' +
              (Fld $b "sign$n" '' 'p') + (Fld $b "sign${n}role" 'ct-role' 'p') + '</div>'
  }
  $inner = (Fld $b 'award' 'ct-award' 'p') + (Fld $b 'pre' 'ct-pre' 'p') + (Fld $b 'name' 'ct-name' 'p') +
    (Fld $b 'reason' 'ct-reason' 'div') + (Fld $b 'date' 'ct-date' 'p') +
    "<div class=`"ct-signs`">$signs</div>"
  Doc-Shell $s $t $ec $aa $inner
}

function Get-Bcard($s, $t, $ec, $aa) {
  $b = $t.body
  $inner = '<div class="bc-main">' + (Fld $b 'name' 'bc-name' 'p') + (Fld $b 'role' 'bc-role' 'p') +
      (Fld $b 'company' 'bc-co' 'p') + (Fld $b 'tagline' 'bc-tag' 'p') + '</div>' +
    '<div class="bc-contact">' + (Fld $b 'phone' '' 'p') + (Fld $b 'email' '' 'p') +
      (Fld $b 'web' '' 'p') + (Fld $b 'address' '' 'p') + '</div>'
  Doc-Shell $s $t $ec $aa $inner
}

function Get-Invoice($s, $t, $ec, $aa) {
  $b = $t.body
  $rows = ''
  foreach ($n in 1..4) {
    $rows += '<div class="iv-row">' + (Fld $b "item$n" '' 'span') + (Fld $b "item${n}amt" 'iv-amt' 'span') + '</div>'
  }
  $inner = '<header class="iv-head"><div>' + (Fld $b 'bizname' 'iv-biz' 'p') + (Fld $b 'bizcontact' 'd-lines' 'div') + '</div>' +
      '<div class="iv-title">' + (Fld $b 'title' '' 'p') + (Fld $b 'number' 'iv-num' 'p') + '</div></header>' +
    '<div class="iv-meta"><div>' + (Fld $b 'clientlabel' 'iv-label' 'p') + (Fld $b 'client' 'd-lines' 'div') + '</div>' +
      '<div class="iv-dates"><p><span class="iv-k">Issued</span> ' + (Fld $b 'date' '' 'span') + '</p>' +
      '<p><span class="iv-k">Due</span> ' + (Fld $b 'due' '' 'span') + '</p></div></div>' +
    "<div class=`"iv-items`">$rows</div>" +
    '<div class="iv-total">' + (Fld $b 'totallabel' 'iv-tl' 'span') + (Fld $b 'total' 'iv-tv' 'span') + '</div>' +
    (Fld $b 'notes' 'iv-notes' 'p')
  Doc-Shell $s $t $ec $aa $inner
}

function Get-Menu($s, $t, $ec, $aa) {
  $b = $t.body
  $secs = ''
  foreach ($n in 1..3) {
    $secs += '<section class="mn-sec">' + (Fld $b "sec$n" 'mn-sec-t' 'p') + (Fld $b "sec${n}items" 'mn-items' 'div') + '</section>'
  }
  $inner = '<header class="mn-head">' + (Fld $b 'restname' 'mn-name' 'p') + (Fld $b 'tagline' 'mn-tag' 'p') + '</header>' +
    $secs + (Fld $b 'footer' 'mn-foot' 'p')
  Doc-Shell $s $t $ec $aa $inner
}

# =============================================================================
#  School documents. Teen mein grid chahiye (timetable, report card,
#  attendance). Har column ek alag area field hai aur sab ka line-height ek -
#  is liye lines aapas mein align ho jati hain, bina har cell ko apna field
#  banaye (jo timetable par chalees fields ban jate).
# =============================================================================

function Get-SchoolHead($b, $titleField, $metaField) {
  '<header class="sc-head">' + (Fld $b $titleField 'sc-title' 'p') +
  (Fld $b $metaField 'sc-meta' 'p') + '</header>'
}

function Get-Worksheet($s, $t, $ec, $aa) {
  $b = $t.body
  $inner = '<div class="school">' +
    (Get-SchoolHead $b 'title' 'meta') +
    (Fld $b 'nameline' 'sc-nameline' 'p') +
    (Fld $b 'instructions' 'sc-instr' 'div') +
    '<div class="ws-items">' + (Fld $b 'items' 'ws-list' 'div') + '</div>' +
    (Fld $b 'footer' 'sc-foot' 'p') +
    '</div>'
  Doc-Shell $s $t $ec $aa $inner
}

function Get-Lesson($s, $t, $ec, $aa) {
  $b = $t.body
  $blocks = ''
  foreach ($pair in @(@('secObj','objectives'), @('secMat','materials'),
                      @('secAct','activities'), @('secAss','assessment'))) {
    $blocks += '<section class="sc-block">' + (Fld $b $pair[0] 'sc-sec' 'p') +
               (Fld $b $pair[1] 'sc-text' 'div') + '</section>'
  }
  $inner = '<div class="school">' +
    (Get-SchoolHead $b 'title' 'meta') +
    '<div class="lp-meta">' + (Fld $b 'date' '' 'span') + (Fld $b 'duration' '' 'span') + '</div>' +
    $blocks + '</div>'
  Doc-Shell $s $t $ec $aa $inner
}

function Get-Timetable($s, $t, $ec, $aa) {
  $b = $t.body
  $cols = '<div class="tt-col tt-times"><span class="tt-h">Time</span>' + (Fld $b 'periods' 'tt-cells' 'div') + '</div>'
  foreach ($d in @(@('mon','Monday'), @('tue','Tuesday'), @('wed','Wednesday'),
                   @('thu','Thursday'), @('fri','Friday'))) {
    $cols += "<div class=`"tt-col`"><span class=`"tt-h`">$($d[1])</span>" + (Fld $b $d[0] 'tt-cells' 'div') + '</div>'
  }
  $inner = '<div class="school">' +
    (Get-SchoolHead $b 'school' 'meta') +
    "<div class=`"tt-grid`">$cols</div>" +
    (Fld $b 'footer' 'sc-foot' 'p') + '</div>'
  Doc-Shell $s $t $ec $aa $inner
}

function Get-Report($s, $t, $ec, $aa) {
  $b = $t.body
  $inner = '<div class="school">' +
    (Get-SchoolHead $b 'school' 'title') +
    '<div class="rc-student">' + (Fld $b 'student' 'rc-name' 'p') +
      '<div class="rc-sub">' + (Fld $b 'cls' '' 'span') + (Fld $b 'term' '' 'span') + '</div></div>' +
    '<div class="rc-table">' +
      '<div class="rc-col"><span class="rc-h">Subject</span>' + (Fld $b 'subjects' 'rc-cells' 'div') + '</div>' +
      '<div class="rc-col rc-num"><span class="rc-h">Marks</span>' + (Fld $b 'marks' 'rc-cells' 'div') + '</div>' +
      '<div class="rc-col rc-num"><span class="rc-h">Grade</span>' + (Fld $b 'grades' 'rc-cells' 'div') + '</div>' +
    '</div>' +
    '<section class="rc-remarks"><span class="rc-h">Remarks</span>' + (Fld $b 'remarks' 'sc-text' 'div') + '</section>' +
    '<div class="rc-sign"><span class="rc-line"></span>' + (Fld $b 'sign1' 'rc-signname' 'p') +
      (Fld $b 'sign1role' 'rc-signrole' 'p') + '</div>' +
    '</div>'
  Doc-Shell $s $t $ec $aa $inner
}

function Get-Attendance($s, $t, $ec, $aa) {
  $b = $t.body
  # Din ke numbers static hain - inhein field banane ka koi faida nahi.
  $days = ''
  foreach ($n in 1..31) { $days += "<span>$n</span>" }
  $inner = '<div class="school">' +
    (Get-SchoolHead $b 'school' 'meta') +
    '<div class="at-grid">' +
      '<div class="at-names"><span class="at-h">Name</span><div class="at-body">' +
        (Fld $b 'names' 'at-cells' 'div') + '</div></div>' +
      "<div class=`"at-days`"><div class=`"at-nums`">$days</div><div class=`"at-ticks`"></div></div>" +
    '</div>' +
    (Fld $b 'footer' 'sc-foot' 'p') + '</div>'
  Doc-Shell $s $t $ec $aa $inner
}

function Get-Flashcard($s, $t, $ec, $aa) {
  $b = $t.body
  $inner = '<div class="flash">' +
    (Fld $b 'tag' 'fc-tag' 'p') +
    (Fld $b 'title' 'fc-term' 'p') +
    (Fld $b 'pron' 'fc-pron' 'p') +
    '<span class="c-rule"></span>' +
    (Fld $b 'definition' 'fc-def' 'div') +
    (Fld $b 'example' 'fc-eg' 'p') +
    '</div>'
  Doc-Shell $s $t $ec $aa $inner
}

function Get-IdCard($s, $t, $ec, $aa) {
  $b = $t.body
  $inner = '<div class="idc">' +
    (Fld $b 'school' 'id-school' 'p') +
    '<div class="id-body">' +
      '<span class="id-photo">Photo</span>' +
      '<div class="id-detail">' + (Fld $b 'title' 'id-name' 'p') +
        '<p class="id-row"><span class="id-k">Class</span>' + (Fld $b 'cls' 'id-v' 'span') + '</p>' +
        '<p class="id-row"><span class="id-k">Roll no</span>' + (Fld $b 'roll' 'id-v' 'span') + '</p>' +
        '<p class="id-row"><span class="id-k">Valid to</span>' + (Fld $b 'valid' 'id-v' 'span') + '</p>' +
      '</div></div>' +
    (Fld $b 'contact' 'id-foot' 'p') +
    '</div>'
  Doc-Shell $s $t $ec $aa $inner
}

function Get-Diploma($s, $t, $ec, $aa) {
  $b = $t.body
  $signs = ''
  foreach ($n in 1..2) {
    $signs += '<div class="ct-sign"><span class="ct-line"></span>' +
              (Fld $b "sign$n" '' 'p') + (Fld $b "sign${n}role" 'ct-role' 'p') + '</div>'
  }
  $inner = (Fld $b 'school' 'ct-school' 'p') + (Fld $b 'award' 'ct-award' 'p') +
    (Fld $b 'pre' 'ct-pre' 'p') + (Fld $b 'name' 'ct-name' 'p') +
    (Fld $b 'reason' 'ct-reason' 'div') + (Fld $b 'date' 'ct-date' 'p') +
    "<div class=`"ct-signs`">$signs</div>"
  Doc-Shell $s $t $ec $aa $inner
}

# =============================================================================
#  Personal &amp; lifestyle documents.
# =============================================================================

function Get-Calendar($s, $t, $ec, $aa) {
  $b = $t.body
  # Din ke numbers yahan nahi likhe jate - editor.js unhein month aur year se
  # nikaalta hai. Yahan sirf khali grid banti hai: 7 columns, 6 rows.
  $heads = ''
  foreach ($d in @('Mon','Tue','Wed','Thu','Fri','Sat','Sun')) { $heads += "<span class=`"cal-h`">$d</span>" }
  $cells = ''
  foreach ($i in 1..42) { $cells += '<span class="cal-cell"></span>' }
  $inner = '<div class="school cal">' +
    '<header class="cal-head">' + (Fld $b 'title' 'cal-title' 'p') +
      '<p class="cal-when">' + (Fld $b 'month' 'cal-month' 'span') + (Fld $b 'year' 'cal-year' 'span') + '</p>' +
    '</header>' +
    "<div class=`"cal-grid`" data-calendar>$heads$cells</div>" +
    (Fld $b 'note' 'sc-foot' 'div') + '</div>'
  Doc-Shell $s $t $ec $aa $inner
}

function Get-Planner($s, $t, $ec, $aa) {
  $b = $t.body
  $inner = '<div class="school">' + (Get-SchoolHead $b 'title' 'meta') +
    '<section class="sc-block"><p class="sc-sec" data-field="secTop">' + $b['secTop'] + '</p>' +
      '<div class="pl-top" data-field="top">' + $b['top'] + '</div></section>' +
    '<section class="sc-block pl-day">' + (Fld $b 'secPlan' 'sc-sec' 'p') +
      '<div class="pl-grid">' +
        '<div class="pl-col pl-times">' + (Fld $b 'times' 'pl-cells' 'div') + '</div>' +
        '<div class="pl-col">' + (Fld $b 'slots' 'pl-cells' 'div') + '</div>' +
      '</div></section>' +
    '<section class="sc-block">' + (Fld $b 'secNotes' 'sc-sec' 'p') +
      (Fld $b 'notes' 'pl-notes' 'div') + '</section></div>'
  Doc-Shell $s $t $ec $aa $inner
}

function Get-Todo($s, $t, $ec, $aa) {
  $b = $t.body
  $inner = '<div class="school">' + (Get-SchoolHead $b 'title' 'meta') +
    '<div class="td-items">' + (Fld $b 'items' 'td-list' 'div') + '</div>' +
    (Fld $b 'footer' 'sc-foot' 'p') + '</div>'
  Doc-Shell $s $t $ec $aa $inner
}

# Income and spending are the same two-column block twice over.
function Get-BudgetBlock($b, $sec, $names, $amounts) {
  '<section class="bd-block">' + (Fld $b $sec 'sc-sec' 'p') +
    '<div class="bd-table">' +
      '<div class="bd-col">' + (Fld $b $names 'bd-cells' 'div') + '</div>' +
      '<div class="bd-col bd-num">' + (Fld $b $amounts 'bd-cells' 'div') + '</div>' +
    '</div></section>'
}

function Get-Budget($s, $t, $ec, $aa) {
  $b = $t.body
  $inner = '<div class="school">' + (Get-SchoolHead $b 'title' 'meta') +
    (Get-BudgetBlock $b 'secIn' 'inNames' 'inAmounts') +
    (Get-BudgetBlock $b 'secOut' 'outNames' 'outAmounts') +
    '<div class="bd-total">' + (Fld $b 'totalLabel' 'bd-tl' 'span') + (Fld $b 'total' 'bd-tv' 'span') + '</div>' +
    (Fld $b 'notes' 'sc-foot' 'div') + '</div>'
  Doc-Shell $s $t $ec $aa $inner
}

function Get-Recipe($s, $t, $ec, $aa) {
  $b = $t.body
  $inner = '<div class="school rp">' +
    '<header class="rp-head">' + (Fld $b 'title' 'rp-title' 'p') + (Fld $b 'meta' 'rp-meta' 'p') + '</header>' +
    '<div class="rp-body">' +
      '<section class="rp-ing">' + (Fld $b 'secIng' 'sc-sec' 'p') + (Fld $b 'ingredients' 'rp-list' 'div') + '</section>' +
      '<section class="rp-method">' + (Fld $b 'secMethod' 'sc-sec' 'p') + (Fld $b 'method' 'rp-steps' 'div') + '</section>' +
    '</div>' + (Fld $b 'note' 'rp-note' 'p') + '</div>'
  Doc-Shell $s $t $ec $aa $inner
}

function Get-Voucher($s, $t, $ec, $aa) {
  $b = $t.body
  $inner = '<div class="vc">' +
    (Fld $b 'business' 'vc-biz' 'p') +
    (Fld $b 'title' 'vc-title' 'p') +
    (Fld $b 'value' 'vc-value' 'p') +
    '<div class="vc-rows">' +
      '<p class="vc-row">' + (Fld $b 'to' 'vc-v' 'span') + '</p>' +
      '<p class="vc-row">' + (Fld $b 'from' 'vc-v' 'span') + '</p>' +
      '<p class="vc-row"><span class="vc-k">Valid until</span>' + (Fld $b 'expiry' 'vc-v' 'span') + '</p>' +
      '<p class="vc-row vc-code"><span class="vc-k">Code</span>' + (Fld $b 'code' 'vc-v' 'span') + '</p>' +
    '</div>' +
    (Fld $b 'terms' 'vc-terms' 'p') + '</div>'
  Doc-Shell $s $t $ec $aa $inner
}

function Get-Habit($s, $t, $ec, $aa) {
  $b = $t.body
  $days = ''
  foreach ($n in 1..31) { $days += "<span>$n</span>" }
  $inner = '<div class="school">' + (Get-SchoolHead $b 'title' 'meta') +
    '<div class="at-grid">' +
      '<div class="at-names"><span class="at-h">Habit</span><div class="at-body">' +
        (Fld $b 'habits' 'at-cells' 'div') + '</div></div>' +
      "<div class=`"at-days`"><div class=`"at-nums`">$days</div><div class=`"at-ticks`"></div></div>" +
    '</div>' + (Fld $b 'footer' 'sc-foot' 'p') + '</div>'
  Doc-Shell $s $t $ec $aa $inner
}

function Get-Meal($s, $t, $ec, $aa) {
  $b = $t.body
  $cols = '<div class="tt-col tt-times"><span class="tt-h">Meal</span>' + (Fld $b 'meals' 'tt-cells' 'div') + '</div>'
  foreach ($d in @(@('mon','Mon'), @('tue','Tue'), @('wed','Wed'), @('thu','Thu'),
                   @('fri','Fri'), @('sat','Sat'), @('sun','Sun'))) {
    $cols += "<div class=`"tt-col`"><span class=`"tt-h`">$($d[1])</span>" + (Fld $b $d[0] 'tt-cells' 'div') + '</div>'
  }
  $inner = '<div class="school ml">' + (Get-SchoolHead $b 'title' 'meta') +
    "<div class=`"tt-grid ml-grid`">$cols</div>" +
    '<section class="ml-list"><span class="rc-h">Shopping list</span>' +
      (Fld $b 'list' 'sc-text' 'div') + '</section></div>'
  Doc-Shell $s $t $ec $aa $inner
}

# Marketing graphics doc-preview par chalte hain: ratio, fit-to-page, ornaments
# aur background treatments sab wahan pehle se hain - sirf sizes naye hain.
function Get-Promo($s, $t, $ec, $aa) {
  $b = $t.body
  $inner = '<div class="promo">' +
    (Fld $b 'kicker' 'pm-kicker' 'p') +
    (Fld $b 'title'  'pm-title'  'p') +
    (Fld $b 'sub'    'pm-sub'    'p') +
    (Fld $b 'body'   'pm-body'   'div') +
    '<div class="pm-foot">' + (Fld $b 'cta' 'pm-cta' 'p') + (Fld $b 'brand' 'pm-brand' 'p') + '</div>' +
    '</div>'
  Doc-Shell $s $t $ec $aa $inner
}

function Get-Logo($s, $t, $ec, $aa) {
  $b = $t.body
  $inner = '<div class="logo">' +
    '<span class="lg-mark-wrap">' + (Fld $b 'mark' 'lg-mark' 'span') + '</span>' +
    (Fld $b 'title'   'lg-name' 'p') +
    (Fld $b 'tagline' 'lg-tag'  'p') +
    (Fld $b 'est'     'lg-est'  'p') +
    '</div>'
  Doc-Shell $s $t $ec $aa $inner
}

# Greeting cards card-preview par chalte hain (documents nahi), magar fields
# alag hain: bara greeting, message, aur To/From - date/venue nahi.
function Get-Greeting($s, $t, $ec, $aa) {
  $b = $t.body
  $art = Get-ArtLayer $t $aa
  $bgs  = if ($t.bgstyle) { $t.bgstyle } else { 'bg-plain' }
  $foil = if ($t.foil) { ' is-foil' } else { '' }
  $size = if ($s.size) { $s.size } else { 'sz-5x7' }
  if (-not $ec) { $ec = '' }
  $style = CardVars $t
@"
<div class="card-preview is-greeting $($t.design) $($t.font) $bgs $size$foil $ec" style="$style" data-art="$($t.art)">
        <div class="card-art">$art</div>
        <div class="card-body">
          $(Fld $b 'pre' 'g-pre' 'p')
          $(Fld $b 'title' 'g-title' 'p')
          <span class="c-rule"></span>
          $(Fld $b 'mid' 'g-msg' 'div')
          <div class="g-sign">
            $(Fld $b 'to' 'g-to' 'p')
            $(Fld $b 'from' 'g-from' 'p')
          </div>
        </div>
      </div>
"@
}

function Get-Letterhead($s, $t, $ec, $aa) {
  $b = $t.body
  $inner = '<header class="lh-head"><div>' + (Fld $b 'company' 'lh-co' 'p') + (Fld $b 'tagline' 'lh-tag' 'p') + '</div>' +
      '<div class="lh-meta">' + (Fld $b 'address' 'd-lines' 'div') + (Fld $b 'contact' 'd-lines' 'div') + '</div></header>' +
    '<div class="lh-body"></div>' + (Fld $b 'footer' 'lh-foot' 'p')
  Doc-Shell $s $t $ec $aa $inner
}

# Subcategory ke kind ke hisaab se sahi renderer chunta hai.
function Get-Preview($s, $t, $extraClass, $allArt) {
  $kind = if ($s.kind) { $s.kind } else { 'card' }
  switch ($kind) {
    'resume'     { Get-Resume $s $t $extraClass $allArt }
    'letter'     { Get-Letter $s $t $extraClass $allArt }
    'cert'       { Get-Cert $s $t $extraClass $allArt }
    'bcard'      { Get-Bcard $s $t $extraClass $allArt }
    'invoice'    { Get-Invoice $s $t $extraClass $allArt }
    'menu'       { Get-Menu $s $t $extraClass $allArt }
    'letterhead' { Get-Letterhead $s $t $extraClass $allArt }
    'greeting'   { Get-Greeting $s $t $extraClass $allArt }
    'promo'      { Get-Promo $s $t $extraClass $allArt }
    'logo'       { Get-Logo $s $t $extraClass $allArt }
    'worksheet'  { Get-Worksheet $s $t $extraClass $allArt }
    'lesson'     { Get-Lesson $s $t $extraClass $allArt }
    'timetable'  { Get-Timetable $s $t $extraClass $allArt }
    'report'     { Get-Report $s $t $extraClass $allArt }
    'attendance' { Get-Attendance $s $t $extraClass $allArt }
    'flashcard'  { Get-Flashcard $s $t $extraClass $allArt }
    'idcard'     { Get-IdCard $s $t $extraClass $allArt }
    'diploma'    { Get-Diploma $s $t $extraClass $allArt }
    'calendar'   { Get-Calendar $s $t $extraClass $allArt }
    'planner'    { Get-Planner $s $t $extraClass $allArt }
    'todo'       { Get-Todo $s $t $extraClass $allArt }
    'budget'     { Get-Budget $s $t $extraClass $allArt }
    'recipe'     { Get-Recipe $s $t $extraClass $allArt }
    'voucher'    { Get-Voucher $s $t $extraClass $allArt }
    'habit'      { Get-Habit $s $t $extraClass $allArt }
    'meal'       { Get-Meal $s $t $extraClass $allArt }
    default      { Get-Card $t $extraClass $allArt }
  }
}

function Get-Crumbs($depth, $trail) {
  $r = Get-Rel $depth
  $parts = @("<a href=`"$r`">Home</a>")
  for ($i = 0; $i -lt $trail.Count - 1; $i++) {
    $parts += "<a href=`"$r$($trail[$i][1])`">$($trail[$i][0])</a>"
  }
  $parts += "<span aria-current=`"page`">$($trail[$trail.Count-1][0])</span>"
  $nav = '<div class="wrap"><nav class="crumbs" aria-label="Breadcrumb">' + ($parts -join '<span>/</span>') + '</nav></div>'

  # BreadcrumbList JSON-LD from the same trail, so the path shown on the page and
  # the one Google can render under the search result never drift apart. Hrefs in
  # $trail are already root-relative, so they only need the site origin.
  $items = @(); $pos = 1
  $items += "{`"@type`":`"ListItem`",`"position`":$pos,`"name`":`"Home`",`"item`":`"$($Site.Url)/`"}"
  for ($i = 0; $i -lt $trail.Count - 1; $i++) {
    $pos++
    $items += "{`"@type`":`"ListItem`",`"position`":$pos,`"name`":$(ConvertTo-JsonString $trail[$i][0]),`"item`":`"$($Site.Url)/$($trail[$i][1])`"}"
  }
  $pos++
  $items += "{`"@type`":`"ListItem`",`"position`":$pos,`"name`":$(ConvertTo-JsonString $trail[$trail.Count-1][0])}"
  $schema = '<script type="application/ld+json">{"@context":"https://schema.org","@type":"BreadcrumbList","itemListElement":[' + ($items -join ',') + ']}</script>'

  $nav + $schema
}

function ConvertTo-JsonString($s) {
  $t = [regex]::Replace($s, '<[^>]+>', '')
  $t = $t.Replace('&amp;', '&').Replace('&middot;', '-').Replace('&times;', 'x')
  '"' + $t.Replace('\', '\\').Replace('"', '\"') + '"'
}

function Get-FaqSchema($faq) {
  $items = ($faq | ForEach-Object {
    '{"@type":"Question","name":' + (ConvertTo-JsonString $_[0]) +
    ',"acceptedAnswer":{"@type":"Answer","text":' + (ConvertTo-JsonString $_[1]) + '}}' }) -join ','
  '<script type="application/ld+json">{"@context":"https://schema.org","@type":"FAQPage","mainEntity":[' + $items + ']}</script>'
}

# --- pages -------------------------------------------------------------------

function Build-Home {
  # Har category ke pehle template ka preview, taake home page par dono
  # duniyaon ka namoona dikhe - card bhi, document bhi.
  $fan = ''
  $letters = @('a','b','c')
  # All three portrait: a CV, an invitation and a poster. The old third pick was
  # a landscape certificate, which at a shared height ran half again as wide as
  # the other two and broke the fan.
  $picks = @(
    @{ s=$Categories[1].subs[0]; t=$Categories[1].subs[0].templates[0] },
    @{ s=$Categories[0].subs[0]; t=$Categories[0].subs[0].templates[1] },
    @{ s=$Categories[3].subs[0]; t=$Categories[3].subs[0].templates[3] }
  )
  for ($i = 0; $i -lt 3; $i++) {
    $fan += Get-Preview $picks[$i].s $picks[$i].t "fan-$($letters[$i])" $false
  }

  # Each category gets its own band: its own accent, three real previews drawn
  # from its own templates, and every subcategory as a link. Six identical grids
  # of text tiles read as one long undifferentiated list - the previews are what
  # tell a reader at a glance that school worksheets are not wedding cards.
  $collectionCards = ''
  $catBlocks = ''
  $ci = 0
  foreach ($cat in $Categories) {
    $m = $cat.meta
    $ci++
    $catTemplates = 0
    foreach ($s in $cat.subs) { $catTemplates += $s.templates.Count }

    $collectionCards += @"
<a class="coll-card" href="$($m.slug)/" style="--coll:$($m.accent);">
          <span class="coll-rule"></span>
          <span class="coll-name">$($m.name)</span>
          <span class="coll-blurb">$($m.blurb)</span>
          <span class="coll-meta">$catTemplates templates &middot; $($cat.subs.Count) types</span>
        </a>
"@

    # three previews, spread across the category rather than all from one
    # subcategory, so the row shows the range instead of one design three times
    $spread = @(0, [math]::Floor($cat.subs.Count / 3), [math]::Floor($cat.subs.Count * 2 / 3))
    $shots = ''
    for ($k = 0; $k -lt 3; $k++) {
      $sub = $cat.subs[$spread[$k]]
      $tpl = $sub.templates[[math]::Min($k, $sub.templates.Count - 1)]
      $shots += @"
<a class="shot" href="$($m.slug)/$($sub.slug)/$($tpl.slug)/">
          <span class="shot-frame">$(Get-Preview $sub $tpl '' $false)</span>
          <span class="shot-label">$($sub.nav)</span>
        </a>
"@
    }

    $chips = ($cat.subs | ForEach-Object {
      "<a class=`"chip`" href=`"$($m.slug)/$($_.slug)/`">$($_.nav) <span>$($_.templates.Count)</span></a>" }) -join ''

    $alt = if ($ci % 2 -eq 0) { ' cat-band-alt' } else { '' }
    $catBlocks += @"
<section class="section cat-band$alt" style="--coll:$($m.accent);">
    <div class="wrap">
      <div class="cat-band-head">
        <div>
          <p class="eyebrow coll-eyebrow">$catTemplates templates &middot; $($cat.subs.Count) types</p>
          <h2>$($m.name)</h2>
          <p class="cat-band-blurb">$($m.blurb)</p>
        </div>
        <a class="cat-band-all" href="$($m.slug)/">All $($m.short.ToLower()) templates &rarr;</a>
      </div>
      <div class="shot-row">$shots</div>
      <div class="chip-row">$chips</div>
    </div>
  </section>

"@
  }

  # Guides are reading, not templates, so they get a different shape entirely -
  # a dark band of titled rows rather than a fourth grid of pale cards, which is
  # what made this section indistinguishable from the six above it.
  $guides = ($AllGuides | ForEach-Object {
@"
<a class="guide-row" href="guides/$($_.slug)/">
          <span class="guide-title">$($_.h1)</span>
          <span class="guide-read">$($_.read)</span>
        </a>
"@ }) -join ''

  $totalTemplates = 0
  foreach ($cat in $Categories) { foreach ($s in $cat.subs) { $totalTemplates += $s.templates.Count } }

  $body = @"
<section class="hero">
    <div class="wrap hero-grid">
      <div>
        <p class="eyebrow">Free editable templates</p>
        <h1>Type your details. Print it tonight.</h1>
        <p class="lede">$totalTemplates designs across six collections - CVs and invoices, wedding and
          nikah invitations, greeting cards, posters and social posts, school worksheets and reports,
          calendars and planners. Fill in the boxes beside the page and it updates as you type. No
          account, no watermark, no download queue.</p>
        <div class="hero-actions">
          <a class="btn btn-primary" href="$($Categories[1].meta.slug)/$($Categories[1].subs[0].slug)/">Start with a CV</a>
          <a class="btn btn-ghost" href="#collections">See all six collections</a>
        </div>
        <div class="pill-row">
          <span class="pill">Edit in your browser</span>
          <span class="pill">&#1575;&#1585;&#1583;&#1608; &amp; &#1593;&#1585;&#1576;&#1740; supported</span>
          <span class="pill">Print ready at 300dpi</span>
        </div>
      </div>
      <div class="hero-fan">$fan</div>
    </div>
  </section>

  <section class="section collections" id="collections">
    <div class="wrap">
      <div class="section-head">
        <p class="eyebrow">Six collections</p>
        <h2>Start where your document lives</h2>
        <p>Every collection is editable the same way. What changes is the paper it is set for -
          a 5&times;7 card, an A4 sheet, or a 1080 pixel square.</p>
      </div>
      <div class="coll-grid">$collectionCards</div>
    </div>
  </section>

  $catBlocks
  <section class="section guides-band">
    <div class="wrap">
      <div class="guides-head">
        <div>
          <p class="eyebrow">Guides</p>
          <h2>Before you print</h2>
          <p>The wording is usually harder than the design. Fifteen short guides on what belongs on
            a CV, how to word an invitation, and what makes an invoice get paid on time.</p>
        </div>
        <a class="guides-all" href="guides/">All guides &rarr;</a>
      </div>
      <div class="guide-list">$guides</div>
    </div>
  </section>

  <section class="section">
    <div class="wrap">
      <div class="section-head">
        <h2>What you can do here that you cannot do elsewhere</h2>
        <p>Most template sites make you create an account before you can change a single word. None
          of this needs one.</p>
      </div>
      <div class="feature-grid">
        <div class="feature">
          <h3>Fill in a form, not a design tool</h3>
          <p>Labelled boxes beside the page - Names, Date, Venue, or Job title and Experience. The
            page updates as you type, and your work is kept in your browser.</p>
        </div>
        <div class="feature">
          <h3>&#1575;&#1585;&#1583;&#1608; and &#1593;&#1585;&#1576;&#1740;, properly set</h3>
          <p>Switch to Nastaliq, Amiri or Naskh and the whole layout flips to right-to-left with the
            line spacing those scripts actually need.</p>
        </div>
        <div class="feature">
          <h3>Sixteen palettes, sixteen faces</h3>
          <p>Or set the exact background, text and accent colours to match a theme, a brand, or a
            wedding you have already planned around.</p>
        </div>
        <div class="feature">
          <h3>Share without an account</h3>
          <p>One button turns your edited page into a link. Whoever opens it sees your version -
            neither of you signs up for anything.</p>
        </div>
        <div class="feature">
          <h3>Print size, no watermark</h3>
          <p>Download at 300dpi, or print straight to PDF. Nothing is stamped, nothing is held back
            behind a paid tier.</p>
        </div>
        <div class="feature">
          <h3>Nothing borrowed</h3>
          <p>Every design is drawn here in code rather than assembled from stock images, so there is
            no licence attached to anything you print.</p>
        </div>
      </div>
    </div>
  </section>
"@
  # Organization + WebSite on the homepage only - schema.org asks for one
  # canonical declaration of "what this site is" per site, not one per page.
  # SearchAction points at the real on-site search, which is accurate now that
  # search.js exists - this is what makes Google's sitelinks search box
  # possible, not just decorative markup.
  $orgSchema = '<script type="application/ld+json">{"@context":"https://schema.org","@graph":[' +
    '{"@type":"Organization","@id":"' + $Site.Url + '/#org","name":"' + $Site.Name + '","url":"' + $Site.Url + '/","logo":"' + $Site.Url + '/assets/og-image.png"},' +
    '{"@type":"WebSite","@id":"' + $Site.Url + '/#site","name":"' + $Site.Name + '","url":"' + $Site.Url + '/","publisher":{"@id":"' + $Site.Url + '/#org"},' +
    '"potentialAction":{"@type":"SearchAction","target":"' + $Site.Url + '/?q={search_term_string}","query-input":"required name=search_term_string"}}' +
    ']}</script>'

  Save-Page 0 '' "$($Site.Name) - Free Editable CV, Invoice &amp; Invitation Templates" `
    'Free editable templates: CVs, invoices, invitations, greeting cards and posters. Fill in, print or download - no account, no watermark.' `
    $body 'home' $orgSchema ''
}

function Build-Category($cat) {
  $m = $cat.meta
  $tiles = ($cat.subs | ForEach-Object {
@"
<a class="cat-tile" href="$($_.slug)/">
          <h3>$($_.name)</h3>
          <p>$(($_.desc -split '\.')[0]).</p>
          <span class="count">$($_.templates.Count) templates</span>
        </a>
"@ }) -join ''

  $previews = ''
  foreach ($s in ($cat.subs | Select-Object -First 4)) {
    $t = $s.templates[0]
    $previews += "<a class=`"tpl-item`" href=`"$($s.slug)/$($t.slug)/`">" + (Get-Preview $s $t '' $false) +
      "<span class=`"tpl-meta`"><span class=`"name`">$($t.name)</span><span class=`"sub`">$($s.name)</span></span></a>"
  }

  $intro = ($m.intro | ForEach-Object { "<p>$_</p>" }) -join ''
  $crumb = Get-Crumbs 1 @(,@($m.name, "$($m.slug)/"))

  $body = @"
$crumb
  <section class="section" style="padding-top:26px;">
    <div class="wrap">
      <p class="eyebrow">Category</p>
      <h1>$($m.h1)</h1>
      <div class="prose" style="margin-top:16px;">$intro</div>
    </div>
  </section>
  <section class="section" style="padding-top:0;">
    <div class="wrap">
      <div class="section-head"><h2>$($m.panel)</h2></div>
      <div class="cat-grid">$tiles</div>
    </div>
  </section>
  <section class="section" style="background:var(--surface-2);border-top:1px solid var(--line);">
    <div class="wrap">
      <div class="section-head"><h2>A few designs from the collection</h2></div>
      <div class="tpl-grid">$previews</div>
    </div>
  </section>
"@
  Save-Page 1 $m.slug $m.title $m.desc $body '' '' ''
}

function Build-Subcat($cat, $s) {
  $m = $cat.meta
  $grid = ($s.templates | ForEach-Object {
    "<a class=`"tpl-item`" href=`"$($_.slug)/`">" + (Get-Preview $s $_ '' $false) +
    "<span class=`"tpl-meta`"><span class=`"name`">$($_.name)</span><span class=`"sub`">$($_.style)</span></span></a>"
  }) -join ''

  $intro  = ($s.intro | ForEach-Object { "<p>$_</p>" }) -join ''
  # A hand-written closing line linking to the guide that covers this document
  # type. Written per subcategory rather than generated, because twenty pages
  # carrying the same "read our guide" sentence reads as filler to a person and
  # as a footprint to a search engine.
  if ($s.guideNote) { $intro += "<p>$($s.guideNote)</p>" }
  $faqs   = ($s.faq | ForEach-Object { "<details><summary>$($_[0])</summary><p>$($_[1])</p></details>" }) -join ''
  $others = ($cat.subs | Where-Object { $_.slug -ne $s.slug } | ForEach-Object {
    "<li><a href=`"../$($_.slug)/`">$($_.name)</a></li>" }) -join ''
  $crumb  = Get-Crumbs 2 @(@($m.name, "$($m.slug)/"), @($s.name, ''))

  $body = @"
$crumb
  <section class="section" style="padding:26px 0 40px;">
    <div class="wrap">
      <p class="eyebrow">$($m.name)</p>
      <h1>$($s.h1)</h1>
      <div class="prose" style="margin-top:16px;">$intro</div>
    </div>
  </section>
  <section class="section" style="padding-top:0;">
    <div class="wrap"><div class="tpl-grid">$grid</div></div>
  </section>
  <section class="section" style="background:var(--surface-2);border-top:1px solid var(--line);">
    <div class="wrap-narrow">
      <div class="section-head"><h2>Common questions</h2></div>
      <div class="faq">$faqs</div>
    </div>
  </section>
  <section class="section">
    <div class="wrap">
      <div class="section-head"><h2>More in $($m.name)</h2></div>
      <ul class="link-list">$others</ul>
    </div>
  </section>
"@
  Save-Page 2 "$($m.slug)/$($s.slug)" $s.title $s.desc $body '' (Get-FaqSchema $s.faq) ''
}

# Editor ka form subcategory ke fields se banta hai, groups ke hisaab se.
function Get-EditorForm($s) {
  $fields = if ($s.fields) { $s.fields } else { $FieldsCard }
  $groups = New-Object System.Collections.Specialized.OrderedDictionary
  foreach ($f in $fields) {
    if (-not $groups.Contains($f.group)) { $groups[$f.group] = New-Object System.Collections.ArrayList }
    [void]$groups[$f.group].Add($f)
  }

  $single = $groups.Count -le 1
  $out = ''
  $i = 0
  foreach ($g in $groups.Keys) {
    $i++
    $rows = ''
    foreach ($f in $groups[$g]) {
      $hint = if ($f.hint) { " <span class=`"sub`">$($f.hint)</span>" } else { '' }
      $ctl = if ($f.type -eq 'area') {
        "<textarea id=`"ed-text-$($f.id)`" data-text=`"$($f.id)`"></textarea>"
      } else {
        "<input type=`"text`" id=`"ed-text-$($f.id)`" data-text=`"$($f.id)`" autocomplete=`"off`">"
      }
      $rows += "<div class=`"ed-field`"><label for=`"ed-text-$($f.id)`">$($f.label)$hint</label>$ctl</div>"
    }
    if ($single) {
      $out += "<div class=`"ed-fields`">$rows</div>"
    } else {
      $open = if ($i -le 2) { ' open' } else { '' }
      $out += "<details class=`"ed-group-box`"$open><summary>$g</summary><div class=`"ed-fields`">$rows</div></details>"
    }
  }
  $out
}

function Build-Template($cat, $s, $t) {
  $m = $cat.meta
  $kind = if ($s.kind) { $s.kind } else { 'card' }
  $showArt = ($kind -eq 'card') -or $s.ornaments

  $related = ($s.templates | Where-Object { $_.slug -ne $t.slug } | ForEach-Object {
    "<a class=`"tpl-item`" href=`"../$($_.slug)/`">" + (Get-Preview $s $_ '' $false) +
    "<span class=`"tpl-meta`"><span class=`"name`">$($_.name)</span><span class=`"sub`">$($_.style)</span></span></a>"
  }) -join ''

  $swatches = ($Palettes | ForEach-Object {
    $f = if ($_.foil) { '1' } else { '0' }
    "<button class=`"ed-swatch`" type=`"button`" title=`"$($_.name)`" aria-label=`"$($_.name)`" aria-pressed=`"false`" data-swatch=`"$($_.bg),$($_.ink),$($_.accent),$f`"><span style=`"background:$($_.bg)`"></span><span style=`"background:$($_.accent)`"></span></button>"
  }) -join ''

  $fontChips = ($FontChoices | ForEach-Object {
    "<button class=`"ed-chip`" type=`"button`" aria-pressed=`"false`" data-font=`"$($_.cls)`">$($_.label)</button>"
  }) -join ''

  $bgChips = ($BgChoices | ForEach-Object {
    "<button class=`"ed-chip`" type=`"button`" aria-pressed=`"false`" data-bg=`"$($_.cls)`">$($_.label)</button>"
  }) -join ''

  # Marketing formats ke sizes kind se nahi, subcategory se aate hain - ek
  # poster ko 1584x396 LinkedIn banner offer karna bemani hoga.
  $setName = if ($s.sizeset) { $s.sizeset } else { $SizeSetFor[$kind] }
  $sizes = $SizeSets[$setName]
  $sizeChips = ($sizes | ForEach-Object {
    "<button class=`"ed-chip ed-chip-wide`" type=`"button`" aria-pressed=`"false`" data-size=`"$($_.cls)`">$($_.label)<span class=`"sub`">$($_.note)</span></button>"
  }) -join ''

  $artStep = ''
  if ($showArt) {
    $artChips = ($ArtKinds | ForEach-Object {
      "<button class=`"ed-chip`" type=`"button`" aria-pressed=`"false`" data-art=`"$($_.id)`">$($_.label)</button>"
    }) -join ''
    $artStep = "<p class=`"ed-label`" style=`"margin-bottom:10px;`">Ornament</p><div class=`"ed-chips`">$artChips</div><p class=`"ed-label`" style=`"margin:16px 0 10px;`">Background</p>"
  } else {
    $artStep = "<p class=`"ed-label`" style=`"margin-bottom:10px;`">Background</p>"
  }

  $noun = if ($kind -eq 'card') { 'card' } elseif ($kind -eq 'bcard') { 'card' } else { 'page' }
  $form = Get-EditorForm $s
  # Only ship the whole ornament set when there is a switcher to use it - on a
  # LinkedIn banner those eleven hidden SVGs were half the page weight.
  $preview = Get-Preview $s $t '' $showArt

  # "CV &amp; Resume Templates" -> "CV &amp; Resume", "Wedding Invitations" -> "Wedding Invitation".
  # Without the first case the title reads "... Template Template".
  # A subcategory with a long name ("Farewell & Retirement Invitations") pushes
  # every template title in it past the ~60 characters Google will show, so it
  # can name a shorter word to be titled by without changing its own heading.
  if ($s.singular) { $singular = $s.singular }
  else {
    $singular = $s.name
    if ($singular -match '\s+Templates?$') { $singular = $singular -replace '\s+Templates?$', '' }
    else { $singular = $singular -replace 's$', '' }
  }
  $title = "$($t.name) - $singular Template"
  # Was "an editable {x} template in a {y} style. Fill it in online, then print or
  # download - free, no account." - on a subcategory with a long name (like
  # Farewell & Retirement Invitations) that pushed several descriptions past
  # Google's ~160 character display limit. Shorter fixed wording buys back the
  # room the variable parts need.
  $descStyle = ($t.style -replace '&middot;', ',').ToLower()
  $desc = "$($t.name): $descStyle $($singular.ToLower()) template - fill in online, print or download free."
  $crumb = Get-Crumbs 3 @(@($m.name, "$($m.slug)/"), @($s.name, "$($m.slug)/$($s.slug)/"), @($t.name, ''))

  $body = @"
$crumb
  <div class="wrap">
    <div class="detail-grid">
      <div>
        <p class="stage-hint">
          <svg width="15" height="15" viewBox="0 0 16 16" aria-hidden="true"><path d="M11.5 1.5l3 3L5 14H2v-3z" fill="none" stroke="currentColor" stroke-width="1.4" stroke-linejoin="round"/></svg>
          Fill in the boxes and the $noun updates as you type - or click a line on the $noun itself.
        </p>
        <p class="ed-fit-note" hidden></p>
        <div class="detail-stage" data-template="$($t.slug)">$preview</div>
      </div>
      <div class="detail-side">
        <div class="editor-panel">
          <p class="eyebrow">$($s.name)</p>
          <h1 style="font-size:30px;">$($t.name)</h1>
          <p class="form-note" style="margin:8px 0 28px;">$($t.style) &middot; free to print, no account needed</p>

          <div class="ed-step">
            <div class="ed-step-head"><span class="ed-step-num">1</span><h2>Fill in your details</h2></div>
            $form
          </div>

          <div class="ed-step">
            <div class="ed-step-head"><span class="ed-step-num">2</span><h2>Pick your colours</h2></div>
            <div class="ed-swatches">$swatches</div>
            <p class="ed-label" style="margin:18px 0 10px;">Or choose exactly</p>
            <div class="ed-colors">
              <label class="ed-color"><span>Background</span><input type="color" id="ed-bg"></label>
              <label class="ed-color"><span>Text</span><input type="color" id="ed-ink"></label>
              <label class="ed-color"><span>Accent</span><input type="color" id="ed-accent"></label>
            </div>
            <label class="ed-toggle">
              <input type="checkbox" id="ed-foil">
              <span>Metallic foil finish</span>
            </label>
          </div>

          <div class="ed-step">
            <div class="ed-step-head"><span class="ed-step-num">3</span><h2>Choose the lettering</h2></div>
            <p class="ed-label" style="margin-bottom:10px;">
              <span class="hint">Urdu and Arabic switch to right-to-left</span></p>
            <div class="ed-chips">$fontChips</div>
            <div class="ed-slider">
              <label for="ed-size">Name size</label>
              <input type="range" id="ed-size" min="60" max="150" step="5" value="100">
              <output for="ed-size" id="ed-size-out">100%</output>
            </div>
          </div>

          <div class="ed-step">
            <div class="ed-step-head"><span class="ed-step-num">4</span><h2>Decoration</h2></div>
            $artStep
            <div class="ed-chips">$bgChips</div>
          </div>

          <div class="ed-step">
            <div class="ed-step-head"><span class="ed-step-num">5</span><h2>Page size</h2></div>
            <div class="ed-chips">$sizeChips</div>
          </div>

          <div class="ed-step">
            <div class="ed-step-head"><span class="ed-step-num">6</span><h2>Save it</h2></div>
            <div class="ed-actions">
              <button class="btn btn-primary" type="button" data-png>Download PNG</button>
              <div class="ed-row">
                <button class="btn btn-ghost" type="button" data-print>Print / PDF</button>
                <button class="btn btn-ghost" type="button" data-share>Copy link</button>
              </div>
              <div class="ed-row">
                <button class="btn btn-ghost" type="button" data-undo disabled>Undo</button>
                <button class="btn btn-ghost" type="button" data-reset>Start over</button>
              </div>
            </div>
            <p class="ed-status" role="status"></p>
            <p class="form-note" style="margin-top:14px;">Your changes are kept in this browser.
              Copy link turns them into a link you can send to anyone - no sign-up on either side.</p>
          </div>
        </div>
      </div>
    </div>
  </div>
  <section class="section" style="background:var(--surface-2);border-top:1px solid var(--line);margin-top:40px;">
    <div class="wrap">
      <div class="section-head"><h2>More $($s.name.ToLower())</h2></div>
      <div class="tpl-grid">$related</div>
    </div>
  </section>
"@
  $head = "<link rel=`"stylesheet`" href=`"../../../assets/css/editor.css`">`n<link rel=`"stylesheet`" href=`"$FontsExtra`">"
  $scripts = "<script src=`"https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js`" defer></script>`n<script src=`"../../../assets/js/editor.js`" defer></script>"
  Save-Page 3 "$($m.slug)/$($s.slug)/$($t.slug)" $title $desc $body '' $head $scripts
}

function Build-GuidesIndex {
  $tiles = ($AllGuides | ForEach-Object {
@"
<a class="cat-tile" href="$($_.slug)/">
          <h3>$($_.h1)</h3>
          <p>$($_.desc)</p>
          <span class="count">$($_.read)</span>
        </a>
"@ }) -join ''
  $crumb = Get-Crumbs 1 @(,@('Guides', 'guides/'))
  $body = @"
$crumb
  <section class="section" style="padding-top:26px;">
    <div class="wrap">
      <p class="eyebrow">Guides</p>
      <h1>Guides</h1>
      <p class="lede" style="margin-top:14px;">Practical answers to the questions that come up while
        you are filling a template in - what belongs on a CV, how to word an invitation, and what
        makes an invoice get paid on time.</p>
      <div class="section-head" style="margin-top:32px;"><h2>All guides</h2></div>
      <div class="cat-grid">$tiles</div>
    </div>
  </section>
"@
  Save-Page 1 'guides' 'Template Guides - CVs, Invoices and Invitations' `
    'Practical guides on what to include in a CV, how to write an invoice that gets paid, when to send wedding invitations and how to word them.' `
    $body 'guides' '' ''
}

function Build-Guide($g) {
  $parts = ''
  # Collected rather than rendered inline, so a guide naming several relevant
  # subcategories (social-media-image-sizes covers seven platforms) links to
  # all of them in one line instead of one repetitive banner per mention.
  $ctaSlugs = New-Object System.Collections.ArrayList
  foreach ($blk in $g.body) {
    $kind = $blk[0]; $val = $blk[1]
    switch ($kind) {
      'p'  { $parts += "<p>$val</p>" }
      'h2' { $parts += "<h2>$val</h2>" }
      'ul' { $parts += '<ul>' + (($val | ForEach-Object { "<li>$_</li>" }) -join '') + '</ul>' }
      'ol' { $parts += '<ol>' + (($val | ForEach-Object { "<li>$_</li>" }) -join '') + '</ol>' }
      'blockquote' { $parts += "<blockquote><p>$val</p></blockquote>" }
      'cta' { [void]$ctaSlugs.Add($val) }
    }
  }
  if ($ctaSlugs.Count -gt 0) {
    $links = New-Object System.Collections.ArrayList
    foreach ($slug in $ctaSlugs) {
      foreach ($cat in $Categories) {
        $sub = $cat.subs | Where-Object { $_.slug -eq $slug }
        if ($sub) { [void]$links.Add("<a href=`"../../$($cat.meta.slug)/$($sub.slug)/`">$($sub.name.ToLower())</a> ($($sub.templates.Count) designs)") }
      }
    }
    if ($links.Count -eq 1) {
      $parts += "<div class=`"note-band`" style=`"margin-top:34px;`">Ready to make one? Open the $($links[0]) - free to use.</div>"
    } elseif ($links.Count -gt 1) {
      $last = $links[$links.Count - 1]
      $rest = $links[0..($links.Count - 2)] -join ', '
      $parts += "<div class=`"note-band`" style=`"margin-top:34px;`">Ready to make one? This applies across $rest and $last - all free to use.</div>"
    }
  }
  $schema = '<script type="application/ld+json">{"@context":"https://schema.org","@type":"Article","headline":' +
    (ConvertTo-JsonString $g.h1) + ',"description":' + (ConvertTo-JsonString $g.desc) +
    ',"datePublished":"' + $Today + '","author":{"@type":"Organization","name":"' + $Site.Name + '"}}</script>'
  $crumb = Get-Crumbs 2 @(@('Guides', 'guides/'), @($g.h1, ''))
  $body = @"
$crumb
  <article class="section" style="padding-top:26px;">
    <div class="wrap-narrow">
      <p class="eyebrow">Guide &middot; $($g.read)</p>
      <h1>$($g.h1)</h1>
      <div class="prose" style="margin-top:22px;">$parts</div>
    </div>
  </article>
"@
  Save-Page 2 "guides/$($g.slug)" $g.title $g.desc $body 'guides' $schema ''
}

function Build-About {
  $crumb = Get-Crumbs 1 @(,@('About', 'about/'))
  $body = @"
$crumb
  <section class="section" style="padding-top:26px;">
    <div class="wrap-narrow">
      <p class="eyebrow">About</p>
      <h1>About $($Site.Name)</h1>
      <div class="prose" style="margin-top:22px;">
        <p>$($Site.Name) publishes printable invitation and card templates for the occasions people
          actually plan around - weddings and nikah ceremonies, engagements, bridal and baby showers,
          graduations, housewarmings and office farewells.</p>
        <h2>How the designs are made</h2>
        <p>Every card on this site is drawn as typography and vector line work rather than assembled
          from stock photography. That decision has two practical consequences. The first is print
          quality: vector artwork stays sharp at any size, so a design that looks correct on screen
          prints cleanly at 5&times;7 inches. The second is licensing - because nothing is borrowed,
          there are no attribution requirements and no third-party conditions attached to anything
          you use here.</p>
        <h2>Everything is editable, and nothing needs an account</h2>
        <p>Each template opens with a form beside it. Type into the boxes - names and dates on an
          invitation, job titles and achievements on a CV - and the page updates as you write. You
          can change all sixteen colour palettes and sixteen typefaces, including Nastaliq, Amiri
          and Naskh, which switch the whole layout to right-to-left.</p>
        <p>Your work is kept in your browser, and the copy-link button turns it into a link anyone
          can open. There is no sign-up step on either side, and nothing is watermarked.</p>
        <h2>Standard sizes, so printing is not a surprise</h2>
        <p>Invitations are 5&times;7 inches, the size envelope suppliers stock. CVs, invoices,
          letters and menus are A4, switching to US Letter in the editor. Certificates are A4
          landscape, and business cards are 3.5&times;2 inches. Downloads come out at 300dpi, which
          is what a print shop asks for.</p>
        <h2>What we are working on</h2>
        <p>Six categories so far, in the order they were drawn: weddings and events, business and
          office, greeting cards, marketing and social, school documents, and the personal
          paperwork of an ordinary week. Each one is added whole rather than a few designs at a
          time, so a category is either finished or not there.</p>
        <h2>Get in touch</h2>
        <p>If a design does not print the way you expected, or you want an occasion added, the
          <a href="../contact/">contact page</a> is the fastest way to reach us.</p>
      </div>
    </div>
  </section>
"@
  Save-Page 1 'about' "About $($Site.Name) - Printable Invitation Templates" `
    "About $($Site.Name): how our printable invitation templates are designed, why every card is 5x7 inches, and what we are adding next." `
    $body 'about' ''
}

function Build-Contact {
  $crumb = Get-Crumbs 1 @(,@('Contact', 'contact/'))
  $body = @"
$crumb
  <section class="section" style="padding-top:26px;">
    <div class="wrap-narrow">
      <p class="eyebrow">Contact</p>
      <h1>Contact us</h1>
      <div class="prose" style="margin-top:20px;">
        <p>Questions about a template, a printing problem, or an occasion you would like added -
          send a message and we will reply by email.</p>
      </div>
      <div class="note-band" style="margin:22px 0 30px;">
        Email us directly at <a href="mailto:$($Site.Email)">$($Site.Email)</a>
      </div>
      <div class="section-head"><h2>Send a message</h2></div>
      <form action="mailto:$($Site.Email)" method="post" enctype="text/plain" style="margin-top:16px;">
        <div class="form-field">
          <label for="name">Your name</label>
          <input id="name" name="name" type="text" autocomplete="name" required>
        </div>
        <div class="form-field">
          <label for="email">Email address</label>
          <input id="email" name="email" type="email" autocomplete="email" required>
        </div>
        <div class="form-field">
          <label for="message">Message</label>
          <textarea id="message" name="message" required></textarea>
        </div>
        <button class="btn btn-primary" type="submit">Send message</button>
        <p class="form-note" style="margin-top:14px;">This form opens your own email app. We only use
          your address to reply - see the <a href="../privacy-policy/">privacy policy</a>.</p>
      </form>
    </div>
  </section>
"@
  Save-Page 1 'contact' "Contact $($Site.Name)" `
    "Get in touch with $($Site.Name) about a template, a printing question, or an occasion you would like us to add." `
    $body 'contact' ''
}

function Build-Privacy {
  $crumb = Get-Crumbs 1 @(,@('Privacy policy', 'privacy-policy/'))
  $body = @"
$crumb
  <section class="section" style="padding-top:26px;">
    <div class="wrap-narrow">
      <p class="eyebrow">Legal</p>
      <h1>Privacy policy</h1>
      <p class="form-note" style="margin-top:8px;">Last updated $Today</p>
      <div class="prose" style="margin-top:22px;">
        <p>This policy explains what information $($Site.Name) collects when you use this website,
          why it is collected, and the choices you have.</p>

        <h2>Information we collect</h2>
        <p>We do not ask you to create an account, and templates can be viewed and printed without
          giving us any personal information. Two situations are exceptions:</p>
        <ul>
          <li><strong>If you email us</strong> through the contact page, we receive your name, email
            address and message, and keep them only as long as needed to answer you.</li>
          <li><strong>Standard server logs</strong> record the pages requested, the time of the
            request, and general technical information such as browser type. These are used to keep
            the site working and to understand which templates are popular.</li>
        </ul>

        <h2>Cookies and advertising</h2>
        <p>This site may display advertising served by Google AdSense. Third-party vendors, including
          Google, use cookies to serve ads based on a user's prior visits to this and other websites.
          Google's use of advertising cookies enables it and its partners to serve ads based on your
          visit to this site and other sites on the internet.</p>
        <p>You can opt out of personalised advertising by visiting
          <a href="https://www.google.com/settings/ads" rel="nofollow noopener">Google Ads Settings</a>.
          You can also opt out of third-party vendors' use of cookies for personalised advertising at
          <a href="https://www.aboutads.info/choices/" rel="nofollow noopener">aboutads.info</a>.
          Most browsers additionally allow you to block or delete cookies from their settings.</p>

        <h2>Analytics</h2>
        <p>If analytics software is used on this site, it records aggregated, non-identifying
          information such as page views and referring sites. It is not used to build a profile of
          individual visitors.</p>

        <h2>Children</h2>
        <p>This site is intended for a general audience and is not directed at children under 13. We
          do not knowingly collect personal information from children.</p>

        <h2>Your choices</h2>
        <p>You can browse and print every template without submitting any personal data. If you have
          emailed us and would like your message deleted, write to
          <a href="mailto:$($Site.Email)">$($Site.Email)</a> and we will remove it.</p>

        <h2>Changes to this policy</h2>
        <p>If this policy changes, the revised version will be posted on this page with a new date at
          the top.</p>

        <h2>Contact</h2>
        <p>Questions about this policy can be sent to
          <a href="mailto:$($Site.Email)">$($Site.Email)</a>.</p>
      </div>
    </div>
  </section>
"@
  Save-Page 1 'privacy-policy' "Privacy Policy - $($Site.Name)" `
    "How $($Site.Name) handles personal information, cookies and advertising, and the choices available to visitors." `
    $body '' ''
}

function Build-Terms {
  $crumb = Get-Crumbs 1 @(,@('Terms of use', 'terms/'))
  $body = @"
$crumb
  <section class="section" style="padding-top:26px;">
    <div class="wrap-narrow">
      <p class="eyebrow">Legal</p>
      <h1>Terms of use</h1>
      <p class="form-note" style="margin-top:8px;">Last updated $Today</p>
      <div class="prose" style="margin-top:22px;">
        <p>By using $($Site.Name) you agree to the terms below. They are deliberately short.</p>

        <h2>What you may do with the templates</h2>
        <p>Every design on this site was drawn in-house. You may print our templates, adapt the
          wording, and use them for your own event - personal or commercial, without payment or
          attribution.</p>

        <h2>What you may not do</h2>
        <ul>
          <li>Redistribute or resell the designs as a template pack, bundle or stock item, whether
            free or paid.</li>
          <li>Claim authorship of the artwork itself.</li>
          <li>Copy the written guides on this site and republish them elsewhere.</li>
        </ul>

        <h2>Accuracy</h2>
        <p>The guides on this site describe general etiquette and printing practice. They are offered
          in good faith but are not professional advice, and customs vary by family and region.</p>

        <h2>Availability</h2>
        <p>We aim to keep the site available and the templates working, but we do not guarantee
          uninterrupted access, and designs may be revised or replaced over time.</p>

        <h2>External links</h2>
        <p>Where we link to other websites, we are not responsible for their content or their privacy
          practices.</p>

        <h2>Contact</h2>
        <p>Questions about these terms can be sent to
          <a href="mailto:$($Site.Email)">$($Site.Email)</a>.</p>
      </div>
    </div>
  </section>
"@
  Save-Page 1 'terms' "Terms of Use - $($Site.Name)" `
    "Terms for using $($Site.Name) templates: what you may print and adapt, and what may not be redistributed." `
    $body '' ''
}

function Build-404 {
  $html = @"
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Page not found - $($Site.Name)</title>
<meta name="robots" content="noindex">
<link rel="stylesheet" href="$Fonts">
<link rel="stylesheet" href="$BasePath/assets/css/style.css">
</head>
<body>
<main id="main">
  <section class="section" style="padding:90px 0;">
    <div class="wrap-narrow" style="text-align:center;">
      <p class="eyebrow">404</p>
      <h1>That page is not here</h1>
      <p class="lede" style="margin:14px auto 26px;">The link may be out of date. The template
        library is still where you left it.</p>
      <a class="btn btn-primary" href="$BasePath/$($Category.slug)/">Browse templates</a>
    </div>
  </section>
</main>
</body>
</html>
"@
  Write-File (Join-Path $Out '404.html') $html
}

function Build-Favicon {
  $svg = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32"><rect width="32" height="32" rx="6" fill="#fbfaf8"/><rect x="5" y="7" width="22" height="18" rx="2" fill="none" stroke="#2e5d4b" stroke-width="2"/><path d="M5 9l11 8 11-8" fill="none" stroke="#a8823f" stroke-width="2"/></svg>'
  Write-File (Join-Path $Out 'assets\favicon.svg') $svg
}

# Search index. 172 templates across 44 subcategories with no way to search
# them was the biggest thing missing; this is small enough (a few tens of KB)
# to fetch once and filter in the browser, and needs no server.
function Build-SearchIndex {
  $rows = New-Object System.Collections.ArrayList
  foreach ($cat in $Categories) {
    $m = $cat.meta
    foreach ($s in $cat.subs) {
      [void]$rows.Add([ordered]@{
        t = 'c'; n = $s.name; c = $m.name; u = "$($m.slug)/$($s.slug)/"
      })
      foreach ($tpl in $s.templates) {
        [void]$rows.Add([ordered]@{
          t = 't'; n = $tpl.name; c = $s.name; u = "$($m.slug)/$($s.slug)/$($tpl.slug)/"
          s = ($tpl.style -replace '&middot;', '-')
        })
      }
    }
  }
  foreach ($g in $AllGuides) {
    [void]$rows.Add([ordered]@{ t = 'g'; n = $g.h1; c = 'Guide'; u = "guides/$($g.slug)/" })
  }
  # ConvertTo-Json escapes what needs escaping; -Compress keeps the file small.
  Write-File (Join-Path $Out 'search.json') ($rows | ConvertTo-Json -Compress -Depth 3)
  Write-Output "  search index: $($rows.Count) entries"
}

function Build-Sitemap {
  $entries = ($Urls | ForEach-Object { "<url><loc>$_</loc><lastmod>$Today</lastmod></url>" }) -join ''
  $xml = '<?xml version="1.0" encoding="UTF-8"?><urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">' + $entries + '</urlset>'
  Write-File (Join-Path $Out 'sitemap.xml') $xml
  Write-File (Join-Path $Out 'robots.txt') "User-agent: *`nAllow: /`n`nSitemap: $($Site.Url)/sitemap.xml`n"
  Write-File (Join-Path $Out '.nojekyll') ''
}

# --- run ---------------------------------------------------------------------

if (Test-Path $Out) { Remove-Item $Out -Recurse -Force }
New-Item -ItemType Directory -Force $Out | Out-Null
Copy-Item (Join-Path $Root 'assets') (Join-Path $Out 'assets') -Recurse

Build-Home
foreach ($cat in $Categories) {
  Build-Category $cat
  foreach ($s in $cat.subs) {
    Build-Subcat $cat $s
    foreach ($t in $s.templates) { Build-Template $cat $s $t }
  }
}
Build-GuidesIndex
foreach ($g in $AllGuides) { Build-Guide $g }
Build-About
Build-Contact
Build-Privacy
Build-Terms
Build-404
Build-Favicon
Build-SearchIndex
Build-Sitemap

Write-Output "Built $($Urls.Count) pages into $Out"

