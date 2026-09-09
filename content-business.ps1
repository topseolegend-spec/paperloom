# =============================================================================
#  Business &amp; Office category
#  Subcategories search volume ke hisaab se tarteeb mein hain - Resume sabse upar.
#
#  Invitation cards ke bar-aks ye documents hain: A4/Letter portrait, kai
#  sections. Har subcategory apne fields khud declare karti hai; editor ka form
#  usi list se banta hai, is liye naya document type add karna aasan hai.
# =============================================================================

# --- field sets ---------------------------------------------------------------

$FieldsResume = @(
  (New-Field 'name'       'Your name'            'text' 'Header'     ''),
  (New-Field 'role'       'Job title'            'text' 'Header'     ''),
  (New-Field 'contact'    'Contact details'      'area' 'Header'     'One per line - email, phone, city, LinkedIn'),
  (New-Field 'secProfile' 'Section heading'      'text' 'Profile'    ''),
  (New-Field 'summary'    'Profile'              'area' 'Profile'    'Two or three lines about what you do'),
  (New-Field 'secExp'     'Section heading'      'text' 'Experience' ''),
  (New-Field 'exp1role'   'Job 1 - title'        'text' 'Experience' ''),
  (New-Field 'exp1meta'   'Job 1 - company and dates' 'text' 'Experience' ''),
  (New-Field 'exp1desc'   'Job 1 - what you did' 'area' 'Experience' 'One achievement per line'),
  (New-Field 'exp2role'   'Job 2 - title'        'text' 'Experience' ''),
  (New-Field 'exp2meta'   'Job 2 - company and dates' 'text' 'Experience' ''),
  (New-Field 'exp2desc'   'Job 2 - what you did' 'area' 'Experience' ''),
  (New-Field 'exp3role'   'Job 3 - title'        'text' 'Experience' 'Leave empty to hide'),
  (New-Field 'exp3meta'   'Job 3 - company and dates' 'text' 'Experience' ''),
  (New-Field 'exp3desc'   'Job 3 - what you did' 'area' 'Experience' ''),
  (New-Field 'secEdu'     'Section heading'      'text' 'Education'  ''),
  (New-Field 'edu1'       'Qualification 1'      'text' 'Education'  ''),
  (New-Field 'edu1meta'   'Institution and year' 'text' 'Education'  ''),
  (New-Field 'edu2'       'Qualification 2'      'text' 'Education'  'Leave empty to hide'),
  (New-Field 'edu2meta'   'Institution and year' 'text' 'Education'  ''),
  (New-Field 'secSkills'  'Section heading'      'text' 'Skills'     ''),
  (New-Field 'skills'     'Skills'               'area' 'Skills'     'One per line')
)

$FieldsLetter = @(
  (New-Field 'name'      'Your name'          'text' 'Header'  ''),
  (New-Field 'role'      'Your job title'     'text' 'Header'  ''),
  (New-Field 'contact'   'Your contact details' 'area' 'Header' 'One per line'),
  (New-Field 'date'      'Date'               'text' 'Letter'  ''),
  (New-Field 'recipient' 'Addressed to'       'area' 'Letter'  'Name, title, company - one per line'),
  (New-Field 'greeting'  'Greeting'           'text' 'Letter'  ''),
  (New-Field 'body'      'Letter'             'area' 'Letter'  'Leave a blank line between paragraphs'),
  (New-Field 'signoff'   'Sign-off'           'text' 'Letter'  ''),
  (New-Field 'signname'  'Your name again'    'text' 'Letter'  '')
)

$FieldsCert = @(
  (New-Field 'award'    'Certificate title' 'text' 'Certificate' ''),
  (New-Field 'pre'      'Line above the name' 'text' 'Certificate' ''),
  (New-Field 'name'     'Recipient name'    'text' 'Certificate' ''),
  (New-Field 'reason'   'What it is for'    'area' 'Certificate' ''),
  (New-Field 'date'     'Date'              'text' 'Certificate' ''),
  (New-Field 'sign1'    'Signature 1 - name' 'text' 'Signatures'  ''),
  (New-Field 'sign1role' 'Signature 1 - title' 'text' 'Signatures' ''),
  (New-Field 'sign2'    'Signature 2 - name' 'text' 'Signatures'  'Leave empty to hide'),
  (New-Field 'sign2role' 'Signature 2 - title' 'text' 'Signatures' '')
)

$FieldsBcard = @(
  (New-Field 'name'    'Name'        'text' 'Card' ''),
  (New-Field 'role'    'Job title'   'text' 'Card' ''),
  (New-Field 'company' 'Company'     'text' 'Card' ''),
  (New-Field 'tagline' 'Tagline'     'text' 'Card' 'Leave empty to hide'),
  (New-Field 'phone'   'Phone'       'text' 'Contact' ''),
  (New-Field 'email'   'Email'       'text' 'Contact' ''),
  (New-Field 'web'     'Website'     'text' 'Contact' ''),
  (New-Field 'address' 'Address'     'text' 'Contact' 'Leave empty to hide')
)

$FieldsInvoice = @(
  (New-Field 'bizname'   'Your business'   'text' 'From'    ''),
  (New-Field 'bizcontact' 'Your details'   'area' 'From'    'Address, phone, email - one per line'),
  (New-Field 'title'     'Document title'  'text' 'Invoice' ''),
  (New-Field 'number'    'Invoice number'  'text' 'Invoice' ''),
  (New-Field 'date'      'Issue date'      'text' 'Invoice' ''),
  (New-Field 'due'       'Due date'        'text' 'Invoice' ''),
  (New-Field 'clientlabel' 'Client heading' 'text' 'Client' ''),
  (New-Field 'client'    'Client details'  'area' 'Client'  'One per line'),
  (New-Field 'item1'     'Line 1'          'text' 'Items'   ''),
  (New-Field 'item1amt'  'Line 1 amount'   'text' 'Items'   ''),
  (New-Field 'item2'     'Line 2'          'text' 'Items'   ''),
  (New-Field 'item2amt'  'Line 2 amount'   'text' 'Items'   ''),
  (New-Field 'item3'     'Line 3'          'text' 'Items'   'Leave empty to hide'),
  (New-Field 'item3amt'  'Line 3 amount'   'text' 'Items'   ''),
  (New-Field 'item4'     'Line 4'          'text' 'Items'   'Leave empty to hide'),
  (New-Field 'item4amt'  'Line 4 amount'   'text' 'Items'   ''),
  (New-Field 'totallabel' 'Total label'    'text' 'Total'   ''),
  (New-Field 'total'     'Total amount'    'text' 'Total'   ''),
  (New-Field 'notes'     'Payment notes'   'area' 'Total'   '')
)

$FieldsMenu = @(
  (New-Field 'restname' 'Restaurant name' 'text' 'Header'    ''),
  (New-Field 'tagline'  'Tagline'         'text' 'Header'    ''),
  (New-Field 'sec1'     'Section 1 title' 'text' 'Section 1' ''),
  (New-Field 'sec1items' 'Section 1 dishes' 'area' 'Section 1' 'One per line: Dish name - price'),
  (New-Field 'sec2'     'Section 2 title' 'text' 'Section 2' ''),
  (New-Field 'sec2items' 'Section 2 dishes' 'area' 'Section 2' ''),
  (New-Field 'sec3'     'Section 3 title' 'text' 'Section 3' 'Leave empty to hide'),
  (New-Field 'sec3items' 'Section 3 dishes' 'area' 'Section 3' ''),
  (New-Field 'footer'   'Footer line'     'text' 'Footer'    '')
)

$FieldsLetterhead = @(
  (New-Field 'company' 'Company name' 'text' 'Header' ''),
  (New-Field 'tagline' 'Tagline'      'text' 'Header' 'Leave empty to hide'),
  (New-Field 'address' 'Address'      'area' 'Header' 'One per line'),
  (New-Field 'contact' 'Contact'      'area' 'Header' 'Phone, email, website'),
  (New-Field 'footer'  'Footer line'  'text' 'Footer' 'Registration number, tagline, anything')
)

# --- sample content -----------------------------------------------------------

$BizBody = @{
  resume = @{
    name='Amara Sheikh'; role='Senior Product Designer'
    contact='amara.sheikh@email.com<br>+92 300 1234567<br>Lahore, Pakistan<br>linkedin.com/in/amarasheikh'
    secProfile='Profile'
    summary='Product designer with eight years building interfaces for finance and logistics teams. I work close to engineering, and most of what I ship starts as a rough prototype rather than a spec.'
    secExp='Experience'
    exp1role='Senior Product Designer'; exp1meta='Meridian Systems &middot; 2022 - Present'
    exp1desc='Rebuilt the payments flow, cutting failed transactions by a third.<br>Set up the design system now used across six product teams.<br>Run the fortnightly research sessions with operations staff.'
    exp2role='Product Designer'; exp2meta='Northlight Logistics &middot; 2019 - 2022'
    exp2desc='Designed the driver app used daily by 400 contractors.<br>Took the dispatch dashboard from concept to launch in nine months.'
    exp3role='UI Designer'; exp3meta='Fold Studio &middot; 2017 - 2019'
    exp3desc='Client work across fintech and retail, mostly mobile.'
    secEdu='Education'
    edu1='BSc Computer Science'; edu1meta='Punjab University &middot; 2017'
    edu2='Interaction Design Certificate'; edu2meta='Interaction Design Foundation &middot; 2020'
    secSkills='Skills'
    skills='Figma<br>Design systems<br>User research<br>Prototyping<br>HTML &amp; CSS<br>Accessibility'
  }
  letter = @{
    name='Amara Sheikh'; role='Senior Product Designer'
    contact='amara.sheikh@email.com &middot; +92 300 1234567 &middot; Lahore'
    date='8 September 2026'
    recipient='Hiring Team<br>Meridian Systems<br>24 Gulberg Boulevard, Lahore'
    greeting='Dear Hiring Team,'
    body='I am writing about the Senior Product Designer role advertised on your careers page. I have spent the last five years designing payment and logistics tools, which is the same problem space your team works in.<br><br>At Northlight I designed the driver app that four hundred contractors use every day. The work that mattered was not the interface itself but the two months I spent riding along with drivers before drawing anything. That habit is what I would bring to your team.<br><br>I would welcome the chance to talk about the role, and I have attached my portfolio and CV.'
    signoff='Yours sincerely,'; signname='Amara Sheikh'
  }
  cert = @{
    award='Certificate of Achievement'
    pre='This is presented to'
    name='Zain Ali'
    reason='in recognition of outstanding performance and dedication<br>during the 2026 professional development programme'
    date='8 September 2026'
    sign1='Dr Nadia Rahman'; sign1role='Programme Director'
    sign2='Imran Shah'; sign2role='Chief Executive'
  }
  bcard = @{
    name='Amara Sheikh'; role='Senior Product Designer'; company='Meridian Systems'
    tagline='Interfaces that stay out of the way'
    phone='+92 300 1234567'; email='amara@meridian.co'
    web='meridian.co'; address='24 Gulberg Boulevard, Lahore'
  }
  invoice = @{
    bizname='Meridian Studio'
    bizcontact='24 Gulberg Boulevard, Lahore<br>+92 300 1234567<br>billing@meridian.co'
    title='Invoice'; number='INV-2026-041'; date='8 September 2026'; due='22 September 2026'
    clientlabel='Bill to'
    client='Northlight Logistics<br>Attn: Accounts Payable<br>18 Shahrah-e-Faisal, Karachi'
    item1='Design system audit and documentation'; item1amt='120,000'
    item2='Driver app interface - 12 screens'; item2amt='240,000'
    item3='Two rounds of usability testing'; item3amt='60,000'
    item4=''; item4amt=''
    totallabel='Total due'; total='PKR 420,000'
    notes='Payment by bank transfer within 14 days. Account details on request.'
  }
  menu = @{
    restname='Marigold'; tagline='Kitchen and tea room'
    sec1='To start'
    sec1items='Charred corn soup - 450<br>Beetroot and walnut salad - 620<br>Chicken malai boti - 780<br>Spiced potato cakes - 480'
    sec2='Mains'
    sec2items='Lamb nihari, slow cooked overnight - 1,650<br>Grilled river fish, lemon and coriander - 1,850<br>Chargha with garlic rice - 1,450<br>Daal makhani and naan - 950'
    sec3='Sweet'
    sec3items='Cardamom kheer - 420<br>Orange and almond cake - 480<br>Kulfi, pistachio - 380'
    footer='Kitchen open until 11pm &middot; Service not included'
  }
  letterhead = @{
    company='Meridian Systems'
    tagline='Product design and research'
    address='24 Gulberg Boulevard<br>Lahore 54660<br>Pakistan'
    contact='+92 300 1234567<br>hello@meridian.co<br>meridian.co'
    footer='Meridian Systems (Pvt) Ltd &middot; Registered in Pakistan'
  }
}

# --- templates ----------------------------------------------------------------
#  New-Doc: New-Tpl jaisa hi, magar documents ke liye (koi ornament nahi jab tak
#  design usay na maange).

function New-Doc($slug, $name, $style, $design, $font, $art, $bg, $ink, $accent, $soft, $body,
                 $bgstyle = 'bg-plain', $foil = $false) {
  @{ slug=$slug; name=$name; style=$style; design=$design; font=$font; art=$art
     bg=$bg; ink=$ink; accent=$accent; soft=$soft; body=$body; bgstyle=$bgstyle; foil=$foil }
}

$BizCategory = @{
  slug  = 'business-office'
  accent = '#2e5d4b'
  homePicks = @('cv-resume-templates','invoice-templates','certificate-templates')
  name  = 'Business &amp; Office'
  short = 'Business'
  panel = 'Document types'
  blurb = 'CVs first, then the paperwork a small business actually sends out.'
  h1    = 'Business and Office Templates'
  title = 'Business Templates - Free CV, Invoice &amp; Certificate Designs'
  desc  = 'Free editable business templates: CVs, invoices, certificates, business cards, cover letters, menus and letterheads. Edit in your browser, no account needed.'
  intro = @(
    'Seven document types, twenty-four designs, every one of them editable in the browser. Type into the boxes beside the page, change the colours and lettering, then print or download - there is no account step and nothing is watermarked.',
    'The CV designs come first because they are what most people arrive looking for. Each one is a genuine A4 layout rather than a card: real section spacing, a proper type hierarchy, and room for three roles without the page turning cramped.'
  )
}

$BizSubcats = @(

 @{ slug='cv-resume-templates'; name='CV &amp; Resume Templates'; nav='CV &amp; Resume'
    kind='resume'; size='sz-a4'; fields=$FieldsResume
    h1='CV and Resume Templates'
    title='Resume Template - Free Editable CV Designs You Can Print'
    desc='Free professional resume and CV templates, modern and classic. Edit in your browser, download as PNG or print to PDF - no account, no watermark.'
    guideNote='The layout is the easy half. <a href="../../guides/what-to-include-in-a-cv/">What belongs in each section</a> - and what to cut - is where most CVs are won or lost, and if the advert said resume rather than CV, <a href="../../guides/cv-vs-resume/">that word changes the expected length</a> in North America only.'
    intro=@(
      'A CV is read in about seven seconds before anyone decides to keep reading, and almost all of that time goes on the top third of the page. Each of these four layouts puts the name, the role and the profile line in that space, and keeps the rest of the page quiet enough to scan.',
      'All four are A4 by default and switch to US Letter in the editor. They hold three roles and two qualifications comfortably; any field you leave empty disappears rather than leaving a gap, so a shorter CV still looks deliberate rather than unfinished.',
      '<strong>Applying through an online form?</strong> Most large employers run CVs through applicant tracking software before a person sees them, and that software reads a single column far more reliably than two. Clean Classic and Plain Serif are single-column for that reason; Studio Sidebar and Split Header put a column beside the main one, which looks better on a desk than it parses on a server. Whichever you pick, use Print to PDF rather than the PNG download when you upload: the PDF keeps your words as text that can be read and searched, and the PNG is a picture of them.')
    faq=@(
      @('What should a CV include?','Your name and the role you are applying for, contact details, a short profile, work experience with dates and what you actually achieved, education, and skills. Everything else - photographs, marital status, date of birth, a full address - is either unnecessary or actively unhelpful in most markets.'),
      @('How long should a CV be?','One page for under ten years of experience, two at most beyond that. If you are struggling to fit one page, cut the oldest roles down to a single line each rather than shrinking the type.'),
      @('Should a CV have a photo?','In Pakistan, the Gulf and much of Asia and Europe a photo is normal. In the UK, the US, Canada and Australia it is discouraged, because employers avoid documents that could expose them to discrimination claims. These templates leave it off, which is the safer default when you are applying in several countries.'),
      @('Will these templates work with applicant tracking systems?','They print as an image or PDF, which is right for emailing and for handing over in person. If an employer asks you to paste your CV into an online form, use the plain text from your boxes rather than the design - that is what those systems read.'))
    templates=@(
      # Two plain layouts for people who want a CV that survives any inbox, and
      # two designed ones for people applying somewhere that rewards it.
      (New-Doc 'clean-classic' 'Clean Classic' 'Simple &middot; single column' 'r-clean' 'f-tenor' '' '#ffffff' '#1d2228' '#2f4858' '#57606a' $BizBody.resume),
      (New-Doc 'plain-serif' 'Plain Serif' 'Simple &middot; centred masthead' 'r-plain' 'f-cormorant' '' '#fdfcf9' '#211e1a' '#7b5e33' '#5d564d' $BizBody.resume),
      (New-Doc 'studio-sidebar' 'Studio Sidebar' 'Designed &middot; sidebar and timeline' 'r-studio' 'f-josefin' '' '#ffffff' '#1b2430' '#22394f' '#59636e' $BizBody.resume),
      (New-Doc 'split-header' 'Split Header' 'Designed &middot; header band, two columns' 'r-split' 'f-tenor' '' '#ffffff' '#1f2a23' '#2e5d4b' '#586159' $BizBody.resume)) },

 @{ slug='invoice-templates'; name='Invoice Templates'; nav='Invoices'
    kind='invoice'; size='sz-a4'; fields=$FieldsInvoice
    h1='Invoice Templates'
    title='Invoice Template - Free Printable Invoices You Can Edit'
    desc='Free editable invoice templates for freelancers and small businesses. Fill in your details in the browser, then print or save as PDF. No account needed.'
    guideNote='A correct invoice and one that gets paid on time are not quite the same document - numbering, a due date rather than a payment term, and reaching the person who actually approves it are covered in <a href="../../guides/how-to-write-an-invoice/">how to write an invoice</a>.'
    intro=@(
      'An invoice only has to do three things: say who is owed money, say how much, and say by when. These layouts put the total where the eye lands first and keep the line items readable, which is most of what gets an invoice paid on time.',
      'Four line items fit comfortably; leave any of them empty and the row disappears. The totals block, the due date and the payment note are all editable, so the same design works for a one-off job or a monthly retainer.')
    faq=@(
      @('What has to be on an invoice?','Your business name and contact details, the client''s details, a unique invoice number, the issue date, a due date, a description of what you are charging for, and the total. If you are registered for sales tax, your registration number and the tax amount belong on it too.'),
      @('How do I number invoices?','Sequentially, with no gaps - INV-2026-001, INV-2026-002 and so on. Gaps in a numbered sequence are the first thing an auditor asks about, and a client querying an invoice will quote the number back to you.'),
      @('What payment terms should I use?','Fourteen days is standard for small work, thirty for larger clients who run monthly payment runs. Whatever you choose, put the actual due date on the invoice rather than "net 14" - a date is harder to ignore than a term.'))
    templates=@(
      (New-Doc 'clean-slate' 'Clean Slate' 'Minimal &middot; ruled table' 'i-clean' 'f-tenor' '' '#ffffff' '#20262c' '#2f4858' '#5c666d' $BizBody.invoice),
      (New-Doc 'accent-band-invoice' 'Accent Band' 'Coloured header band' 'i-band' 'f-josefin' '' '#ffffff' '#1f2a23' '#2e5d4b' '#5a6660' $BizBody.invoice),
      (New-Doc 'classic-ledger' 'Classic Ledger' 'Serif &middot; traditional' 'i-classic' 'f-libre' '' '#fdfcf9' '#231f1b' '#8a6a3b' '#5f5850' $BizBody.invoice)) },

 @{ slug='certificate-templates'; name='Certificate Templates'; nav='Certificates'
    kind='cert'; size='sz-cert'; fields=$FieldsCert; ornaments=$true
    h1='Certificate Templates'
    title='Certificate Template - Free Printable Award Designs'
    desc='Free printable certificate templates for achievement, completion, appreciation and training awards. Landscape A4, editable in your browser.'
    guideNote='These are for awards, courses and recognition. For a school leaving certificate with the institutional detail that goes with it, the <a href="../../education-school/diploma-templates/">diploma designs</a> are the longer form of the same document.'
    intro=@(
      'Certificates are printed landscape and read from across a room, which changes what matters: the recipient''s name has to be the largest thing on the page, and the border has to frame it without crowding it. These four use the same ornament library as our invitation cards, drawn as vector line work so they stay crisp at any size.',
      'Two signature blocks are included; clear the second one and the first centres itself. Every design switches between award, completion, appreciation and participation wording by editing the title line.')
    faq=@(
      @('What wording goes on a certificate?','A title, a presentation line, the recipient''s name, a short reason, the date, and at least one signature with the signatory''s role. Keeping the reason to one or two lines is what stops a certificate reading like a paragraph.'),
      @('What size should a certificate be printed at?','A4 landscape is the standard almost everywhere and fits ready-made frames. US Letter landscape is available in the editor for North America.'),
      @('What paper works best?','Anything from 160gsm upwards - lighter paper curls in a frame and feels disposable in the hand. A lightly textured or laid stock suits the more traditional borders; smooth stock suits the modern ones.'))
    templates=@(
      (New-Doc 'gold-deco-cert' 'Gold Deco' 'Art deco frame &middot; foil' 'c-classic' 'f-cinzel' 'deco' '#fdfaf3' '#2c2a24' '#a8823f' '#5f5b50' $BizBody.cert 'bg-edge' $true),
      (New-Doc 'laurel-formal' 'Laurel Formal' 'Laurel wreath &middot; classic' 'c-classic' 'f-cinzel-dec' 'laurel' '#f8f8f5' '#16233d' '#b08a3e' '#565f70' $BizBody.cert 'bg-grad' $true),
      (New-Doc 'vine-traditional' 'Vine Traditional' 'Vine border &middot; serif' 'c-classic' 'f-cormorant' 'vine' '#fbf8f1' '#1f3328' '#2e5d4b' '#5d6b5f' $BizBody.cert),
      (New-Doc 'modern-geometric-cert' 'Modern Geometric' 'Geometric &middot; contemporary' 'c-modern' 'f-josefin' 'geometric' '#ffffff' '#20262c' '#3f7a8c' '#5c666d' $BizBody.cert 'bg-grad')) },

 @{ slug='business-card-templates'; name='Business Card Templates'; nav='Business Cards'
    kind='bcard'; size='sz-bcard'; fields=$FieldsBcard; ornaments=$true
    h1='Business Card Templates'
    title='Business Card Template - Free Printable 3.5 x 2 Designs'
    desc='Free editable business card templates at the standard 3.5 x 2 inch size. Change the wording, colours and lettering in your browser, then print or download.'
    intro=@(
      'These are drawn at 3.5 &times; 2 inches, the size every print shop and card holder expects. What separates a card that works from one that does not is restraint: a name, what you do, and two ways to reach you. Anything more and none of it gets read.',
      'Leave the tagline or address empty and those lines disappear rather than leaving a gap. If you are printing a batch, set the card up here, download the PNG at 300dpi and hand that file to the printer.',
      'Setting up a business from nothing, the two usually go together: pick a mark from the <a href="../../marketing-social/logo-templates/">logo templates</a> first, then match its colours and typeface here.')
    faq=@(
      @('What size is a standard business card?','3.5 &times; 2 inches in Pakistan, the US and most of Asia. Europe more often uses 85 &times; 55mm, which is close enough that either fits a standard card holder.'),
      @('What should go on a business card?','Name, role, company, and the two contact routes you actually answer - usually phone and email. A physical address only earns its place if customers visit you.'),
      @('How do I get these printed?','Download the PNG, which comes out at print resolution, and send it to a local press or an online printer. Ask for 300gsm or heavier; anything lighter feels like a flyer.'))
    templates=@(
      (New-Doc 'minimal-ink' 'Minimal Ink' 'Left aligned &middot; quiet' 'b-minimal' 'f-tenor' '' '#ffffff' '#20262c' '#2f4858' '#5c666d' $BizBody.bcard),
      (New-Doc 'accent-band-card' 'Accent Band' 'Side band &middot; modern' 'b-band' 'f-josefin' '' '#ffffff' '#1f2a23' '#2e5d4b' '#5a6660' $BizBody.bcard),
      (New-Doc 'monogram-dark' 'Monogram Dark' 'Dark card &middot; foil' 'b-dark' 'f-cinzel' 'geometric' '#16161a' '#f2eee4' '#c9a227' '#bdb9b0' $BizBody.bcard 'bg-edge' $true),
      (New-Doc 'bordered-classic' 'Bordered Classic' 'Framed &middot; traditional' 'b-bordered' 'f-cormorant' '' '#fdfcf9' '#231f1b' '#8a6a3b' '#5f5850' $BizBody.bcard 'bg-grad')) },

 @{ slug='cover-letter-templates'; name='Cover Letter Templates'; nav='Cover Letters'
    kind='letter'; size='sz-a4'; fields=$FieldsLetter
    h1='Cover Letter Templates'
    title='Cover Letter Template - Free Editable Designs'
    desc='Free cover letter templates in matching styles to our CV designs. Edit the wording in your browser, then print or save as PDF.'
    guideNote='A cover letter earns its place by saying what the <a href="../../business-office/cv-resume-templates/">CV</a> cannot - why this employer, and why now. It repeats nothing from the CV itself, which is easier to judge once you know <a href="../../guides/what-to-include-in-a-cv/">what the CV is already carrying</a>.'
    intro=@(
      'A cover letter is read after the CV, not before it, and its job is narrow: explain why this role and not another. Three short paragraphs do that better than a full page of prose, which is what these layouts are spaced for.',
      'Each design pairs with one of the CV templates, so a letter and CV sent together look like they came from the same person rather than two different downloads.')
    faq=@(
      @('How long should a cover letter be?','Three paragraphs on one page. Why this role, what you have done that is relevant, and how to reach you. Anything longer is usually the CV repeated in sentences.'),
      @('Who do I address it to?','The hiring manager by name if the advert or the company''s site gives you one. If not, "Dear Hiring Team" is fine - "To Whom It May Concern" reads as a form letter, because it is one.'),
      @('Do I still need one?','When the application asks for it, yes, and it is read. When it does not, a short covering email doing the same job is enough.'))
    templates=@(
      (New-Doc 'letter-sidebar' 'Sidebar Slate' 'Matches the Sidebar CV' 'l-sidebar' 'f-tenor' '' '#ffffff' '#20262c' '#2f4858' '#5c666d' $BizBody.letter),
      (New-Doc 'letter-serif' 'Editorial Serif' 'Matches the Serif CV' 'l-serif' 'f-cormorant' '' '#fdfcf9' '#221f1c' '#8a6a3b' '#5f5850' $BizBody.letter),
      (New-Doc 'letter-header' 'Accent Header' 'Matches the Header CV' 'l-header' 'f-josefin' '' '#ffffff' '#1f2a23' '#2e5d4b' '#5a6660' $BizBody.letter)) },

 @{ slug='menu-templates'; name='Menu Templates'; nav='Menus'
    kind='menu'; size='sz-a4'; fields=$FieldsMenu
    h1='Restaurant Menu Templates'
    title='Restaurant Menu Template - Free Printable Designs'
    desc='Free editable restaurant and cafe menu templates. Type your dishes and prices in the browser, then print or save as PDF.'
    guideNote='Most cafes print a menu and a <a href="../../marketing-social/flyer-templates/">flyer</a> in the same week - if you are doing both, set them in the same typeface and palette so the two read as one place.'
    intro=@(
      'A menu is a price list people read while hungry and slightly rushed, so the two things that matter are that dish names are easy to scan and that prices do not dominate them. These layouts set prices in the same weight as the dish rather than in bold, which is what stops a menu reading like a receipt.',
      'Type one dish per line as "Dish name - price" and the layout separates the two for you, with prices aligned down the right. Three sections are included; clear the third to run a two-section menu.')
    faq=@(
      @('How should prices be written on a menu?','Without currency symbols and without trailing zeros where you can - 950 rather than PKR 950.00. Restaurants have measured this repeatedly: the more a price looks like a price, the more attention it takes from the dish.'),
      @('How many dishes should a section have?','Four to seven. Longer sections slow people down and push the kitchen towards ingredients it cannot keep fresh.'),
      @('What paper should a menu be printed on?','Something you can wipe. 250gsm or heavier with a matt laminate survives a service; plain paper does not last a week.'))
    templates=@(
      (New-Doc 'menu-elegant' 'Elegant Serif' 'Centred &middot; fine dining' 'm-elegant' 'f-cormorant' 'flourish' '#fdfaf3' '#2c2a24' '#8a6a3b' '#5f5b50' $BizBody.menu 'bg-grad'),
      (New-Doc 'menu-modern' 'Modern Sans' 'Left aligned &middot; cafe' 'm-modern' 'f-josefin' '' '#ffffff' '#20262c' '#2e5d4b' '#5c666d' $BizBody.menu),
      (New-Doc 'menu-bistro' 'Bistro Framed' 'Framed &middot; bistro' 'm-bistro' 'f-marcellus' 'vine' '#fbf8f1' '#231f1b' '#7b2c3b' '#5f5850' $BizBody.menu)) },

 @{ slug='letterhead-templates'; name='Letterhead Templates'; nav='Letterheads'
    kind='letterhead'; size='sz-a4'; fields=$FieldsLetterhead
    h1='Letterhead Templates'
    title='Letterhead Template - Free Printable Company Designs'
    desc='Free editable company letterhead templates. Add your business name, address and contact details in the browser, then print or save as PDF.'
    guideNote='Keep the details here identical to the ones on your <a href="../../business-office/invoice-templates/">invoices</a> and <a href="../../business-office/business-card-templates/">business cards</a> - a client filing all three should see one business, not three near-matches.'
    intro=@(
      'A letterhead is mostly empty space, and that is the point - whatever gets typed onto it has to stay the most important thing on the page. These three keep the header under a fifth of the sheet and leave the rest clear.',
      'Print a batch and write on them, or save the PDF and use it as the first page of a document. The footer line takes a registration number, a tagline, or nothing at all.')
    faq=@(
      @('What goes on a letterhead?','Company name, address, and the contact details you want replies sent to. Registration numbers, if your country requires them on correspondence, sit in the footer rather than the header.'),
      @('How much space should the header take?','No more than a fifth of the page. A header any deeper starts pushing the letter itself onto a second sheet.'),
      @('Can I use this as a digital letterhead?','Yes. Save it as a PDF and use it as the background or first page of your document, or print onto it directly.'))
    templates=@(
      (New-Doc 'letterhead-classic' 'Classic Centred' 'Centred &middot; traditional' 'h-classic' 'f-cormorant' '' '#fdfcf9' '#231f1b' '#8a6a3b' '#5f5850' $BizBody.letterhead),
      (New-Doc 'letterhead-modern' 'Modern Left' 'Left aligned &middot; contemporary' 'h-modern' 'f-tenor' '' '#ffffff' '#20262c' '#2f4858' '#5c666d' $BizBody.letterhead),
      (New-Doc 'letterhead-band' 'Accent Band' 'Coloured band &middot; bold' 'h-band' 'f-josefin' '' '#ffffff' '#1f2a23' '#2e5d4b' '#5a6660' $BizBody.letterhead 'bg-grad')) }
)

$BizGuides = @(
 @{ slug='what-to-include-in-a-cv'
    title='What to Include in a CV - And What to Leave Out'
    h1='What to Include in a CV'
    desc='The sections every CV needs, what to cut, and why photographs and dates of birth cause problems in some countries.'
    read='7 min read'
    body=@(
      @('p','A CV is skimmed before it is read. Recruiters describe spending a few seconds deciding whether to keep going, and everything below is about surviving those seconds and then rewarding the person who did keep reading.'),
      @('h2','The five sections that earn their place'),
      @('ol',@(
        '<strong>Name and role.</strong> Your name, and directly under it the job you do - not a slogan. "Senior Product Designer" tells a reader more than "Creative problem solver".',
        '<strong>Contact details.</strong> Email, phone, city. A full street address is unnecessary and, on a document you email to strangers, unwise.',
        '<strong>Profile.</strong> Two or three lines on what you do and the kind of problem you work on. This is the only part of a CV where you get to set the frame, so it is worth more drafts than it usually gets.',
        '<strong>Experience.</strong> Role, employer, dates, then what you actually achieved. Most CVs list duties here; duties are what the job description said, achievements are what you did with it.',
        '<strong>Education and skills.</strong> Brief. Once you have five years of work behind you, your degree is a line, not a section.')),
      @('h2','Write achievements, not duties'),
      @('p','"Responsible for the payments flow" tells a reader nothing that your job title did not. "Rebuilt the payments flow, cutting failed transactions by a third" tells them what changed because you were there. Where you have a number, use it; where you do not, describe the outcome rather than the task.'),
      @('h2','What to leave out'),
      @('ul',@(
        '<strong>Date of birth, marital status, nationality.</strong> Not required, and in several countries employers are advised not to look at them.',
        '<strong>A photograph</strong> - unless you are applying in a market where it is expected. More on this below.',
        '<strong>References available on request.</strong> Everyone assumes this. It is a line of space you could spend on an achievement.',
        '<strong>Skill rating bars.</strong> A bar showing you at 80% of something communicates nothing measurable, and takes the room a real example would use.')),
      @('h2','The software reads it before a person does'),
      @('p','Most large employers put every CV through applicant tracking software first, and it is worth knowing what that software is and is not good at. It reads a single column of text reliably. It reads two columns less reliably, because it cannot always tell which column comes first. It cannot read a photograph of a CV at all.'),
      @('ul',@(
        '<strong>One column beats two</strong> for anything submitted through an online form. Keep the sidebar layouts for a CV you are handing over in person or attaching to a direct email.',
        '<strong>Send text, not a picture.</strong> Print to PDF rather than downloading a PNG - the PDF keeps your words as words. This is the single most common way a good CV disappears without a reply.',
        '<strong>Use the ordinary section headings.</strong> "Work Experience", "Education", "Skills". A heading like "Where I have made a difference" is invisible to software looking for the standard ones.',
        '<strong>Put dates in a consistent format</strong> and keep them beside the role rather than in a margin.')),
      @('p','None of this means a plain CV. It means the structure stays simple while the typography does the work - which is what the layouts here are built around.'),
      @('h2','The photograph question'),
      @('p','This one genuinely depends on where you are applying. In Pakistan, the Gulf, and much of Asia and continental Europe a photo on a CV is normal and its absence can look odd. In the UK, US, Canada, Australia and Ireland it is discouraged - employers there avoid documents that could later support a discrimination claim, and some recruiters strip photos before passing a CV on.'),
      @('p','If you are applying in more than one of those markets, keep two versions. Our <a href="../../business-office/cv-resume-templates/">CV templates</a> leave the photo off, which is the safer default of the two.'),
      @('h2','Length'),
      @('p','One page under ten years of experience, two beyond it. If you are fighting the page, cut your oldest roles to a single line each before you shrink the type - a CV set in seven point tells a reader you had more to say than you could edit.'),
      @('p','The one exception is an academic post, where the document is expected to run long and list every publication. That is a different document wearing the same name, which is the whole of <a href="../cv-vs-resume/">CV versus resume</a>.'),
      @('cta','cv-resume-templates'),
      @('cta','cover-letter-templates')) },

 @{ slug='cv-vs-resume'
    title='CV or Resume - Which One Are You Being Asked For?'
    h1='CV vs Resume: What Is the Difference?'
    desc='What the two words mean in different countries, when the difference actually matters, and which one to send.'
    read='5 min read'
    body=@(
      @('p','The two words mean different things depending on who is asking, and the difference only matters in one of those cases. Here is which is which.'),
      @('h2','In most of the world, they are the same document'),
      @('p','In Pakistan, India, the UK, Ireland, Australia, New Zealand, South Africa and most of Europe, "CV" is simply the word for the one to two page summary of your career. An employer asking for a CV wants exactly what an American employer means by a resume. There is nothing to decide.'),
      @('h2','In North America, they are different documents'),
      @('p','In the United States and Canada, a <strong>resume</strong> is the one to two page career summary. A <strong>CV</strong> means an academic curriculum vitae: a long, complete record of publications, research, teaching, funding and conference papers, running to many pages and growing over a career.'),
      @('p','So if a US or Canadian employer asks for a CV and you are not applying for an academic or research post, they almost certainly still mean a resume - but if a university asks, they mean the long version.'),
      @('h2','How to tell which one is wanted'),
      @('ul',@(
        'The country the job is in. Outside North America, CV means resume.',
        'The sector. Universities, research institutes and some medical roles use the academic sense of CV everywhere.',
        'The length hint in the advert. "No more than two pages" tells you they mean a resume regardless of the word they used.')),
      @('h2','Which should you send?'),
      @('p','Send the <a href="../../business-office/cv-resume-templates/">one to two page document</a> unless you are applying for an academic post. If you genuinely cannot tell and the role is in North America, the short version is the safer choice: no employer has ever rejected a resume for being too readable. What goes inside it does not change with the word used - the <a href="../what-to-include-in-a-cv/">same five sections</a> apply either way.'),
      @('h2','A note on file names'),
      @('p','Whatever the document is called, name the file after yourself rather than the document type - "Amara Sheikh CV.pdf" rather than "cv-final-v3.pdf". It is the name a recruiter sees in a folder of two hundred attachments.'),
      @('cta','cv-resume-templates'),
      @('cta','cover-letter-templates')) },

 @{ slug='how-to-write-an-invoice'
    title='How to Write an Invoice That Gets Paid on Time'
    h1='How to Write an Invoice'
    desc='What has to appear on an invoice, how to number them, what payment terms to set, and how to chase late payment without damage.'
    read='6 min read'
    body=@(
      @('p','Most late payments are not disputes. They are invoices that were unclear, went to the wrong person, or arrived without the one detail the client''s finance team needed. Getting those right is most of the work. The <a href="../../business-office/invoice-templates/">invoice layouts here</a> put every required field in a fixed place; the wording and the terms are still yours to set.'),
      @('h2','What has to be on it'),
      @('ol',@(
        'Your business name and contact details - the same ones on your <a href="../../business-office/letterhead-templates/">letterhead</a>, so a client filing both sees one business rather than two.',
        'The client''s name, and where it matters, the department or person who approves payment.',
        'A unique invoice number.',
        'The issue date and, separately, the due date.',
        'A line for each thing you are charging for, with an amount.',
        'The total, set larger than everything around it.',
        'How to pay - bank details, or a note saying they are available on request.')),
      @('h2','Number them in sequence'),
      @('p','INV-2026-001, INV-2026-002, and so on, with no gaps. Gaps are the first thing an auditor asks about, and a client querying an invoice will always quote the number rather than describe the work.'),
      @('h2','Put a date, not a term'),
      @('p','"Net 14" means nothing to somebody outside finance. "Due 22 September 2026" is a date a person can act on. Where you use both, the date is the one that gets read.'),
      @('h2','Send it to the right person'),
      @('p','The person who hired you is often not the person who pays you. Ask, at the point of agreeing the work, who invoices should go to and whether they need a purchase order number on them. An invoice missing a PO number sits in a queue until somebody asks about it.'),
      @('h2','Chasing without damage'),
      @('p','A short, factual reminder on the day after the due date, referencing the invoice number and re-attaching the invoice, resolves most late payments. It works because the usual cause is an invoice sitting unapproved, not an unwillingness to pay. Escalate to the person who hired you only after the second reminder.'),
      @('h2','Keep a copy of everything'),
      @('p','Save every invoice as a PDF the day you send it, named with its number. Whatever your tax authority requires, the practical reason is simpler: when a client asks which invoice covers which month, you want to answer in one minute rather than one afternoon.'),
      @('cta','invoice-templates')) }
)
