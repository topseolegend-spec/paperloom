# =============================================================================
#  Marketing &amp; Social Media category
#  Subcategories search volume ke hisaab se tarteeb mein hain.
#
#  Ye baaki categories se ek buniyadi tor par alag hain: zyadatar screen ke liye
#  hain, kaghaz ke liye nahi. Is liye har size ka apna exact pixel target hai
#  (1080x1080, 1280x720 waghera) - 300dpi print width nahi.
#
#  Aspect ratios bohot mukhtalif hain (1:1 se 4:1 tak), is liye har size apna
#  --promo-scale rakhta hai: chaurey formats par type chhota hota hai, warna
#  cqw units use ki gayi type banner ki height se bahar nikal jati.
#
#  ZAROORI: is file mein Urdu/Arabic text seedha na likhein - HTML entities.
# =============================================================================

$FieldsPromo = @(
  (New-Field 'kicker' 'Line above'      'text' 'Words'  'Date, label - leave empty to hide'),
  (New-Field 'title'  'Headline'        'text' 'Words'  'The big line'),
  (New-Field 'sub'    'Subheading'      'text' 'Words'  'Leave empty to hide'),
  (New-Field 'body'   'Details'         'area' 'Words'  'One per line - leave empty to hide'),
  (New-Field 'cta'    'Call to action'  'text' 'Footer' 'Shop now, link, offer'),
  (New-Field 'brand'  'Brand or handle' 'text' 'Footer' '')
)

$FieldsLogo = @(
  (New-Field 'mark'    'Monogram letters' 'text' 'Logo' 'One or two letters'),
  (New-Field 'title'   'Brand name'       'text' 'Logo' ''),
  (New-Field 'tagline' 'Tagline'          'text' 'Logo' 'Leave empty to hide'),
  (New-Field 'est'     'Established line'  'text' 'Logo' 'Leave empty to hide')
)

# --- sample copy --------------------------------------------------------------

$MBody = @{
  poster = @{ kicker='Saturday 14 March'; title='Spring Night Market'
    sub='Forty stalls, live music, street food'
    body='Gulberg Green, Lahore<br>Six until late<br>Entry free'
    cta='marigoldmarkets.pk'; brand='Marigold Markets' }
  flyer = @{ kicker='Now open in Gulberg'; title='Meridian Coffee'
    sub='Roasted in-house, poured properly'
    body='24 Gulberg Boulevard<br>Seven till nine, daily<br>+92 300 1234567'
    cta='20% off your first cup'; brand='meridiancoffee.pk' }
  igpost = @{ kicker='New this week'; title='Winter Collection'
    sub='Made in Lahore, built to last'
    body='Ships nationwide<br>Free returns within 14 days'
    cta='Shop the drop'; brand='@meridianstudio' }
  ytthumb = @{ kicker='Episode 12'; title='I Rebuilt My Site In One Day'
    sub='and it cost nothing'
    body=''
    cta='Watch now'; brand='@meridian' }
  igstory = @{ kicker='Today only'; title='24 Hour Sale'
    sub='Everything thirty per cent off'
    body='Use code MARCH30 at checkout'
    cta='Swipe up'; brand='@meridianstudio' }
  fbcover = @{ kicker=''; title='Meridian Studio'
    sub='Product design and research, Lahore'
    body=''
    cta='meridian.co'; brand='' }
  linkedin = @{ kicker=''; title='Amara Sheikh'
    sub='Senior Product Designer - design systems, research, payments'
    body=''
    cta='amara.sheikh@email.com'; brand='' }
  webbanner = @{ kicker='Limited time'; title='30% Off'
    sub='Winter collection'
    body=''
    cta='Shop now'; brand='meridian.co' }
  logo = @{ mark='M'; title='Meridian'; tagline='Design and Research'; est='Established 2019' }
}

# --- category -----------------------------------------------------------------

$MCategory = @{
  slug  = 'marketing-social'
  accent = '#b4472e'
  name  = 'Marketing &amp; Social'
  short = 'Marketing'
  panel = 'Formats'
  blurb = 'Posters and flyers for print, and social graphics at the sizes each platform actually wants.'
  h1    = 'Marketing and Social Media Templates'
  title = 'Marketing &amp; Social Media Templates - Free Editable Designs'
  desc  = 'Free editable poster, flyer, Instagram, YouTube thumbnail, Facebook and LinkedIn templates at the correct sizes. Type your own words, then download the image.'
  intro = @(
    'Nine formats, thirty-six designs, each one built at the size its platform expects rather than a square you have to crop afterwards. Type your words into the boxes beside the artwork and it updates as you write.',
    'These are mostly for screens rather than paper, so the download is the point: each format exports at its real pixel size - 1080 square for an Instagram post, 1280 by 720 for a thumbnail, 1584 by 396 for a LinkedIn banner - and nothing is watermarked.'
  )
}

function New-Promo($slug, $name, $style, $design, $font, $art, $bg, $ink, $accent, $soft, $body,
                   $bgstyle = 'bg-plain', $foil = $false) {
  @{ slug=$slug; name=$name; style=$style; design=$design; font=$font; art=$art
     bg=$bg; ink=$ink; accent=$accent; soft=$soft; body=$body; bgstyle=$bgstyle; foil=$foil }
}

$MSubcats = @(

 @{ slug='poster-templates'; name='Poster Templates'; nav='Posters'
    kind='promo'; sizeset='poster'; size='sz-a3'; fields=$FieldsPromo; ornaments=$true
    h1='Poster Templates'
    title='Poster Template - Free Editable A3 Designs You Can Print'
    desc='Free editable poster templates for events, gigs and notices. Type your own headline and details, then print at A3 or download the image.'
    guideNote='A poster is read from across a room and a <a href="../../marketing-social/flyer-templates/">flyer</a> from the hand, so the same wording rarely works on both - the <a href="../../guides/how-to-design-a-flyer/">three-second test</a> is the quickest way to check which one you have actually made.'
    intro=@(
      'A poster is read from across a room by someone walking past, which settles most of the design questions: one line has to be much larger than everything else, and the practical details go at the bottom where people look once they have stopped.',
      'These four keep that hierarchy and give you A3, A2 and US poster sizes in the editor. Open Air and Studio Grid are the restrained pair; Colour Field and Deco Night carry more, which is what an event poster usually needs to survive a noticeboard.')
    faq=@(
      @('What size should a poster be?','A3 for a noticeboard or a shop window, A2 for anywhere people stand back from it. Both are stocked by every print shop, and both are in the editor.'),
      @('How much text should a poster carry?','One headline, one supporting line, and the practical details. If a passer-by cannot get the what, where and when in about three seconds, the poster is doing too much.'),
      @('Can I use a poster design on Instagram too?','Yes - switch the size to square or portrait in the editor and the layout adjusts, then download at 1080. The wording usually needs shortening for a feed.'))
    templates=@(
      (New-Promo 'open-air' 'Open Air' 'Simple &middot; strong hierarchy' 'p-clean' 'f-tenor' '' '#fbfaf7' '#1c2128' '#b4472e' '#59616b' $MBody.poster),
      (New-Promo 'studio-grid' 'Studio Grid' 'Modern &middot; offset block' 'p-modern' 'f-josefin' '' '#ffffff' '#161a20' '#2f4858' '#5a6470' $MBody.poster),
      (New-Promo 'colour-field' 'Colour Field' 'Filled &middot; full colour ground' 'p-bold' 'f-italiana' '' '#1f3d34' '#f4f1e8' '#e0a94a' '#c3ccc4' $MBody.poster 'bg-edge'),
      (New-Promo 'deco-night' 'Deco Night' 'Decorated &middot; art deco and foil' 'p-panel' 'f-cinzel-dec' 'deco' '#15161c' '#f2eee4' '#c9a227' '#b9b6ae' $MBody.poster 'bg-edge' $true)) },

 @{ slug='flyer-templates'; name='Flyer Templates'; nav='Flyers'
    kind='promo'; sizeset='flyer'; size='sz-a5'; fields=$FieldsPromo; ornaments=$true
    h1='Flyer Templates'
    title='Flyer Template - Free Editable Designs for Business'
    desc='Free editable flyer templates for shops, cafes, services and events. Add your own offer and contact details, then print at A5 or A4.'
    guideNote='The commonest and most expensive mistake is leading with your business name instead of the offer - that, the three-second test and how many to print first are in <a href="../../guides/how-to-design-a-flyer/">how to design a flyer</a>.'
    intro=@(
      'A flyer is handed over or pushed through a door, and it gets about two seconds before someone decides whether to keep it. That makes the offer the headline - not the business name, which is what most flyers lead with and why most flyers get binned.',
      'All four put the offer where the eye lands and the contact details at the foot. Print at A5 for handing out, A4 for a noticeboard; both are in the editor.')
    faq=@(
      @('What should a flyer say?','The offer, who it is for, and how to act on it. A business name at the top and a list of services underneath is the commonest mistake - nobody is looking for you yet, so lead with what they get.'),
      @('What size are flyers usually printed at?','A5 is standard for handouts and letterbox drops, A4 for noticeboards and shop windows. A5 is also cheaper in quantity, which matters at a thousand copies.'),
      @('What paper should I use?','130-170gsm for handouts - light enough to carry a stack, heavy enough not to feel disposable. Anything glossier is only worth it if there are photographs, and there are none here.'))
    templates=@(
      (New-Promo 'plain-offer' 'Plain Offer' 'Simple &middot; offer first' 'p-clean' 'f-tenor' '' '#ffffff' '#1c2128' '#2e5d4b' '#59616b' $MBody.flyer),
      (New-Promo 'corner-block' 'Corner Block' 'Modern &middot; offset block' 'p-modern' 'f-josefin' '' '#fbfbfa' '#171b22' '#c1543f' '#5a6470' $MBody.flyer),
      (New-Promo 'warm-panel' 'Warm Panel' 'Filled &middot; tinted panel' 'p-panel' 'f-marcellus' 'flourish' '#fdf8f0' '#3c3122' '#b07a2e' '#6d6252' $MBody.flyer 'bg-grad'),
      (New-Promo 'ink-ground' 'Ink Ground' 'Filled &middot; full colour ground' 'p-bold' 'f-playfair' '' '#1b2430' '#f1f0ec' '#e0a94a' '#b8bec6' $MBody.flyer 'bg-edge')) },

 @{ slug='instagram-post-templates'; name='Instagram Post Templates'; nav='Instagram Posts'
    kind='promo'; sizeset='igpost'; size='sz-ig'; fields=$FieldsPromo; ornaments=$true
    h1='Instagram Post Templates'
    title='Instagram Post Template - Free Editable 1080x1080 Designs'
    desc='Free editable Instagram post templates at 1080x1080 and 1080x1350. Type your own words and download the image - no account, no watermark.'
    guideNote='The same design switches to a <a href="../../marketing-social/instagram-story-templates/">story</a> without a redesign, and uploading a bigger file does not make either one sharper - the reasons are in <a href="../../guides/social-media-image-sizes/">social media image sizes</a>.'
    intro=@(
      'An Instagram post is seen at about the size of a matchbox before anyone decides to stop, so the headline has to survive being small. These four are set with that in mind: short lines, high contrast, and nothing fussy at the edges where the crop can bite.',
      'Square is the default and portrait at 1080 by 1350 is in the editor, which takes more room in the feed. Both download at full resolution.')
    faq=@(
      @('What size is an Instagram post?','1080 by 1080 for square and 1080 by 1350 for portrait. Portrait takes more vertical space in the feed, which is why most brands now post it.'),
      @('Why does my text look small in the feed?','Because the feed shows the post at roughly a third of its real size. If the headline is not readable when you shrink the preview to the width of your thumb, shorten it rather than making the type bigger.'),
      @('Can I use the same design for a story?','Switch the size to 9:16 in the editor and the layout re-flows for it. Keep the important part in the middle - the top and bottom of a story are covered by the interface.'))
    templates=@(
      (New-Promo 'clean-feed' 'Clean Feed' 'Simple &middot; strong hierarchy' 'p-clean' 'f-josefin' '' '#fbfaf7' '#1a1e24' '#2f4858' '#5a6470' $MBody.igpost),
      (New-Promo 'offset-modern' 'Offset Modern' 'Modern &middot; offset block' 'p-modern' 'f-tenor' '' '#ffffff' '#171b22' '#c1543f' '#5a6470' $MBody.igpost),
      (New-Promo 'soft-panel-ig' 'Soft Panel' 'Filled &middot; tinted panel' 'p-panel' 'f-cormorant' 'botanical' '#fdf6f3' '#3f2f2a' '#b3715a' '#75625b' $MBody.igpost 'bg-wash'),
      (New-Promo 'deep-ground' 'Deep Ground' 'Filled &middot; full colour ground' 'p-bold' 'f-italiana' '' '#1f3d34' '#f4f1e8' '#e0a94a' '#c3ccc4' $MBody.igpost 'bg-edge')) },

 @{ slug='youtube-thumbnail-templates'; name='YouTube Thumbnail Templates'; nav='YouTube Thumbnails'
    kind='promo'; sizeset='yt'; size='sz-yt'; fields=$FieldsPromo; ornaments=$true
    h1='YouTube Thumbnail Templates'
    title='YouTube Thumbnail Template - Free Editable 1280x720 Designs'
    desc='Free editable YouTube thumbnail templates at 1280x720. Add your own title text and download the image ready to upload.'
    guideNote='A duration badge sits over the bottom right of every thumbnail once it is uploaded, so nothing you need read belongs there - <a href="../../guides/social-media-image-sizes/">the interface sits on top of the design</a> on every platform, in a different place each time.'
    intro=@(
      'A thumbnail is judged at about 200 pixels wide on a phone, so the only thing that matters is whether the words are legible at that size. Three or four words is the working limit, and these four are built around that rather than around decoration.',
      'All four export at exactly 1280 by 720, which is what YouTube asks for. Keep the right-hand corner clear if you can - the duration badge sits there.')
    faq=@(
      @('What size should a YouTube thumbnail be?','1280 by 720 pixels, 16:9, under 2MB. These export at exactly that size.'),
      @('How many words should a thumbnail have?','Three or four. At the size most people see it, anything longer becomes a grey smudge - and the title is already written underneath it.'),
      @('Should the thumbnail repeat the video title?','No. It should say the thing the title does not - the hook, the result, the number. The two are read together, so repeating one in the other wastes half the space.'))
    templates=@(
      (New-Promo 'plain-hook' 'Plain Hook' 'Simple &middot; strong hierarchy' 'p-clean' 'f-josefin' '' '#ffffff' '#14181e' '#c1543f' '#5a6470' $MBody.ytthumb),
      (New-Promo 'split-bold' 'Split Bold' 'Modern &middot; offset block' 'p-modern' 'f-tenor' '' '#f7f8f9' '#161a20' '#2f4858' '#5a6470' $MBody.ytthumb),
      (New-Promo 'panel-accent' 'Panel Accent' 'Filled &middot; tinted panel' 'p-panel' 'f-playfair' 'geometric' '#fdfaf3' '#2c2a24' '#b07a2e' '#665f52' $MBody.ytthumb 'bg-grad'),
      (New-Promo 'night-ground' 'Night Ground' 'Filled &middot; full colour ground' 'p-bold' 'f-josefin' '' '#15161c' '#f4f2ec' '#e0a94a' '#b9b6ae' $MBody.ytthumb 'bg-edge')) },

 @{ slug='instagram-story-templates'; name='Instagram Story Templates'; nav='Instagram Stories'
    kind='promo'; sizeset='story'; size='sz-story'; fields=$FieldsPromo; ornaments=$true
    h1='Instagram Story Templates'
    title='Instagram Story Template - Free Editable 1080x1920 Designs'
    desc='Free editable Instagram story templates at 1080x1920 for sales, announcements and links. Type your words and download the image.'
    guideNote='Your profile sits over the top of a story and the reply bar over the bottom, which leaves the middle as the only safe band - the same rule, with the numbers, is in <a href="../../guides/social-media-image-sizes/">social media image sizes</a>.'
    intro=@(
      'A story is full screen and gone in five seconds, which makes it the easiest format to over-fill. These four keep the message to one idea and hold it in the middle third, where the platform''s own buttons will not sit on top of it.',
      'All four export at 1080 by 1920. If you are adding a link sticker, leave the lower third clear when you write the details line.')
    faq=@(
      @('What size is an Instagram story?','1080 by 1920 pixels, 9:16. These export at exactly that.'),
      @('Why is my text hidden behind the interface?','Instagram puts your profile at the top and the reply bar and stickers at the bottom. Keep anything that matters within the middle 60% of the height - these layouts already do.'),
      @('Can I use these for Reels covers or TikTok?','Yes - both use the same 9:16 canvas. For a Reels cover, remember the bottom is cropped in the grid view, so keep the headline high.'))
    templates=@(
      (New-Promo 'plain-story' 'Plain Story' 'Simple &middot; strong hierarchy' 'p-clean' 'f-tenor' '' '#fbfaf7' '#1a1e24' '#2f4858' '#5a6470' $MBody.igstory),
      (New-Promo 'block-story' 'Block Story' 'Modern &middot; offset block' 'p-modern' 'f-josefin' '' '#ffffff' '#171b22' '#c1543f' '#5a6470' $MBody.igstory),
      (New-Promo 'blush-story' 'Blush Story' 'Filled &middot; tinted panel' 'p-panel' 'f-parisienne' 'botanical' '#fdf5f4' '#432c2a' '#c07a5c' '#7a5f58' $MBody.igstory 'bg-wash'),
      (New-Promo 'sale-ground' 'Sale Ground' 'Filled &middot; full colour ground' 'p-bold' 'f-josefin' '' '#2b1620' '#f5ebe9' '#e0a94a' '#c9b8b8' $MBody.igstory 'bg-edge')) },

 @{ slug='facebook-cover-templates'; name='Facebook Cover Templates'; nav='Facebook Covers'
    kind='promo'; sizeset='fbcover'; size='sz-fbcover'; fields=$FieldsPromo
    h1='Facebook Cover Templates'
    title='Facebook Cover Template - Free Editable 820x312 Designs'
    desc='Free editable Facebook cover photo templates at 820x312 for pages and profiles. Add your business name and download the image.'
    guideNote='A cover crops differently on a phone than on a desktop, so anything essential stays central - that, and the rest of the sizes worth knowing, are in <a href="../../guides/social-media-image-sizes/">social media image sizes</a>.'
    intro=@(
      'A Facebook cover is a wide strip that gets cropped differently on a phone than on a desktop, and the profile picture sits over the left of it. These four keep the wording centred and short so nothing important lands under the crop or the avatar.',
      'Say who you are and what you do. A cover carrying a full list of services is unreadable at the height Facebook gives it.')
    faq=@(
      @('What size is a Facebook cover photo?','820 by 312 pixels for a page. Mobile crops the sides, so anything near the left or right edge may not be seen.'),
      @('Where does the profile picture sit?','Over the lower left on desktop, centred on mobile. Keeping the wording centred and away from the bottom left is the safe approach, which is what these do.'),
      @('Can I use the same file for a group or event cover?','A group cover is a similar shape and will work. Event covers are a different ratio again, so switch the size in the editor rather than reusing the file.'))
    templates=@(
      (New-Promo 'plain-cover' 'Plain Cover' 'Simple &middot; centred' 'p-clean' 'f-tenor' '' '#fbfaf7' '#1c2128' '#2e5d4b' '#59616b' $MBody.fbcover),
      (New-Promo 'band-cover' 'Band Cover' 'Modern &middot; offset block' 'p-modern' 'f-josefin' '' '#ffffff' '#161a20' '#2f4858' '#5a6470' $MBody.fbcover),
      (New-Promo 'panel-cover' 'Panel Cover' 'Filled &middot; tinted panel' 'p-panel' 'f-cormorant' '' '#fdfaf3' '#2c2a24' '#a8823f' '#665f52' $MBody.fbcover 'bg-grad'),
      (New-Promo 'ground-cover' 'Ground Cover' 'Filled &middot; full colour ground' 'p-bold' 'f-italiana' '' '#1f3d34' '#f4f1e8' '#e0a94a' '#c3ccc4' $MBody.fbcover 'bg-edge')) },

 @{ slug='linkedin-banner-templates'; name='LinkedIn Banner Templates'; nav='LinkedIn Banners'
    kind='promo'; sizeset='linkedin'; size='sz-linkedin'; fields=$FieldsPromo
    h1='LinkedIn Banner Templates'
    title='LinkedIn Banner Template - Free Editable 1584x396 Designs'
    desc='Free editable LinkedIn banner templates at 1584x396 for job seekers and professionals. Add your name and headline, then download.'
    guideNote='Your profile photo covers the lower left of this banner, so the right half is the usable half - see <a href="../../guides/social-media-image-sizes/">social media image sizes</a>. If you are mid-application, the banner and the <a href="../../business-office/cv-resume-templates/">CV</a> should agree on the same job title.'
    intro=@(
      'A LinkedIn banner is four times as wide as it is tall, and your profile photo covers the lower left of it. That leaves a band across the middle and right - which is exactly where these four put the wording.',
      'For a job search, the useful banner says what you do and how to reach you, because a recruiter reading your profile has both in front of them at once. These are set up for that rather than for decoration.')
    faq=@(
      @('What size is a LinkedIn banner?','1584 by 396 pixels. These export at exactly that.'),
      @('What should a LinkedIn banner say?','Your discipline in a few words, and a contact route. If you are open to work, that line belongs here as much as in your headline.'),
      @('Where does the profile photo sit?','Over the lower left corner on desktop, and it covers more of the banner on mobile. Keep the left sixth clear - these layouts already avoid it.'))
    templates=@(
      (New-Promo 'plain-banner' 'Plain Banner' 'Simple &middot; right aligned' 'p-clean' 'f-tenor' '' '#fbfaf7' '#1c2128' '#2f4858' '#59616b' $MBody.linkedin),
      (New-Promo 'block-banner' 'Block Banner' 'Modern &middot; offset block' 'p-modern' 'f-josefin' '' '#ffffff' '#171b22' '#2e5d4b' '#5a6470' $MBody.linkedin),
      (New-Promo 'panel-banner' 'Panel Banner' 'Filled &middot; tinted panel' 'p-panel' 'f-libre' '' '#f8f9fa' '#1b2430' '#22394f' '#59636e' $MBody.linkedin 'bg-grad'),
      (New-Promo 'ground-banner' 'Ground Banner' 'Filled &middot; full colour ground' 'p-bold' 'f-tenor' '' '#1b2430' '#f1f2f4' '#7fa8c9' '#b6bec8' $MBody.linkedin 'bg-edge')) },

 @{ slug='web-banner-templates'; name='Web Banner Templates'; nav='Web Banners'
    kind='promo'; sizeset='webad'; size='sz-mrec'; fields=$FieldsPromo; ornaments=$true
    h1='Web Banner Templates'
    title='Banner Ad Template - Free Editable Web Banner Designs'
    desc='Free editable web banner and display ad templates at standard sizes including 300x250 and 728x90. Add your offer and download.'
    guideNote='These are the three display sizes worth making first; the rest of the platform dimensions, and the two rules that matter more than any of them, are in <a href="../../guides/social-media-image-sizes/">social media image sizes</a>.'
    intro=@(
      'Display banners are small, and the offer is the whole message. These four carry a headline, one supporting line and a call to action - which is all that fits at 300 by 250 and rather more than fits at 728 by 90.',
      'The editor holds the three sizes worth designing for: the medium rectangle, the leaderboard, and the half-page skyscraper. The same wording rarely works across all three, so shorten as you go narrower.')
    faq=@(
      @('What are the standard web banner sizes?','300 by 250 (medium rectangle), 728 by 90 (leaderboard) and 300 by 600 (half page). Those three carry most display inventory, and all three are in the editor.'),
      @('How much text fits on a banner ad?','A headline of two or three words, one supporting line, and a call to action. The leaderboard barely fits that, which is why its wording has to be shorter than the rectangle''s.'),
      @('Can I use these as email header images?','Yes. The leaderboard shape works well at the top of an email - export it and insert it as an image, with the offer repeated as real text underneath for anyone blocking images.'))
    templates=@(
      (New-Promo 'plain-rect' 'Plain Rectangle' 'Simple &middot; offer first' 'p-clean' 'f-josefin' '' '#ffffff' '#1a1e24' '#c1543f' '#5a6470' $MBody.webbanner),
      (New-Promo 'block-rect' 'Block Rectangle' 'Modern &middot; offset block' 'p-modern' 'f-tenor' '' '#fbfbfa' '#171b22' '#2f4858' '#5a6470' $MBody.webbanner),
      (New-Promo 'panel-rect' 'Panel Rectangle' 'Filled &middot; tinted panel' 'p-panel' 'f-marcellus' '' '#fdfaf3' '#2c2a24' '#b07a2e' '#665f52' $MBody.webbanner 'bg-grad'),
      (New-Promo 'ground-rect' 'Ground Rectangle' 'Filled &middot; full colour ground' 'p-bold' 'f-josefin' '' '#1f3d34' '#f4f1e8' '#e0a94a' '#c3ccc4' $MBody.webbanner 'bg-edge')) },

 @{ slug='logo-templates'; name='Logo Templates'; nav='Logos'
    kind='logo'; size='sz-logo'; fields=$FieldsLogo; ornaments=$true
    h1='Logo Templates'
    title='Logo Template - Free Editable Wordmark and Monogram Designs'
    desc='Free editable logo templates - wordmarks, monograms and badges. Type your business name, choose a typeface, and download at full resolution.'
    intro=@(
      'These are logo layouts rather than a logo service, and the difference is worth stating plainly: a real identity is drawn for one business and belongs to it. What these give you is a well-set wordmark, monogram or badge - which is genuinely enough for a small business, a market stall or a side project, and better than most cheap logo generators produce.',
      'Four arrangements, sixteen typefaces and every palette on the site. Download at 1500 pixels square on a transparent-looking ground, or print it onto stationery from the <a href="../../business-office/letterhead-templates/">letterhead templates</a>, and carry the same mark onto a <a href="../../business-office/business-card-templates/">business card</a>.')
    faq=@(
      @('Is a template logo good enough for a real business?','For a small or new business, yes. A clearly set name in a good typeface beats a cluttered custom mark, and you can commission something bespoke later once you know what the business actually is.'),
      @('Can I trademark a logo made from a template?','Take advice locally. Broadly, a wordmark of your own business name is usually registrable; the arrangement and typeface are not exclusively yours, so a distinctive name matters more than the layout.'),
      @('What should I do about file formats?','Download the PNG here for screens and documents. If you later need a vector for signage or embroidery, a designer can redraw it from this in an hour - bring them the PNG and the typeface name shown on the design.'))
    templates=@(
      (New-Promo 'wordmark-plain' 'Wordmark' 'Simple &middot; name and rule' 'l-wordmark' 'f-tenor' '' '#ffffff' '#1c2128' '#2f4858' '#59616b' $MBody.logo),
      (New-Promo 'monogram-circle' 'Monogram Circle' 'Modern &middot; initial in a ring' 'l-monogram' 'f-josefin' '' '#ffffff' '#171b22' '#2e5d4b' '#5a6470' $MBody.logo),
      (New-Promo 'stacked-serif' 'Stacked Serif' 'Filled &middot; framed and ruled' 'l-stacked' 'f-cormorant' '' '#fdfcf9' '#241f1b' '#8a6a3b' '#5f5850' $MBody.logo 'bg-grad'),
      (New-Promo 'badge-deco' 'Badge' 'Decorated &middot; bordered badge' 'l-badge' 'f-cinzel' 'geometric' '#16241d' '#f1ece0' '#c9a227' '#c2c8ba' $MBody.logo 'bg-edge' $true)) }
)

# --- guides -------------------------------------------------------------------

$MGuides = @(
 @{ slug='social-media-image-sizes'
    title='Social Media Image Sizes - The Ones That Actually Matter'
    h1='Social Media Image Sizes'
    desc='Current pixel sizes for Instagram, YouTube, Facebook and LinkedIn, which ones get cropped, and why uploading bigger does not help.'
    read='5 min read'
    body=@(
      @('p','Most of the size charts online list forty dimensions, thirty of which nobody uses. These are the ones worth knowing, and the two rules that save more trouble than the numbers do.'),
      @('h2','The sizes'),
      @('ul',@(
        '<strong>Instagram post, square:</strong> 1080 &times; 1080.',
        '<strong>Instagram post, portrait:</strong> 1080 &times; 1350 - takes more room in the feed, which is why most brands now use it.',
        '<strong>Instagram story and Reels:</strong> 1080 &times; 1920.',
        '<strong>YouTube thumbnail:</strong> 1280 &times; 720, under 2MB.',
        '<strong>Facebook page cover:</strong> 820 &times; 312.',
        '<strong>LinkedIn banner:</strong> 1584 &times; 396.',
        '<strong><a href="../../marketing-social/web-banner-templates/">Display ads</a>:</strong> 300 &times; 250, 728 &times; 90, 300 &times; 600.')),
      @('h2','Rule one: the interface sits on top of your design'),
      @('p','A story has your profile at the top and a reply bar at the bottom. A LinkedIn banner has your photo over the lower left. A YouTube thumbnail has a duration badge in the bottom right. None of this is optional, so anything that matters belongs in the middle - not because the middle looks better, but because it is the only part guaranteed to be visible.'),
      @('h2','Rule two: uploading bigger does not make it sharper'),
      @('p','Every platform re-compresses what you upload to its own dimensions. A 4000 pixel image is downscaled and recompressed, often looking worse than one supplied at the right size. Export at the listed size and stop there.'),
      @('h2','Test at thumbnail scale, not full size'),
      @('p','The single most useful habit: shrink your design on screen until it is about the width of your thumb, then look at it. That is the size a feed shows it at. If the headline is not readable there, the answer is fewer words rather than bigger type - bigger type in a small space just wraps.'),
      @('h2','One design, several sizes'),
      @('p','Every template on this site switches size in the editor and re-flows rather than cropping, so an <a href="../../marketing-social/instagram-post-templates/">Instagram post</a> can become a <a href="../../marketing-social/instagram-story-templates/">story</a> without a redesign. The wording almost always needs shortening as the canvas gets narrower, which is a content decision rather than a design one.'),
      @('p','For print rather than a feed the trade-offs change completely - paper has no interface sitting on top of it, but it also gets two seconds in the hand. That is <a href="../how-to-design-a-flyer/">flyer territory</a>.'),
      @('cta','instagram-post-templates'),
      @('cta','instagram-story-templates'),
      @('cta','youtube-thumbnail-templates'),
      @('cta','facebook-cover-templates'),
      @('cta','linkedin-banner-templates')) },

 @{ slug='how-to-design-a-flyer'
    title='How to Design a Flyer People Actually Read'
    h1='How to Design a Flyer'
    desc='Why most flyers get binned in two seconds, what to lead with instead of your business name, and how much to print.'
    read='6 min read'
    body=@(
      @('p','A flyer gets about two seconds between the hand and the bin. Almost everything that makes a flyer work happens in that window, and most flyers lose it in the first line. The <a href="../../marketing-social/flyer-templates/">flyer designs here</a> are laid out around that window; what goes in them is the part below.'),
      @('h2','Do not lead with your business name'),
      @('p','This is the commonest mistake and the most expensive one. Nobody is looking for you yet - they do not know you exist. Lead with what they get: the offer, the event, the problem you solve. Your name belongs at the bottom with the phone number, where somebody who has already decided will look for it.'),
      @('h2','One message'),
      @('p','A flyer listing eight services communicates that you will do anything, which reads as desperation rather than range. Pick the one thing you most want to be called about and build the flyer around it. If you genuinely have two audiences, print two flyers - it costs very little more.'),
      @('h2','The three-second test'),
      @('p','Hold the flyer at arm''s length and look at it for three seconds. If you cannot come away with the what, the where and the how to act, the hierarchy is wrong - usually because two things are competing to be the largest. Only one thing can be the largest.'),
      @('h2','Give the details their own space'),
      @('p','Address, hours, phone, and one web address. Set them small but not tiny, and group them at the foot with room around them. This is the part someone photographs on their phone, so it has to survive being read at an angle in bad light.'),
      @('h2','Printing'),
      @('ul',@(
        '<strong>A5</strong> for handouts and letterbox drops, <strong>A4</strong> for noticeboards and windows - though for a board read at a distance, a <a href="../../marketing-social/poster-templates/">poster</a> carries further than a flyer.',
        '<strong>130-170gsm</strong> - light enough to carry a stack, heavy enough not to feel disposable.',
        'Matt rather than gloss unless there are photographs, and there are none in these designs.',
        'Print a proof of one before you order a thousand. Screens flatter, and typos survive every reading until they are on paper.')),
      @('h2','How many to print'),
      @('p','Fewer than you think, first. Response rates on letterbox drops are commonly well under one per cent, so five hundred is a test rather than a campaign. Print five hundred, see what happens, then change the offer rather than the design if nothing does.'),
      @('p','The same flyer usually wants a second life in a feed, which is a different set of constraints and a different set of <a href="../social-media-image-sizes/">dimensions</a> - the interface sits on top of the design there, so the middle of the frame is the only safe place for anything that matters.'),
      @('cta','flyer-templates')) }
)
