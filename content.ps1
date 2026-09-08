# =============================================================================
#  Paperloom - site content
#  Naya occasion ya category add karni ho to sirf yehi file edit karein,
#  phir build.ps1 dobara chalayein.
#
#  ZAROORI: is file mein Urdu/Arabic text seedha na likhein - PowerShell 5.1
#  ise ANSI parhta hai aur text kharab ho jata hai. HTML entities use karein.
# =============================================================================

$Site = [ordered]@{
  Name    = 'Paperloom'
  Tagline = 'Printable invitation and card templates'
  # Apna domain lene ke baad sirf ye do lines badalni hain (build dobara chala dein).
  # Root par serve ho rahi hai, is liye $BasePath khali hota hai - GitHub Pages
  # wali copy "/paperloom" subfolder par thi aur usay base path chahiye tha.
  Url     = 'https://paperloom-rho.vercel.app'
  Email   = 'topseo.legend@gmail.com'
}

# Har page par load hote hain - sirf wo faces jo templates khud use karte hain.
$Fonts = 'https://fonts.googleapis.com/css2?family=Marcellus&family=Karla:wght@400;500;600;700&family=Cormorant+Garamond:wght@400;500;600&family=Great+Vibes&family=Cinzel:wght@400;600&family=Josefin+Sans:wght@300;400&display=swap'

# Sirf editor wale (template detail) pages par - browser wahi face download karta
# hai jo asal mein use ho, is liye list lambi hone se page bhari nahi hota.
$FontsExtra = 'https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600&family=Bodoni+Moda:wght@400;600&family=Cinzel+Decorative:wght@400;700&family=Italiana&family=Libre+Baskerville&family=Parisienne&family=Sacramento&family=Tenor+Sans&family=Noto+Nastaliq+Urdu:wght@400;600&family=Amiri:wght@400;700&family=Noto+Naskh+Arabic:wght@400;600&display=swap'

# --- editor: colour presets --------------------------------------------------
#  foil = metallic gradient, gold/champagne walay palettes par achha lagta hai.

$Palettes = @(
  @{ name='Ivory &amp; gold';   bg='#fbf8f1'; ink='#1f3328'; accent='#a8823f'; foil=$true  },
  @{ name='Blush rose';         bg='#fdf6f4'; ink='#4a2c2a'; accent='#c08497'; foil=$false },
  @{ name='Emerald';            bg='#f4f7f2'; ink='#14392c'; accent='#1f5c45'; foil=$false },
  @{ name='Sage';               bg='#f2f5ef'; ink='#2c3a2c'; accent='#6e8b62'; foil=$false },
  @{ name='Dusty lilac';        bg='#f7f4fb'; ink='#3f3550'; accent='#9b87c4'; foil=$false },
  @{ name='Powder blue';        bg='#f2f7fb'; ink='#27394d'; accent='#6f9fc4'; foil=$false },
  @{ name='Champagne';          bg='#fdfaf3'; ink='#3a3226'; accent='#c9a870'; foil=$true  },
  @{ name='Burgundy';           bg='#faf6f4'; ink='#3b1f27'; accent='#7b2c3b'; foil=$false },
  @{ name='Plum';               bg='#faf4f7'; ink='#3d1f36'; accent='#8e4470'; foil=$false },
  @{ name='Clay';               bg='#fbf5f0'; ink='#45372f'; accent='#b06a4a'; foil=$false },
  @{ name='Slate blue';         bg='#f6f7f8'; ink='#232c33'; accent='#4c6377'; foil=$false },
  @{ name='Midnight gold';      bg='#1b2a41'; ink='#f3efe6'; accent='#c9a227'; foil=$true  },
  @{ name='Charcoal gold';      bg='#16161a'; ink='#f2eee4'; accent='#c9a227'; foil=$true  },
  @{ name='Forest night';       bg='#16241d'; ink='#eef2ea'; accent='#b9975b'; foil=$true  },
  @{ name='Deep teal';          bg='#14343a'; ink='#eff3f1'; accent='#c9a227'; foil=$true  },
  @{ name='Wine';               bg='#2b1620'; ink='#f5ebe9'; accent='#c98a94'; foil=$false }
)

# --- editor: typeface switcher -----------------------------------------------

$FontChoices = @(
  @{ cls='f-cormorant';  label='Classic serif' },
  @{ cls='f-playfair';   label='Playfair' },
  @{ cls='f-bodoni';     label='Bodoni' },
  @{ cls='f-libre';      label='Book serif' },
  @{ cls='f-marcellus';  label='Elegant' },
  @{ cls='f-italiana';   label='Fine display' },
  @{ cls='f-cinzel';     label='Roman caps' },
  @{ cls='f-cinzel-dec'; label='Ornate caps' },
  @{ cls='f-script';     label='Flowing script' },
  @{ cls='f-parisienne'; label='Casual script' },
  @{ cls='f-sacramento'; label='Light script' },
  @{ cls='f-josefin';    label='Modern sans' },
  @{ cls='f-tenor';      label='Clean sans' },
  @{ cls='f-urdu';       label='&#1575;&#1585;&#1583;&#1608; Nastaliq' },
  @{ cls='f-amiri';      label='&#1593;&#1585;&#1576;&#1740; Amiri' },
  @{ cls='f-naskh';      label='&#1593;&#1585;&#1576;&#1740; Naskh' }
)

# --- editor: background treatments -------------------------------------------

$BgChoices = @(
  @{ cls='bg-plain'; label='Plain' },
  @{ cls='bg-grad';  label='Soft glow' },
  @{ cls='bg-wash';  label='Watercolour' },
  @{ cls='bg-edge';  label='Vignette' }
)

# --- sizes, per template kind -------------------------------------------------

$SizeSets = @{
  card = @(
    @{ cls='sz-5x7';    label='5 x 7 in';  note='Standard invitation' },
    @{ cls='sz-a5';     label='A5';        note='Common at print shops' },
    @{ cls='sz-square'; label='Square';    note='Best for WhatsApp &amp; Instagram' })
  doc = @(
    @{ cls='sz-a4';     label='A4';        note='Standard almost everywhere' },
    @{ cls='sz-letter'; label='US Letter'; note='North America' })
  cert = @(
    @{ cls='sz-cert';        label='A4 landscape';     note='Fits ready-made frames' },
    @{ cls='sz-cert-letter'; label='Letter landscape'; note='North America' })
  bcard = @(
    @{ cls='sz-bcard';    label='3.5 x 2 in';  note='Pakistan, US and most of Asia' },
    @{ cls='sz-bcard-eu'; label='85 x 55 mm';  note='Europe' })

  # Marketing formats - har platform ka apna size, is liye har subcategory apna
  # set chunti hai (subcategory par "sizeset" key).
  poster = @(
    @{ cls='sz-a3';        label='A3';          note='Noticeboards and shop windows' },
    @{ cls='sz-a2';        label='A2';          note='Where people stand back from it' },
    @{ cls='sz-poster-us'; label='18 x 24 in';  note='North America' })
  flyer = @(
    @{ cls='sz-a5'; label='A5'; note='Handouts and letterbox drops' },
    @{ cls='sz-a4'; label='A4'; note='Noticeboards and windows' })
  igpost = @(
    @{ cls='sz-ig';   label='1080 square';   note='Standard feed post' },
    @{ cls='sz-ig45'; label='1080 x 1350';   note='Portrait - takes more of the feed' })
  story = @(
    @{ cls='sz-story'; label='1080 x 1920'; note='Stories, Reels and TikTok' })
  yt = @(
    @{ cls='sz-yt'; label='1280 x 720'; note='YouTube thumbnail' })
  fbcover = @(
    @{ cls='sz-fbcover'; label='820 x 312'; note='Facebook page cover' })
  linkedin = @(
    @{ cls='sz-linkedin'; label='1584 x 396'; note='LinkedIn profile banner' })
  webad = @(
    @{ cls='sz-mrec';        label='300 x 250'; note='Medium rectangle' },
    @{ cls='sz-leaderboard'; label='728 x 90';  note='Leaderboard' },
    @{ cls='sz-halfpage';    label='300 x 600'; note='Half page' })
  logo = @(
    @{ cls='sz-logo';    label='3 : 2';  note='Wordmarks and stacked marks' },
    @{ cls='sz-logo-sq'; label='Square'; note='Avatars and app icons' })
}

# kind -> konsa size set milega (subcategory "sizeset" is se pehle aati hai)
$SizeSetFor = @{
  card='card'; greeting='card'
  resume='doc'; letter='doc'; invoice='doc'; menu='doc'; letterhead='doc'
  cert='cert'; bcard='bcard'
  promo='poster'; logo='logo'
}

# --- editor form fields -------------------------------------------------------
#  Har subcategory apne fields declare karti hai; editor ka form isi se banta hai.
#  type: text (ek line) ya area (kai lines). group = form ka section.

function New-Field($id, $label, $type, $group, $hint) {
  @{ id=$id; label=$label; type=$type; group=$group; hint=$hint }
}

$FieldsCard = @(
  (New-Field 'title' 'Names'                 'text' 'Details' ''),
  (New-Field 'pre'   'Line above the names'  'text' 'Details' ''),
  (New-Field 'mid'   'Line below the names'  'text' 'Details' ''),
  (New-Field 'date'  'Date and time'         'text' 'Details' ''),
  (New-Field 'venue' 'Venue and address'     'area' 'Details' 'Enter for a new line'),
  (New-Field 'note'  'Footer line'           'text' 'Details' 'RSVP, dress code - leave empty to hide')
)

# --- sample wording used inside each card ------------------------------------

$Body = @{
  wedding = @{ pre='Together with their families'; title='Ayesha &amp; Bilal'
    mid='request the pleasure of your company at their wedding'
    date='Saturday &middot; 14 March 2026'
    venue='Rose Garden Hall, Lahore<br>Six in the evening'
    note='Kindly reply by 21 February' }
  nikah = @{ pre='Bismillah ir-Rahman ir-Raheem'; title='Fatima &amp; Usman'
    mid='request the honour of your presence at their Nikah'
    date='Friday &middot; 20 March 2026'
    venue="Jamia Masjid Al-Noor, Karachi<br>Following Jumu'ah prayers"
    note='Dinner to follow at Marquee Hall' }
  engagement = @{ pre='Save the moment'; title='Sara &amp; Hamza'
    mid='are getting engaged, and would love you there'
    date='Sunday &middot; 12 April 2026'
    venue='The Orchard Lawn, Islamabad<br>Seven in the evening'
    note='RSVP 0300 1234567' }
  bridal = @{ pre='Let us shower the bride'; title='Zara Ahmed'
    mid='join us to celebrate before the big day'
    date='Saturday &middot; 9 May 2026 &middot; 2 pm'
    venue='12 Gulberg Avenue, Lahore<br>Brunch and gifts'
    note='Hosted by Mariam and Sana' }
  baby = @{ pre='A little one is on the way'; title='Baby Khan'
    mid='please join us for a baby shower honouring Ayesha'
    date='Sunday &middot; 7 June 2026 &middot; 3 pm'
    venue='Garden Terrace, DHA Phase 5<br>Tea and cake to follow'
    note='Please reply by 24 May' }
  grad = @{ pre='Class of 2026'; title='Hania Malik'
    mid='Bachelor of Science in Computer Science'
    date='Saturday &middot; 27 June 2026 &middot; 4 pm'
    venue='Convocation Hall, Punjab University<br>Reception afterwards'
    note='Two guest passes enclosed' }
  house = @{ pre='We have moved'; title='The Khan Family'
    mid='please join us for a housewarming afternoon'
    date='Saturday &middot; 18 July 2026 &middot; 5 pm'
    venue='24 Marigold Street, Bahria Town<br>Dinner and tea'
    note='Your company is gift enough' }
  farewell = @{ pre='With gratitude'; title='Imran Shah'
    mid='join us for a farewell gathering after thirty years of service'
    date='Friday &middot; 21 August 2026 &middot; 6 pm'
    venue='The Atrium, Head Office<br>Refreshments served'
    note='Reply to Ayesha in HR' }
}

function New-Tpl($slug, $name, $style, $design, $font, $art, $bg, $ink, $accent, $soft, $body,
                 $bgstyle = 'bg-plain', $foil = $false) {
  @{ slug=$slug; name=$name; style=$style; design=$design; font=$font; art=$art
     bg=$bg; ink=$ink; accent=$accent; soft=$soft; body=$body; bgstyle=$bgstyle; foil=$foil }
}

# --- category ----------------------------------------------------------------

$Category = @{
  slug  = 'wedding-events'
  name  = 'Weddings &amp; Events'
  short = 'Weddings'
  panel = 'Occasions'
  blurb = 'Eight occasions, four designs each, every one editable in the browser.'
  h1    = 'Wedding and Event Invitation Templates'
  title = 'Wedding &amp; Event Invitation Templates - Free Printable Cards'
  desc  = 'Free printable invitation templates for weddings, nikah ceremonies, engagements, showers, graduations, housewarmings and farewells. 5x7 inch designs.'
  intro = @(
    'Eight occasions, thirty-two designs, all built to the same 5&times;7 inch card size so you can buy one pack of envelopes and use any of them. Nothing here relies on stock photography - each card is drawn as typography and vector line work, which is why they stay sharp when printed and why you are free to use them.'
  )
}

# --- subcategories -----------------------------------------------------------

$Subcats = @(

 @{ slug='wedding-invitations'; name='Wedding Invitations'; nav='Wedding Invitations'
    h1='Wedding Invitation Templates'
    title='Wedding Invitation Templates - Free Printable 5x7 Designs'
    desc='Printable wedding invitation card templates in classic, floral and modern styles. Print at home on 5x7 card stock or save as PDF - free to use.'
    intro=@(
      'Every wedding invitation on this page is designed as a 5&times;7 inch card, the size most printers and envelope suppliers stock, so a design that looks right on screen also looks right on paper. Each one is drawn as clean typography and line work rather than a photograph, which means it prints sharply on matte, textured or lightly coated card.',
      'The four designs below cover the styles couples ask for most often: a foiled vine border, a full floral wreath with script lettering, a dark art deco card, and a stripped-back modern layout. Open any design to change the wording, colours, lettering and ornament, then print it or save it as a PDF.')
    faq=@(
      @('When should you send wedding invitations?','Send them six to eight weeks before the wedding day. If a large number of guests are travelling from another city or country, send a save-the-date around six months ahead and follow it with the full invitation at the eight week mark. Ask for RSVPs two to three weeks before the date so you can confirm catering numbers in time.'),
      @('What should be included in a wedding invitation?','Six things: who is hosting, the names of the couple, the request line, the date and time written out clearly, the venue with its full address, and how to reply. Dress code and reception details usually sit on a separate small card rather than crowding the main one.'),
      @('What is a wedding invitation suite?','A suite is the full set that goes into one envelope - the main invitation, an RSVP card, and often a details card for directions, hotels or dress code. Keeping every piece in the same typeface and colour is what makes a suite feel considered.'),
      @('Can I change the wording on these templates?','Yes. Every template on this site is editable in your browser: type your own names and details into the boxes beside the card, change the colours and lettering, then print or download. No account is needed.'))
    templates=@(
      (New-Tpl 'classic-forest-frame' 'Classic Forest Frame' 'Traditional &middot; foiled vine' 'd-frame' 'f-cormorant' 'vine' '#fbf8f1' '#1f3328' '#a8823f' '#5d6b5f' $Body.wedding 'bg-grad' $true),
      (New-Tpl 'blush-script' 'Blush Script' 'Romantic &middot; floral wreath' 'd-plain' 'f-script' 'wreath' '#fdf6f4' '#4a2c2a' '#c08497' '#7b5c5c' $Body.wedding 'bg-wash'),
      (New-Tpl 'midnight-gold' 'Midnight Gold' 'Art deco &middot; dark card' 'd-plain' 'f-cinzel' 'deco' '#1b2a41' '#f3efe6' '#c9a227' '#b9c2cf' $Body.wedding 'bg-edge' $true),
      (New-Tpl 'sage-minimal' 'Sage Minimal' 'Modern &middot; asymmetric' 'd-rule' 'f-josefin' 'botanical' '#f2f4ef' '#2f3b33' '#7e9b76' '#63705f' $Body.wedding)) },

 @{ slug='nikah-invitations'; name='Nikah Invitation Cards'; nav='Nikah Invitations'
    h1='Nikah Invitation Card Templates'
    title='Nikah Invitation Card Template - Free Printable Designs'
    desc='Printable nikah invitation card templates with geometric, mandala and calligraphic layouts. 5x7 inch, editable in your browser, Urdu and Arabic supported.'
    intro=@(
      'A nikah card carries less text than a full wedding invitation, so the typography has to do more work. These four designs give the names room to breathe and keep the ceremony details in a clear second line, which is what makes a small card readable at arm''s length.',
      'Two of the designs use geometric line work built from rotated squares and a radial mandala - pattern families that sit comfortably alongside Arabic and Urdu lettering. Switch the card to Nastaliq, Amiri or Naskh in the editor and the whole layout flips to right-to-left with the spacing those scripts need.')
    faq=@(
      @('What details go on a nikah invitation card?','The names of the couple, the families hosting, the date, the masjid or venue with its address, and the time - often given in relation to a prayer, such as after Jumu''ah. Many families open the card with the Bismillah line, which these templates leave space for.'),
      @('Should the nikah and walima be on the same card?','Only if both happen on the same day at the same venue. When the walima falls on a different day it reads more clearly as a second card, or as a small insert behind the main one, so guests do not confuse the two dates.'),
      @('Can these cards be printed in Urdu or Arabic?','Yes. Pick Nastaliq, Amiri or Naskh from the typeface list in the editor and the card switches to right-to-left, then type your own text into the boxes. The line spacing adjusts for those scripts automatically.'))
    templates=@(
      (New-Tpl 'emerald-geometry' 'Emerald Geometry' 'Geometric &middot; inner panel' 'd-panel' 'f-marcellus' 'geometric' '#f7f4ec' '#14392c' '#1f5c45' '#4f6459' $Body.nikah 'bg-grad'),
      (New-Tpl 'gold-lattice' 'Gold Lattice' 'Mandala &middot; dark card' 'd-plain' 'f-cinzel' 'mandala' '#14201b' '#f0e6d2' '#c9a227' '#bfc6b8' $Body.nikah 'bg-edge' $true),
      (New-Tpl 'ivory-calligraphy' 'Ivory Calligraphy' 'Script &middot; flourish' 'd-band' 'f-script' 'flourish' '#fcfaf5' '#2b2a26' '#8c7a4b' '#6d675c' $Body.nikah),
      (New-Tpl 'teal-minimal' 'Teal Minimal' 'Modern &middot; side rule' 'd-rule' 'f-josefin' 'botanical' '#f1f5f4' '#17403c' '#2e7d74' '#5a716e' $Body.nikah)) },

 @{ slug='engagement-invitations'; name='Engagement Invitations'; nav='Engagement Invitations'
    h1='Engagement Party Invitation Templates'
    title='Engagement Invitation Template - Free Printable Party Cards'
    desc='Engagement party invitation templates in script, classic and modern layouts. Printable 5x7 cards, editable in your browser, free to use.'
    intro=@(
      'An engagement invitation is warmer in tone than a wedding invitation and usually shorter - the news itself is the headline. These designs put the couple''s names at the top of the visual hierarchy and keep the venue line quiet underneath.',
      'Pick the bouquet or wreath design for an evening party at home, or the ink band and taupe layouts if the celebration is more formal. Each one prints as a 5&times;7 card and works in black and white if you are printing at a local shop.')
    faq=@(
      @('How far in advance do engagement invitations go out?','Three to four weeks before the party is enough for most guest lists. If relatives are flying in, give them six weeks so flights stay affordable.'),
      @('Who is named as the host on an engagement invitation?','Whoever is hosting - traditionally the bride''s family, though couples increasingly host themselves. If both families are hosting together, a simple opening line such as "Together with their families" covers it without listing every name.'),
      @('Should the wedding date be mentioned?','Only if it is already fixed and you want guests to hold it. Otherwise leave it off; an engagement party invitation that promises a date you later change causes more confusion than it saves.'))
    templates=@(
      (New-Tpl 'dusty-rose' 'Dusty Rose' 'Romantic &middot; corner bouquet' 'd-scallop' 'f-script' 'bouquet' '#fbf3f1' '#55303a' '#b37b7b' '#7d5b62' $Body.engagement 'bg-wash'),
      (New-Tpl 'wine-and-cream' 'Wine &amp; Cream' 'Classic &middot; floral wreath' 'd-frame' 'f-cormorant' 'wreath' '#faf6f2' '#4a1f2b' '#8e3b4e' '#71545c' $Body.engagement 'bg-grad'),
      (New-Tpl 'modern-taupe' 'Modern Taupe' 'Minimal &middot; side rule' 'd-rule' 'f-josefin' '' '#f5f2ee' '#3b3630' '#a08e75' '#6b645b' $Body.engagement),
      (New-Tpl 'ink-band' 'Ink Band' 'Editorial &middot; flourish' 'd-band' 'f-marcellus' 'flourish' '#fdfcfa' '#22282e' '#2f4858' '#5d666e' $Body.engagement)) },

 @{ slug='bridal-shower-invitations'; name='Bridal Shower Invitations'; nav='Bridal Shower Invitations'
    h1='Bridal Shower Invitation Templates'
    title='Bridal Shower Invitation Template - Free Printable Cards'
    desc='Printable bridal shower and wedding shower invitation templates in floral, lilac and modern styles. 5x7 inch, editable in your browser.'
    intro=@(
      'Bridal shower invitations carry practical information that the wedding invitation does not: the host''s home address, the start time, and often a note about gifts or a theme. These layouts keep that detail legible instead of squeezing it into a corner.',
      'The bouquet and wreath designs suit a garden or brunch setting; the mint and champagne layouts are cleaner and work well for an office or restaurant celebration. All four print as 5&times;7 cards.')
    faq=@(
      @('What is the difference between a bridal shower and a wedding shower?','In practice, very little - wedding shower is simply the broader term, used when guests of any gender are invited rather than only the bride''s close circle. The invitation wording is the same either way.'),
      @('How early should bridal shower invitations be sent?','Four to six weeks ahead. That is early enough for guests to plan around it, and late enough that the wedding date itself is already confirmed in everyone''s diary.'),
      @('Should gift or registry details go on the invitation?','Keep them off the main card. A small separate insert, or a single line at the bottom pointing to a registry link, reads better than putting gift instructions beside the bride''s name.'))
    templates=@(
      (New-Tpl 'peony-blush' 'Peony Blush' 'Floral &middot; corner bouquet' 'd-plain' 'f-script' 'bouquet' '#fdf4f5' '#5a3742' '#d08c9e' '#83616b' $Body.bridal 'bg-wash'),
      (New-Tpl 'lilac-garden' 'Lilac Garden' 'Classic &middot; floral wreath' 'd-frame' 'f-cormorant' 'wreath' '#f7f4fb' '#3f3550' '#9b87c4' '#6a6079' $Body.bridal 'bg-grad'),
      (New-Tpl 'mint-modern' 'Mint Modern' 'Minimal &middot; side rule' 'd-rule' 'f-josefin' 'botanical' '#f0f7f4' '#24403a' '#64a88f' '#546a63' $Body.bridal),
      (New-Tpl 'champagne-brunch' 'Champagne Brunch' 'Warm &middot; foiled flourish' 'd-band' 'f-marcellus' 'flourish' '#fdfaf3' '#3a3226' '#c9a870' '#6c6252' $Body.bridal 'bg-edge' $true)) },

 @{ slug='baby-shower-invitations'; name='Baby Shower Invitations'; nav='Baby Shower Invitations'
    h1='Baby Shower Invitation Templates'
    title='Baby Shower Invitation Template - Free Printable Boy &amp; Girl Cards'
    desc='Printable baby shower invitation templates for boys, girls and gender-neutral showers. 5x7 inch cards, editable in your browser.'
    intro=@(
      'These baby shower templates come in four colour directions - powder blue, blush, sage and warm yellow - so you can match a boy, girl or gender-neutral shower without redesigning anything. Every palette on the site can be swapped onto any of them in the editor.',
      'Each card leaves room for the two details guests actually need: the address, and whether food is being served. There is also a footer line you can use for an RSVP number or a note about gifts.')
    faq=@(
      @('When should baby shower invitations be sent?','Four to six weeks before the shower, which usually falls in the seventh or eighth month of pregnancy. Sending earlier gives guests time to arrange gifts and travel.'),
      @('Can these templates be used for a gender reveal?','Yes. The sage and yellow designs are deliberately gender-neutral, which is what a reveal invitation needs - the colour on the card should not give the answer away before the party.'),
      @('Whose name goes on a baby shower invitation?','The parent being celebrated, plus the host if someone else is organising it. The baby''s name only appears if it has already been chosen and shared.'))
    templates=@(
      (New-Tpl 'powder-blue' 'Powder Blue' 'Boy &middot; confetti' 'd-brackets' 'f-script' 'confetti' '#f2f7fb' '#27394d' '#7fa8c9' '#5a6b7d' $Body.baby 'bg-grad'),
      (New-Tpl 'blush-bloom' 'Blush Bloom' 'Girl &middot; floral wreath' 'd-scallop' 'f-cormorant' 'wreath' '#fdf3f5' '#4e3038' '#db93a5' '#7d5f67' $Body.baby 'bg-wash'),
      (New-Tpl 'sage-neutral' 'Sage Neutral' 'Neutral &middot; sprigs' 'd-frame' 'f-marcellus' 'botanical' '#f3f6f0' '#2e3b2c' '#7d9a6e' '#5c6a58' $Body.baby),
      (New-Tpl 'sunny-yellow' 'Sunny Yellow' 'Neutral &middot; confetti' 'd-band' 'f-josefin' 'confetti' '#fdfaf0' '#46402a' '#dfb63f' '#726b52' $Body.baby 'bg-grad')) },

 @{ slug='graduation-invitations'; name='Graduation Invitations'; nav='Graduation Invitations'
    h1='Graduation Invitation Templates'
    title='Graduation Invitation Template - Free Printable Party &amp; Ceremony Cards'
    desc='Printable graduation invitation and announcement templates for ceremonies and parties. 5x7 inch cards in navy, black-gold and modern styles.'
    intro=@(
      'A graduation card does two different jobs depending on how you use it: announcing the achievement, or inviting people to the party afterwards. These templates handle both - the degree line sits directly under the name, and the venue block below it can be cleared entirely if you are only announcing.',
      'The navy laurel and black-gold designs read as formal ceremony cards, both with a metallic foil finish on the line work. The confetti and burgundy layouts are lighter and suit a party at home.')
    faq=@(
      @('What is the difference between a graduation announcement and an invitation?','An announcement shares the news and expects nothing back. An invitation asks the reader to attend something, so it must carry a date, a venue and a way to reply. These templates work as either - clear the venue box for an announcement.'),
      @('When should graduation invitations be sent?','Three to four weeks before the ceremony or party. University ceremony tickets are often limited, so confirm how many guests you can bring before sending anything.'),
      @('Should the degree be written in full?','Yes, on a formal card - "Bachelor of Science in Computer Science" rather than "BSCS". Abbreviations read as informal and not every relative will recognise them.'))
    templates=@(
      (New-Tpl 'navy-laurel' 'Navy Laurel' 'Formal &middot; foiled laurel' 'd-frame' 'f-cinzel' 'laurel' '#f7f7f4' '#16233d' '#b08a3e' '#565f70' $Body.grad 'bg-grad' $true),
      (New-Tpl 'black-and-gold' 'Black &amp; Gold' 'Art deco &middot; dark card' 'd-plain' 'f-cinzel' 'deco' '#16161a' '#f2eee4' '#c9a227' '#bdb9b0' $Body.grad 'bg-edge' $true),
      (New-Tpl 'confetti-bright' 'Confetti Bright' 'Party &middot; corner brackets' 'd-brackets' 'f-josefin' 'confetti' '#fbfaf6' '#2a2e35' '#3f7a8c' '#5d646d' $Body.grad 'bg-wash'),
      (New-Tpl 'burgundy-classic' 'Burgundy Classic' 'Classic &middot; flourish' 'd-band' 'f-marcellus' 'flourish' '#faf7f4' '#3b1f27' '#7b2c3b' '#6d5a5f' $Body.grad)) },

 @{ slug='housewarming-invitations'; name='Housewarming Invitations'; nav='Housewarming Invitations'
    h1='Housewarming Invitation Templates'
    title='Housewarming Invitation Card Template - Free Printable Designs'
    desc='Printable housewarming party invitation templates with the new address set clearly. 5x7 inch cards, editable in your browser.'
    intro=@(
      'The address is the most important line on a housewarming invitation, and it is the line most designs bury. Each of these templates gives the new address its own block with generous spacing around it, so guests can read it at a glance or photograph it for their maps app.',
      'The arch design borrows the shape of a doorway, which suits the occasion without resorting to clip art. The clay, sage and slate layouts are quieter alternatives if you are inviting colleagues as well as family.')
    faq=@(
      @('How much notice do housewarming invitations need?','Two to three weeks is plenty. A housewarming is an informal gathering and most guests decide quickly, so sending months ahead tends to work against you.'),
      @('Should I say that gifts are not expected?','If you mean it, say it plainly - a short line such as "Your company is gift enough" at the bottom of the card. The footer box in the editor is there for exactly this.'),
      @('Can these templates be used for a casual or funny invite?','Yes. The layout stays the same; only the wording changes. A light opening line above the family name is usually enough to set an informal tone without making the address harder to read.'))
    templates=@(
      (New-Tpl 'ochre-arch' 'Ochre Arch' 'Warm &middot; doorway arch' 'd-arch' 'f-marcellus' 'arch' '#fdf8ef' '#3e3324' '#c08a2e' '#6d6250' $Body.house 'bg-grad'),
      (New-Tpl 'clay-minimal' 'Clay Minimal' 'Minimal &middot; side rule' 'd-rule' 'f-josefin' '' '#f8f4f0' '#45372f' '#a4674c' '#6f625a' $Body.house),
      (New-Tpl 'sage-cottage' 'Sage Cottage' 'Classic &middot; vine border' 'd-frame' 'f-cormorant' 'vine' '#f2f5ef' '#2c3a2c' '#6e8b62' '#5a675a' $Body.house),
      (New-Tpl 'slate-modern' 'Slate Modern' 'Modern &middot; geometric' 'd-band' 'f-josefin' 'geometric' '#f4f6f7' '#253038' '#46626f' '#5c666d' $Body.house 'bg-edge')) },

 @{ slug='farewell-retirement-invitations'; name='Farewell &amp; Retirement Invitations'; nav='Farewell &amp; Retirement'
    h1='Farewell and Retirement Party Invitation Templates'
    title='Farewell Party Invitation Template - Free Printable Retirement Cards'
    desc='Printable farewell and retirement party invitation templates for offices and colleagues. 5x7 inch cards in slate, teal and classic styles.'
    intro=@(
      'Farewell and retirement invitations are usually sent by colleagues rather than family, which changes the tone: the card should be warm but still appropriate to pin on an office notice board. These four designs stay on the right side of that line.',
      'Each layout has a line above the name for the sentiment - years of service, a thank you, or a short send-off phrase - so the card acknowledges the person rather than only announcing a party.')
    faq=@(
      @('What should a retirement party invitation say?','The person''s name, how long they served or what they are being thanked for, the date and time, the venue, and who to reply to. If colleagues are contributing to a gift, mention that separately by email rather than on the card.'),
      @('How far ahead should a farewell invitation go out?','Two to three weeks for an office gathering. If the person is leaving sooner than that, send it as soon as the date is fixed - a short notice card is better than none.'),
      @('Can the same template work for a colleague relocating?','Yes. The wording above the name is the only part that changes - swap the years-of-service line for a farewell or good-luck line and the rest of the card still fits.'))
    templates=@(
      (New-Tpl 'slate-gratitude' 'Slate Gratitude' 'Formal &middot; laurel' 'd-frame' 'f-marcellus' 'laurel' '#f6f7f8' '#232c33' '#4c6377' '#5b656d' $Body.farewell 'bg-grad'),
      (New-Tpl 'deep-teal' 'Deep Teal' 'Art deco &middot; dark card' 'd-plain' 'f-cormorant' 'deco' '#14343a' '#eff3f1' '#c9a227' '#b3c4c1' $Body.farewell 'bg-edge' $true),
      (New-Tpl 'warm-grey-classic' 'Warm Grey Classic' 'Classic &middot; flourish' 'd-rule' 'f-cinzel' 'flourish' '#f7f5f2' '#35302b' '#8a7a63' '#6b635a' $Body.farewell),
      (New-Tpl 'gold-send-off' 'Gold Send-off' 'Warm &middot; foiled wreath' 'd-band' 'f-script' 'wreath' '#fcfaf6' '#2f2a22' '#b08a3e' '#6b6459' $Body.farewell 'bg-grad' $true)) }
)

# --- guides ------------------------------------------------------------------

$Guides = @(
 @{ slug='when-to-send-wedding-invitations'
    title='When to Send Wedding Invitations - A Complete Timeline'
    h1='When to Send Wedding Invitations'
    desc='How many weeks before the wedding to post invitations, when to send save-the-dates, and when to set the RSVP deadline.'
    read='6 min read'
    body=@(
      @('p','The short answer is six to eight weeks before the wedding day. The longer answer depends on how far your guests are travelling, whether you have already sent a save-the-date, and how much notice your caterer needs for final numbers.'),
      @('h2','The standard timeline'),
      @('p','Most couples work backwards from the wedding date in four steps.'),
      @('ol',@(
        '<strong>Six to twelve months before:</strong> send save-the-dates, but only if you have a firm date and venue. A save-the-date you later change is worse than none at all.',
        '<strong>Eight weeks before:</strong> post the invitations. This is the sweet spot - close enough that guests still have the date in their heads, far enough that they can book leave or travel.',
        '<strong>Three weeks before:</strong> set your RSVP deadline. Not two, and not one - you will spend the last fortnight chasing the guests who have not replied.',
        '<strong>One week before:</strong> confirm final numbers with the caterer and the venue, using the replies you actually received rather than the ones you expect.')),
      @('h2','When to send them earlier'),
      @('p','Push the invitation date out to three months if any of the following apply:'),
      @('ul',@(
        'A significant number of guests are flying in, especially internationally, where visa appointments and fares reward early booking.',
        'The wedding falls in a peak season - December, or a public holiday weekend - when hotels near the venue sell out.',
        'You are hosting over several days, so guests need to book more than one night off work.')),
      @('h2','When it is fine to send them later'),
      @('p','A small wedding of thirty local guests does not need eight weeks. Four is comfortable, and three is workable if you follow up by phone. Short notice is only a real problem when guests need to travel or arrange childcare, so judge it by your actual list rather than by the rule.'),
      @('h2','Set the RSVP deadline before your catering deadline'),
      @('p','Ask your venue when they need final numbers, then set the RSVP date at least a week earlier. That gap is not padding - it is the time you will spend contacting the guests who did not reply, which is a normal part of every wedding, not a sign that anything went wrong.'),
      @('h2','A note on printing time'),
      @('p','If you are printing at a local press rather than at home, add ten days to everything above. Proofs come back with mistakes more often than not, and a reprint costs another few days. Printing at home from a PDF removes that risk entirely, which is the main practical argument for it.'),
      @('cta','wedding-invitations')) },

 @{ slug='what-to-include-in-a-wedding-invitation'
    title='What to Include in a Wedding Invitation - Every Line Explained'
    h1='What Should Be Included in a Wedding Invitation'
    desc='The six elements every wedding invitation needs, what belongs on a separate details card, and the mistakes that cause guests to call and ask.'
    read='7 min read'
    body=@(
      @('p','A wedding invitation has one job: to tell a guest where to be, when to be there, and how to reply. Everything else is decoration. These are the six lines that do that work, in the order they normally appear on the card.'),
      @('h2','1. The host line'),
      @('p','Whoever is paying for or hosting the wedding is named first. Traditionally that is the bride''s parents. Where both families host, or the couple hosts themselves, a line such as "Together with their families" covers everyone without a list of names that crowds the top of the card.'),
      @('h2','2. The names of the couple'),
      @('p','The largest text on the card. On formal invitations the bride''s name traditionally comes first, and surnames are included when the host line does not already make the families clear.'),
      @('h2','3. The request line'),
      @('p','"Request the pleasure of your company" is the standard formal phrasing. "Would love you to join them" is the warm equivalent. The phrase you choose sets the tone of the whole event, so it is worth reading a few aloud before deciding.'),
      @('h2','4. The date and time, written out'),
      @('p','On a formal card, dates are written in words - "Saturday, the fourteenth of March, two thousand and twenty-six" - and times as "six in the evening" rather than 6:00 PM. On a modern card, numerals are perfectly acceptable. What matters is that you do not mix the two styles on one card.'),
      @('h2','5. The venue and full address'),
      @('p','Name the venue, then the street, then the city. Guests will type this into a maps app, so an incomplete address is the single most common reason a wedding invitation generates phone calls.'),
      @('h2','6. How to reply'),
      @('p','Either an RSVP card with a stamped envelope, or a line with a phone number, or a link. Whichever you pick, give a deadline - an invitation without one produces replies that arrive the week of the wedding.'),
      @('h2','What belongs on a separate card'),
      @('ul',@(
        'Directions, parking notes and hotel suggestions.',
        'Dress code, if it needs more explanation than one word.',
        'Reception details, when the reception is at a different venue.',
        'Registry information, which never belongs on the main invitation.')),
      @('h2','The three mistakes that cause phone calls'),
      @('ol',@(
        'Leaving off the year. Guests receiving a card in December cannot always tell which March you mean.',
        'Naming the venue without its address, on the assumption that locals will know it.',
        'Being vague about who is invited. If children are not invited, the envelope should be addressed to the adults by name, and the card can say "Adult reception".')),
      @('cta','wedding-invitations')) },

 @{ slug='wedding-invitation-wording'
    title='Wedding Invitation Wording - Formal, Modern and Nikah Examples'
    h1='Wedding Card Invitation Wording Examples'
    desc='Copy-and-paste wedding invitation wording for formal, casual, bride-hosted and nikah invitations, with notes on when each one fits.'
    read='8 min read'
    body=@(
      @('p','Wording is where most couples get stuck, because the card has to sound like them while still being clear. Below are wordings you can copy directly and adjust - grouped by who is hosting and how formal the wedding is.'),
      @('h2','Formal - the bride''s parents hosting'),
      @('blockquote','Mr and Mrs Tariq Mahmood<br>request the pleasure of your company<br>at the marriage of their daughter<br><strong>Ayesha</strong><br>to<br><strong>Bilal Ahmed</strong><br>Saturday, the fourteenth of March<br>two thousand and twenty-six<br>at six in the evening<br>Rose Garden Hall, Lahore'),
      @('h2','Formal - both families hosting'),
      @('blockquote','Together with their families<br><strong>Ayesha Mahmood</strong><br>and<br><strong>Bilal Ahmed</strong><br>request the honour of your presence<br>at their wedding<br>Saturday, 14 March 2026 at 6 pm<br>Rose Garden Hall, Lahore'),
      @('h2','Modern - the couple hosting'),
      @('blockquote','We are getting married!<br><strong>Ayesha &amp; Bilal</strong><br>and we would love you there<br>Saturday, 14 March 2026<br>Six in the evening<br>Rose Garden Hall, Lahore<br>Dinner, dancing, and a late finish'),
      @('h2','Nikah ceremony'),
      @('blockquote','Bismillah ir-Rahman ir-Raheem<br>With the blessings of Allah<br>the families of<br><strong>Fatima</strong> and <strong>Usman</strong><br>invite you to their Nikah<br>Friday, 20 March 2026, following Jumu''ah prayers<br>Jamia Masjid Al-Noor, Karachi'),
      @('h2','Small or intimate wedding'),
      @('blockquote','Two families, one small room, and everyone who matters<br><strong>Ayesha &amp; Bilal</strong><br>14 March 2026 &middot; 6 pm<br>Rose Garden Hall, Lahore<br>Please reply by 21 February'),
      @('h2','How to adjust any of these'),
      @('ul',@(
        'Keep one voice throughout. A formal host line followed by a casual request line reads as an unfinished draft.',
        'Read it aloud. Wording that sounds stiff when spoken will feel stiff when read.',
        'Break lines by meaning, not by width - each line should be a complete thought.',
        'Check the year, the day of the week, and the venue address against a calendar and a map before printing anything.')),
      @('h2','Wording for the reply line'),
      @('p','"Kindly reply by 21 February" is the formal version, "Let us know by 21 February" the casual one. Always give a date. If you are collecting replies by phone or message rather than by card, say so explicitly, because guests default to whatever is easiest and will otherwise tell you in person weeks later.'),
      @('cta','wedding-invitations')) }
)
