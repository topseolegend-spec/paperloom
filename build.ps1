# =============================================================================
#  Paperloom - static site generator
#  Chalane ka tareeqa:   powershell -ExecutionPolicy Bypass -File build.ps1
#  Output "docs" folder mein banta hai - GitHub Pages isi ko serve karta hai.
# =============================================================================

$ErrorActionPreference = 'Stop'
$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
$Out  = Join-Path $Root 'docs'
. (Join-Path $Root 'content.ps1')
. (Join-Path $Root 'ornaments.ps1')

$Today = (Get-Date).ToString('yyyy-MM-dd')
$Year  = (Get-Date).Year
# GitHub Pages project site "/paperloom" par serve hoti hai; apne domain par ye khali ho jayega.
$BasePath = ([System.Uri]$Site.Url).AbsolutePath.TrimEnd('/')
$Urls  = New-Object System.Collections.ArrayList

function Write-File($path, $text) {
  $dir = Split-Path -Parent $path
  if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Force $dir | Out-Null }
  [System.IO.File]::WriteAllText($path, $text, (New-Object System.Text.UTF8Encoding($false)))
}

# --- shared chrome -----------------------------------------------------------

function Get-Rel($depth) { if ($depth -gt 0) { '../' * $depth } else { '' } }

function Get-Nav($depth, $current) {
  $r = Get-Rel $depth
  $items = ($Subcats | ForEach-Object { "<a href=`"${r}$($Category.slug)/$($_.slug)/`">$($_.nav)</a>" }) -join ''
  $cHome    = if ($current -eq 'home')    { ' aria-current="page"' } else { '' }
  $cGuides  = if ($current -eq 'guides')  { ' aria-current="page"' } else { '' }
  $cAbout   = if ($current -eq 'about')   { ' aria-current="page"' } else { '' }
  $cContact = if ($current -eq 'contact') { ' aria-current="page"' } else { '' }
@"
<nav class="nav" aria-label="Main">
        <a class="nav-link" href="$r"$cHome>Home</a>
        <div class="has-dropdown">
          <button class="dropdown-toggle" aria-expanded="false" aria-haspopup="true">Weddings &amp; Events
            <svg class="caret" width="10" height="6" viewBox="0 0 10 6" aria-hidden="true"><path d="M1 1l4 4 4-4" fill="none" stroke="currentColor" stroke-width="1.5"/></svg>
          </button>
          <div class="dropdown-panel" hidden>
            <p class="panel-head">All occasions</p>
            <a href="${r}$($Category.slug)/">All wedding &amp; event templates</a>
            $items
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
  $occ = ($Subcats | Select-Object -First 5 | ForEach-Object {
    "<li><a href=`"${r}$($Category.slug)/$($_.slug)/`">$($_.nav)</a></li>" }) -join ''
  $gds = ($Guides | ForEach-Object { "<li><a href=`"${r}guides/$($_.slug)/`">$($_.h1)</a></li>" }) -join ''
@"
<footer class="site-footer">
    <div class="wrap">
      <div class="footer-grid">
        <div class="footer-brand">
          <span class="brand-name" style="font-family:var(--display);font-size:21px;">$($Site.Name)</span>
          <p>Printable invitation and card templates, drawn in-house so every design is free to
             print, share and adapt.</p>
        </div>
        <div>
          <h4>Occasions</h4>
          <ul>$occ<li><a href="${r}$($Category.slug)/">See all</a></li></ul>
        </div>
        <div>
          <h4>Guides</h4>
          <ul>$gds</ul>
        </div>
        <div>
          <h4>Site</h4>
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

function Save-Page($depth, $path, $title, $desc, $body, $current, $extraHead, $extraScripts) {
  $r = Get-Rel $depth
  $canonical = if ($path) { "$($Site.Url)/$path/" } else { "$($Site.Url)/" }
  $header = Get-Header $depth $current
  $footer = Get-Footer $depth
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
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link rel="stylesheet" href="$Fonts">
<link rel="stylesheet" href="${r}assets/css/style.css">
<link rel="stylesheet" href="${r}assets/css/cards.css">
<link rel="icon" href="${r}assets/favicon.svg" type="image/svg+xml">
$extraHead
</head>
<body>
<a class="skip-link" href="#main">Skip to content</a>
$header
<main id="main">
$body
</main>
$footer
<script src="${r}assets/js/main.js"></script>
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
  $art = ''
  if ($allArt) {
    $art = ($ArtKinds | Where-Object { $_.id -ne 'none' } | ForEach-Object {
      $on = if ($_.id -eq $t.art) { ' is-on' } else { '' }
      "<span class=`"art$on`" data-art=`"$($_.id)`">" + (Get-Art $_.id) + '</span>'
    }) -join ''
  } elseif ($t.art) {
    $art = "<span class=`"art is-on`" data-art=`"$($t.art)`">" + (Get-Art $t.art) + '</span>'
  }

  $corners = '<span class="corner tl"></span><span class="corner br"></span>'
  $b = $t.body
  $bgs  = if ($t.bgstyle) { $t.bgstyle } else { 'bg-plain' }
  $foil = if ($t.foil) { ' is-foil' } else { '' }
  $note = if ($b.note) { $b.note } else { '' }
  $style = "--c-bg:$($t.bg);--c-ink:$($t.ink);--c-accent:$($t.accent);--c-soft:$($t.soft)"
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

function Get-Crumbs($depth, $trail) {
  $r = Get-Rel $depth
  $parts = @("<a href=`"$r`">Home</a>")
  for ($i = 0; $i -lt $trail.Count - 1; $i++) {
    $parts += "<a href=`"$r$($trail[$i][1])`">$($trail[$i][0])</a>"
  }
  $parts += "<span aria-current=`"page`">$($trail[$trail.Count-1][0])</span>"
  '<div class="wrap"><nav class="crumbs" aria-label="Breadcrumb">' + ($parts -join '<span>/</span>') + '</nav></div>'
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
  $featured = @($Subcats[0].templates[0], $Subcats[1].templates[1], $Subcats[4].templates[1])
  $letters = @('a','b','c')
  $fan = ''
  for ($i = 0; $i -lt 3; $i++) { $fan += Get-Card $featured[$i] "fan-$($letters[$i])" }

  $tiles = ($Subcats | ForEach-Object {
@"
<a class="cat-tile" href="$($Category.slug)/$($_.slug)/">
          <h3>$($_.name)</h3>
          <p>$(($_.desc -split '\.')[0]).</p>
          <span class="count">$($_.templates.Count) templates</span>
        </a>
"@ }) -join ''

  $guides = ($Guides | ForEach-Object {
@"
<a class="cat-tile" href="guides/$($_.slug)/">
          <h3>$($_.h1)</h3>
          <p>$($_.desc)</p>
          <span class="count">$($_.read)</span>
        </a>
"@ }) -join ''

  $body = @"
<section class="hero">
    <div class="wrap hero-grid">
      <div>
        <p class="eyebrow">Free printable templates</p>
        <h1>Type your names. Print it tonight.</h1>
        <p class="lede">Thirty-two invitation designs for weddings, nikah ceremonies, showers,
          graduations and farewells. Click straight onto a card to put your own names on it -
          no account, no watermark, no download queue.</p>
        <div class="hero-actions">
          <a class="btn btn-primary" href="$($Category.slug)/">Browse templates</a>
          <a class="btn btn-ghost" href="guides/">Read the guides</a>
        </div>
        <div class="pill-row">
          <span class="pill">Edit in your browser</span>
          <span class="pill">&#1575;&#1585;&#1583;&#1608; &amp; &#1593;&#1585;&#1576;&#1740; supported</span>
          <span class="pill">5&times;7 inch, print ready</span>
        </div>
      </div>
      <div class="hero-fan">$fan</div>
    </div>
  </section>

  <section class="section">
    <div class="wrap">
      <div class="section-head">
        <h2>Browse by occasion</h2>
        <p>Eight occasions inside Weddings &amp; Events, each with four designs in different styles.</p>
      </div>
      <div class="cat-grid">$tiles</div>
    </div>
  </section>

  <section class="section" style="background:var(--surface-2);border-top:1px solid var(--line);border-bottom:1px solid var(--line);">
    <div class="wrap">
      <div class="section-head">
        <h2>Before you print</h2>
        <p>Short guides on timing, wording and what actually needs to be on the card.</p>
      </div>
      <div class="cat-grid">$guides</div>
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
          <h3>Edit on the card itself</h3>
          <p>Click any line and type. Names, dates, venue - the card updates as you write, and your
            work is kept in your browser if you close the tab.</p>
        </div>
        <div class="feature">
          <h3>&#1575;&#1585;&#1583;&#1608; and &#1593;&#1585;&#1576;&#1740;, properly set</h3>
          <p>Switch a card to Nastaliq or Amiri and the whole layout flips to right-to-left with the
            line spacing those scripts actually need.</p>
        </div>
        <div class="feature">
          <h3>Your own colours</h3>
          <p>Six ready palettes, or pick the exact background, text and accent colours to match a
            theme you have already chosen.</p>
        </div>
        <div class="feature">
          <h3>Share without an account</h3>
          <p>One button turns your edited card into a link. Whoever opens it sees your version -
            neither of you signs up for anything.</p>
        </div>
        <div class="feature">
          <h3>Print-size PNG, no watermark</h3>
          <p>Download at 1500 &times; 2100 pixels - a true 5 &times; 7 inches at 300dpi, which is
            what a print shop asks for.</p>
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
  Save-Page 0 '' "$($Site.Name) - Free Printable Invitation &amp; Card Templates" `
    'Free printable invitation templates for weddings, nikah, engagements, baby showers, graduations and more. 5x7 inch designs you can print at home or save as PDF.' `
    $body 'home' ''
}

function Build-Category {
  $tiles = ($Subcats | ForEach-Object {
@"
<a class="cat-tile" href="$($_.slug)/">
          <h3>$($_.name)</h3>
          <p>$(($_.desc -split '\.')[0]).</p>
          <span class="count">$($_.templates.Count) templates</span>
        </a>
"@ }) -join ''

  $previews = ($Subcats | Select-Object -First 4 | ForEach-Object {
    $t = $_.templates[0]
    "<a class=`"tpl-item`" href=`"$($_.slug)/$($t.slug)/`">" + (Get-Card $t '') +
    "<span class=`"tpl-meta`"><span class=`"name`">$($t.name)</span><span class=`"sub`">$($_.name)</span></span></a>"
  }) -join ''

  $intro = ($Category.intro | ForEach-Object { "<p>$_</p>" }) -join ''
  $crumb = Get-Crumbs 1 @(,@($Category.name, "$($Category.slug)/"))

  $body = @"
$crumb
  <section class="section" style="padding-top:26px;">
    <div class="wrap">
      <p class="eyebrow">Category</p>
      <h1>$($Category.h1)</h1>
      <div class="prose" style="margin-top:16px;">$intro</div>
    </div>
  </section>
  <section class="section" style="padding-top:0;">
    <div class="wrap">
      <div class="section-head"><h2>Occasions</h2></div>
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
  Save-Page 1 $Category.slug $Category.title $Category.desc $body '' ''
}

function Build-Subcat($s) {
  $grid = ($s.templates | ForEach-Object {
    "<a class=`"tpl-item`" href=`"$($_.slug)/`">" + (Get-Card $_ '') +
    "<span class=`"tpl-meta`"><span class=`"name`">$($_.name)</span><span class=`"sub`">$($_.style)</span></span></a>"
  }) -join ''

  $intro = ($s.intro | ForEach-Object { "<p>$_</p>" }) -join ''
  $faqs  = ($s.faq | ForEach-Object { "<details><summary>$($_[0])</summary><p>$($_[1])</p></details>" }) -join ''
  $others = ($Subcats | Where-Object { $_.slug -ne $s.slug } | ForEach-Object {
    "<li><a href=`"../$($_.slug)/`">$($_.name)</a></li>" }) -join ''
  $crumb = Get-Crumbs 2 @(@($Category.name, "$($Category.slug)/"), @($s.name, ''))

  $body = @"
$crumb
  <section class="section" style="padding:26px 0 40px;">
    <div class="wrap">
      <p class="eyebrow">$($Category.name)</p>
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
      <div class="section-head"><h2>Other occasions</h2></div>
      <ul class="link-list">$others</ul>
    </div>
  </section>
"@
  Save-Page 2 "$($Category.slug)/$($s.slug)" $s.title $s.desc $body '' (Get-FaqSchema $s.faq)
}

function Build-Template($s, $t) {
  $related = ($s.templates | Where-Object { $_.slug -ne $t.slug } | ForEach-Object {
    "<a class=`"tpl-item`" href=`"../$($_.slug)/`">" + (Get-Card $_ '') +
    "<span class=`"tpl-meta`"><span class=`"name`">$($_.name)</span><span class=`"sub`">$($_.style)</span></span></a>"
  }) -join ''

  $singular = $s.name.TrimEnd('s')
  $title = "$($t.name) - $singular Template"
  $descStyle = ($t.style -replace '&middot;', 'and').ToLower()
  $desc = "$($t.name): a printable $($singular.ToLower()) template in a $descStyle style. 5x7 inch, print at home or save as PDF."
  $card = Get-Card $t ''
  $crumb = Get-Crumbs 3 @(@($Category.name, "$($Category.slug)/"), @($s.name, "$($Category.slug)/$($s.slug)/"), @($t.name, ''))

  $swatches = ($Palettes | ForEach-Object {
    $f = if ($_.foil) { '1' } else { '0' }
    "<button class=`"ed-swatch`" type=`"button`" title=`"$($_.name)`" aria-label=`"$($_.name)`" aria-pressed=`"false`" data-swatch=`"$($_.bg),$($_.ink),$($_.accent),$f`"><span style=`"background:$($_.bg)`"></span><span style=`"background:$($_.accent)`"></span></button>"
  }) -join ''

  $fontChips = ($FontChoices | ForEach-Object {
    "<button class=`"ed-chip`" type=`"button`" aria-pressed=`"false`" data-font=`"$($_.cls)`">$($_.label)</button>"
  }) -join ''

  $artChips = ($ArtKinds | ForEach-Object {
    "<button class=`"ed-chip`" type=`"button`" aria-pressed=`"false`" data-art=`"$($_.id)`">$($_.label)</button>"
  }) -join ''

  $bgChips = ($BgChoices | ForEach-Object {
    "<button class=`"ed-chip`" type=`"button`" aria-pressed=`"false`" data-bg=`"$($_.cls)`">$($_.label)</button>"
  }) -join ''

  $sizeChips = ($SizeChoices | ForEach-Object {
    "<button class=`"ed-chip ed-chip-wide`" type=`"button`" aria-pressed=`"false`" data-size=`"$($_.cls)`">$($_.label)<span class=`"sub`">$($_.note)</span></button>"
  }) -join ''

  $body = @"
$crumb
  <div class="wrap">
    <div class="detail-grid">
      <div>
        <p class="stage-hint">
          <svg width="15" height="15" viewBox="0 0 16 16" aria-hidden="true"><path d="M11.5 1.5l3 3L5 14H2v-3z" fill="none" stroke="currentColor" stroke-width="1.4" stroke-linejoin="round"/></svg>
          Fill in the boxes and the card updates as you type - or click a line on the card itself.
        </p>
        <div class="detail-stage" data-template="$($t.slug)">$(Get-Card $t '' $true)</div>
      </div>
      <div class="detail-side">
        <div class="editor-panel">
          <p class="eyebrow">$($s.name)</p>
          <h1 style="font-size:30px;">$($t.name)</h1>
          <p class="form-note" style="margin:8px 0 28px;">$($t.style) &middot; 5 &times; 7 in &middot;
            free to print, no account needed</p>

          <div class="ed-step">
            <div class="ed-step-head"><span class="ed-step-num">1</span><h2>Fill in your details</h2></div>
            <div class="ed-fields">
              <div class="ed-field">
                <label for="ed-text-title">Names</label>
                <input type="text" id="ed-text-title" data-text="title" autocomplete="off">
              </div>
              <div class="ed-field">
                <label for="ed-text-pre">Line above the names</label>
                <input type="text" id="ed-text-pre" data-text="pre" autocomplete="off">
              </div>
              <div class="ed-field">
                <label for="ed-text-mid">Line below the names</label>
                <input type="text" id="ed-text-mid" data-text="mid" autocomplete="off">
              </div>
              <div class="ed-field">
                <label for="ed-text-date">Date and time</label>
                <input type="text" id="ed-text-date" data-text="date" autocomplete="off">
              </div>
              <div class="ed-field">
                <label for="ed-text-venue">Venue and address <span class="sub">Enter for a new line</span></label>
                <textarea id="ed-text-venue" data-text="venue"></textarea>
              </div>
              <div class="ed-field">
                <label for="ed-text-note">Footer line <span class="sub">RSVP, dress code - leave empty to hide</span></label>
                <input type="text" id="ed-text-note" data-text="note" autocomplete="off">
              </div>
            </div>
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
              <span class="hint">Urdu and Arabic switch the card to right-to-left</span></p>
            <div class="ed-chips">$fontChips</div>
            <div class="ed-slider">
              <label for="ed-size">Name size</label>
              <input type="range" id="ed-size" min="60" max="150" step="5" value="100">
              <output for="ed-size" id="ed-size-out">100%</output>
            </div>
          </div>

          <div class="ed-step">
            <div class="ed-step-head"><span class="ed-step-num">4</span><h2>Decoration</h2></div>
            <p class="ed-label" style="margin-bottom:10px;">Ornament</p>
            <div class="ed-chips">$artChips</div>
            <p class="ed-label" style="margin:16px 0 10px;">Background</p>
            <div class="ed-chips">$bgChips</div>
          </div>

          <div class="ed-step">
            <div class="ed-step-head"><span class="ed-step-num">5</span><h2>Card size</h2></div>
            <div class="ed-chips">$sizeChips</div>
          </div>

          <div class="ed-step">
            <div class="ed-step-head"><span class="ed-step-num">6</span><h2>Save your card</h2></div>
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
  Save-Page 3 "$($Category.slug)/$($s.slug)/$($t.slug)" $title $desc $body '' $head $scripts
}

function Build-GuidesIndex {
  $tiles = ($Guides | ForEach-Object {
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
      <h1>Invitation guides</h1>
      <p class="lede" style="margin-top:14px;">Practical answers to the questions that come up while
        you are choosing a design - timing, wording, and what has to be on the card.</p>
      <div class="cat-grid" style="margin-top:32px;">$tiles</div>
    </div>
  </section>
"@
  Save-Page 1 'guides' 'Invitation Guides - Timing, Wording and What to Include' `
    'Practical guides on when to send wedding invitations, what to include on the card, and wording examples for formal, modern and nikah invitations.' `
    $body 'guides' ''
}

function Build-Guide($g) {
  $parts = ''
  foreach ($blk in $g.body) {
    $kind = $blk[0]; $val = $blk[1]
    switch ($kind) {
      'p'  { $parts += "<p>$val</p>" }
      'h2' { $parts += "<h2>$val</h2>" }
      'ul' { $parts += '<ul>' + (($val | ForEach-Object { "<li>$_</li>" }) -join '') + '</ul>' }
      'ol' { $parts += '<ol>' + (($val | ForEach-Object { "<li>$_</li>" }) -join '') + '</ol>' }
      'blockquote' { $parts += "<blockquote><p>$val</p></blockquote>" }
      'cta' {
        $sub = $Subcats | Where-Object { $_.slug -eq $val }
        $parts += "<div class=`"note-band`" style=`"margin-top:34px;`">Ready to choose a design? Browse the <a href=`"../../$($Category.slug)/$($sub.slug)/`">$($sub.name.ToLower())</a> - four printable layouts, free to use.</div>"
      }
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
  Save-Page 2 "guides/$($g.slug)" $g.title $g.desc $body 'guides' $schema
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
        <h2>Why 5&times;7 inches</h2>
        <p>It is the size most envelope suppliers and print shops stock as standard, and it fits on
          both A4 and US Letter paper with room for trim marks. Building every template to the same
          size means one pack of envelopes works for any card on the site.</p>
        <h2>What we are working on</h2>
        <p>Weddings and events is the first category. Greeting cards, business stationery, social
          media layouts and school certificates are being drawn next, in that order.</p>
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
      <form action="mailto:$($Site.Email)" method="post" enctype="text/plain">
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
Build-Category
foreach ($s in $Subcats) {
  Build-Subcat $s
  foreach ($t in $s.templates) { Build-Template $s $t }
}
Build-GuidesIndex
foreach ($g in $Guides) { Build-Guide $g }
Build-About
Build-Contact
Build-Privacy
Build-Terms
Build-404
Build-Favicon
Build-Sitemap

Write-Output "Built $($Urls.Count) pages into $Out"

