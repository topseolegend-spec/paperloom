# =============================================================================
#  Card ornaments - sab kuch yahan SVG mein draw hota hai, koi bahar ki image
#  use nahi hoti. viewBox hamesha "0 0 100 140" = 5x7 inch card ka ratio.
#
#  Colour CSS se aata hai: <g class="s"> stroke leta hai, <g class="f"> fill.
#  Is liye palette ya foil badalne par artwork ka rang khud badal jata hai.
# =============================================================================

function N($v) { [math]::Round([double]$v, 1).ToString([cultureinfo]::InvariantCulture) }

function Leaf($cx, $cy, $rot, $rx, $ry) {
  "<ellipse cx=`"$(N $cx)`" cy=`"$(N $cy)`" rx=`"$(N $rx)`" ry=`"$(N $ry)`" transform=`"rotate($(N $rot) $(N $cx) $(N $cy))`"/>"
}

function Blossom($cx, $cy, $r) {
  $p = ''
  foreach ($i in 0..4) {
    $rad = ($i * 72) * [math]::PI / 180
    $p += "<circle cx=`"$(N ($cx + $r * [math]::Cos($rad)))`" cy=`"$(N ($cy + $r * [math]::Sin($rad)))`" r=`"$(N ($r * 0.6))`"/>"
  }
  $p
}

# preserveAspectRatio="none" so the frame meets the page edges exactly. The
# element is always given the page's own proportions in CSS, so on a 5x7 card
# there is no distortion at all, and on A4 it is under one per cent.
function Svg($inner) {
  '<svg viewBox="0 0 100 140" preserveAspectRatio="none" aria-hidden="true" focusable="false">' + $inner + '</svg>'
}

# --- full floral wreath, sits behind the names -------------------------------
#  Radius is deliberately wide: the wording sits inside the ring, so the ring
#  has to clear the text column (cards.css narrows that column for this one).
function Art-Wreath {
  $g = ''
  foreach ($i in 0..23) {
    $ang = $i * 15
    if ($ang -gt 251 -and $ang -lt 289) { continue }   # open at the top
    $rad = $ang * [math]::PI / 180
    $cx = 50 + 43 * [math]::Cos($rad); $cy = 70 + 43 * [math]::Sin($rad)
    # tangential leaves read as foliage; radial ones read as beads on a string
    $g += Leaf $cx $cy ($ang + 72) 6 2.2
    $g += Leaf ($cx + 2.4 * [math]::Cos($rad)) ($cy + 2.4 * [math]::Sin($rad)) ($ang + 108) 4 1.5
  }
  $b = ''
  foreach ($ang in @(20, 160, 200, 340)) {
    $rad = $ang * [math]::PI / 180
    $b += Blossom (50 + 43 * [math]::Cos($rad)) (70 + 43 * [math]::Sin($rad)) 2.4
  }
  Svg ("<g class=`"s`" stroke-width=`"0.5`" opacity=`"0.8`">$g$b</g>")
}

# --- dense floral clusters in opposite corners -------------------------------
function Art-Bouquet {
  $c = ''
  foreach ($l in @(@(15,22,-40,6.2,2.3), @(23,17,-15,5.4,2), @(11,32,-65,5.6,2.1),
                   @(25,28,-30,4.8,1.8), @(17,12,10,4.4,1.7), @(31,23,-50,4.2,1.6),
                   @(8,21,-80,4,1.6), @(28,35,-20,4,1.5))) {
    $c += Leaf $l[0] $l[1] $l[2] $l[3] $l[4]
  }
  $c += Blossom 20 25 3.2
  $c += Blossom 12 15 2.2
  $c += "<path d=`"M6 36 C15 29 24 20 32 11`"/>"
  Svg ("<g class=`"s`" stroke-width=`"0.55`" opacity=`"0.9`">$c</g>" +
       "<g class=`"s`" stroke-width=`"0.55`" opacity=`"0.9`" transform=`"rotate(180 50 70)`">$c</g>")
}

# --- art deco frame with stepped corners -------------------------------------
function Art-Deco {
  $rays = ''
  foreach ($i in 0..4) {
    $x = 50 + ($i - 2) * 5
    $h = 5 - [math]::Abs($i - 2) * 1.4
    $rays += "<path d=`"M$(N $x) $(N (17 - $h)) L$(N $x) 17`"/><path d=`"M$(N $x) 123 L$(N $x) $(N (123 + $h))`"/>"
  }
  Svg ("<g class=`"s`" stroke-width=`"0.9`" opacity=`"0.85`"><path d=`"M20 8 L80 8 L92 20 L92 120 L80 132 L20 132 L8 120 L8 20 Z`"/></g>" +
       "<g class=`"s`" stroke-width=`"0.4`" opacity=`"0.55`"><path d=`"M22 12 L78 12 L88 22 L88 118 L78 128 L22 128 L12 118 L12 22 Z`"/>$rays</g>" +
       "<g class=`"f`" opacity=`"0.8`"><circle cx=`"50`" cy=`"8`" r=`"1.7`"/><circle cx=`"50`" cy=`"132`" r=`"1.7`"/></g>")
}

# --- radial mandala medallion (nikah / mehndi) -------------------------------
function Art-Mandala {
  $g = ''
  foreach ($i in 0..15) {
    $rad = ($i * 22.5) * [math]::PI / 180
    $g += Leaf (50 + 20 * [math]::Cos($rad)) (62 + 20 * [math]::Sin($rad)) ($i * 22.5) 6.2 2.5
  }
  foreach ($i in 0..11) {
    $rad = ($i * 30) * [math]::PI / 180
    $g += Leaf (50 + 33 * [math]::Cos($rad)) (62 + 33 * [math]::Sin($rad)) ($i * 30) 4.6 1.7
  }
  Svg ("<g class=`"s`" stroke-width=`"0.45`" opacity=`"0.5`">$g<circle cx=`"50`" cy=`"62`" r=`"11`"/><circle cx=`"50`" cy=`"62`" r=`"39`"/></g>")
}

# --- leafy vine around all four edges ----------------------------------------
function Art-Vine {
  $g = "<rect x=`"9`" y=`"9`" width=`"82`" height=`"122`" rx=`"2`"/>"
  foreach ($i in 0..7) {
    $x = 16 + $i * 9.7
    $r1 = if ($i % 2) { 35 } else { -35 }
    $g += Leaf $x 9 $r1 3.8 1.5
    $g += Leaf $x 131 (-$r1) 3.8 1.5
  }
  foreach ($i in 0..10) {
    $y = 18 + $i * 10.4
    $r2 = if ($i % 2) { 55 } else { 125 }
    $g += Leaf 9 $y $r2 3.8 1.5
    $g += Leaf 91 $y (180 - $r2) 3.8 1.5
  }
  Svg ("<g class=`"s`" stroke-width=`"0.5`" opacity=`"0.75`">$g</g>")
}

# --- calligraphic flourish top and bottom ------------------------------------
function Art-Flourish {
  $sw = "<path d=`"M24 17 C35 8 44 22 50 15 C56 22 65 8 76 17`"/><path d=`"M36 21 C43 16 57 16 64 21`"/>"
  Svg ("<g class=`"s`" stroke-width=`"0.6`" opacity=`"0.85`">$sw</g>" +
       "<g class=`"f`" opacity=`"0.85`"><circle cx=`"50`" cy=`"11`" r=`"1.4`"/></g>" +
       "<g class=`"s`" stroke-width=`"0.6`" opacity=`"0.85`" transform=`"rotate(180 50 70)`">$sw</g>" +
       "<g class=`"f`" opacity=`"0.85`"><circle cx=`"50`" cy=`"129`" r=`"1.4`"/></g>")
}

# --- doorway arch -------------------------------------------------------------
function Art-Arch {
  Svg ("<g class=`"s`" stroke-width=`"0.9`" opacity=`"0.8`"><path d=`"M50 16 C31 16 23 30 23 45 L23 124 L77 124 L77 45 C77 30 69 16 50 16 Z`"/></g>" +
       "<g class=`"s`" stroke-width=`"0.4`" opacity=`"0.45`"><path d=`"M50 21 C34 21 27 33 27 46 L27 119 L73 119 L73 46 C73 33 66 21 50 21 Z`"/></g>")
}

# --- simple sprigs top and bottom --------------------------------------------
#  Leaves are ellipses angled off the stem - open bezier curves read as hooks
#  at this size, not as foliage.
function Art-Sprig($x, $y, $flip) {
  $s = if ($flip) { -1 } else { 1 }
  $out = "<path d=`"M$x $y L$x $(N ($y + $s * 24))`"/>"
  foreach ($i in 0..3) {
    $cy = $y + $s * (5 + $i * 5.2)
    $len = 4.6 - $i * 0.5
    $out += Leaf ($x - 3.4) $cy ($s * 38) $len 1.7
    $out += Leaf ($x + 3.4) $cy ($s * -38) $len 1.7
  }
  $out += "<circle cx=`"$x`" cy=`"$(N ($y + $s * 25.5))`" r=`"1.1`"/>"
  $out
}

function Art-Botanical {
  Svg ("<g class=`"s`" stroke-width=`"0.55`" opacity=`"0.8`">" + (Art-Sprig 50 11 $false) + (Art-Sprig 50 129 $true) + "</g>")
}

# --- islamic geometric corners ------------------------------------------------
function Art-Geometric {
  $cells = ''
  foreach ($p in @(@(15,17), @(85,17), @(15,123), @(85,123))) {
    $gx = $p[0]; $gy = $p[1]
    $cells += "<rect x=`"$($gx-9)`" y=`"$($gy-9)`" width=`"18`" height=`"18`" transform=`"rotate(45 $gx $gy)`"/>" +
      "<rect x=`"$($gx-6)`" y=`"$($gy-6)`" width=`"12`" height=`"12`"/>" +
      "<rect x=`"$($gx-3)`" y=`"$($gy-3)`" width=`"6`" height=`"6`" transform=`"rotate(45 $gx $gy)`"/>"
  }
  Svg ("<g class=`"s`" stroke-width=`"0.5`" opacity=`"0.7`">$cells</g>")
}

# --- laurel branches ----------------------------------------------------------
function Art-Laurel {
  $out = ''
  foreach ($mirror in @($false, $true)) {
    $m = if ($mirror) { ' transform="scale(-1,1) translate(-100,0)"' } else { '' }
    $leaves = ''
    foreach ($i in 0..8) { $leaves += Leaf (33 - $i * 0.9) (38 + $i * 6.4) (-40 + $i * 7) 4.3 1.7 }
    $out += "<g class=`"s`"$m stroke-width=`"0.55`" opacity=`"0.8`"><path d=`"M35 34 C26 52 26 74 33 92`"/>$leaves</g>"
  }
  Svg $out
}

# --- confetti and ribbons -----------------------------------------------------
function Art-Confetti {
  $dots = ''
  foreach ($p in @(@(16,20,'2.2'),@(28,13,'1.4'),@(82,18,'2.4'),@(72,11,'1.3'),@(12,40,'1.6'),
                   @(89,44,'1.8'),@(18,112,'2'),@(84,118,'1.9'),@(30,128,'1.4'),@(68,130,'2.2'),
                   @(10,76,'1.3'),@(91,80,'1.5'),@(22,60,'1.1'),@(79,64,'1.2'))) {
    $dots += "<circle cx=`"$($p[0])`" cy=`"$($p[1])`" r=`"$($p[2])`"/>"
  }
  Svg ("<g class=`"f`" opacity=`"0.6`">$dots</g>" +
       "<g class=`"s`" stroke-width=`"0.6`" opacity=`"0.6`"><path d=`"M13 30 C19 25 20 36 26 31`"/><path d=`"M74 122 C80 117 81 128 87 123`"/></g>")
}

function Art-None { '' }

# Editor mein isi order se ornament switcher banta hai.
$ArtKinds = @(
  @{ id='none';      label='None' },
  @{ id='wreath';    label='Wreath' },
  @{ id='bouquet';   label='Bouquet' },
  @{ id='vine';      label='Vine border' },
  @{ id='botanical'; label='Sprigs' },
  @{ id='flourish';  label='Flourish' },
  @{ id='deco';      label='Art deco' },
  @{ id='mandala';   label='Mandala' },
  @{ id='geometric'; label='Geometric' },
  @{ id='arch';      label='Arch' },
  @{ id='laurel';    label='Laurel' },
  @{ id='confetti';  label='Confetti' }
)

# Ornaments ab static hain - rang CSS se aata hai, is liye har SVG sirf ek baar
# banti hai. Editor wale har page par 11 ornaments hote hain, to bina cache ke
# ye build ka sabse mehnga hissa ban jata hai.
$ArtCache = @{}

function Get-Art($kind) {
  if (-not $ArtCache.ContainsKey("$kind")) { $ArtCache["$kind"] = Build-Art $kind }
  $ArtCache["$kind"]
}

function Build-Art($kind) {
  switch ($kind) {
    'wreath'    { Art-Wreath }
    'bouquet'   { Art-Bouquet }
    'deco'      { Art-Deco }
    'mandala'   { Art-Mandala }
    'vine'      { Art-Vine }
    'flourish'  { Art-Flourish }
    'arch'      { Art-Arch }
    'botanical' { Art-Botanical }
    'geometric' { Art-Geometric }
    'laurel'    { Art-Laurel }
    'confetti'  { Art-Confetti }
    default     { '' }
  }
}
