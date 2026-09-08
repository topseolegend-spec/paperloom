# =============================================================================
#  Greeting Cards category
#  Subcategories search volume ke hisaab se tarteeb mein hain.
#
#  Ye cards hain (5x7), documents nahi - is liye mojooda card system par chalti
#  hain. Fields invitation se alag hain: yahan bara greeting, message, aur
#  To/From chahiye - date/venue nahi.
#
#  ZAROORI: is file mein Urdu/Arabic text seedha na likhein - PowerShell 5.1
#  ise ANSI parhta hai. HTML entities use karein.
# =============================================================================

$FieldsGreeting = @(
  (New-Field 'title' 'Greeting'        'text' 'Card'    'The big words - "Happy Birthday"'),
  (New-Field 'pre'   'Line above'      'text' 'Card'    'Leave empty to hide'),
  (New-Field 'mid'   'Message'         'area' 'Card'    'Enter for a new line'),
  (New-Field 'to'    'To'              'text' 'Sign it' ''),
  (New-Field 'from'  'From'            'text' 'Sign it' '')
)

# --- sample wording -----------------------------------------------------------

$GBody = @{
  birthday = @{ pre='Wishing you a very'; title='Happy Birthday'
    mid='Another year, and you have made every one of them better for the people around you.'
    to='For Ayesha'; from='With love, Sara' }
  thankyou = @{ pre='A heartfelt'; title='Thank You'
    mid='For the time you gave and the trouble you went to.<br>It did not go unnoticed.'
    to='For Bilal'; from='From the Khan family' }
  christmas = @{ pre='Wishing you a'; title='Merry Christmas'
    mid='May your house be warm, your table full,<br>and the year ahead kind to you.'
    to='For the Ahmed family'; from='From Sara and Hamza' }
  eid = @{ pre='Wishing you a blessed'; title='Eid Mubarak'
    mid='May this Eid bring peace to your home<br>and ease to the year ahead.'
    to='For Fatima and family'; from='From the Sheikh family' }
  anniversary = @{ pre='Celebrating you both'; title='Happy Anniversary'
    mid='Twenty-five years, and you still finish each other''s sentences.'
    to='For Ammi and Abbu'; from='From all of us' }
  getwell = @{ pre='Wishing you a'; title='Speedy Recovery'
    mid='Rest as long as you need.<br>Everything here will keep until you are back.'
    to='For Zain'; from='From everyone at the office' }
  congrats = @{ pre='Well done, truly'; title='Congratulations'
    mid='You worked for this long before anyone else noticed. Enjoy it.'
    to='For Hania'; from='From Amara' }
  sympathy = @{ pre='With deepest'; title='Sympathy'
    mid='There is nothing to say that makes it lighter.<br>We are thinking of you, and we are close by.'
    to='For the Malik family'; from='From your neighbours' }
  valentine = @{ pre='Happy'; title='Valentine''s Day'
    mid='Still you. Still this.<br>Still glad it turned out to be you.'
    to='For Sara'; from='From Hamza' }
  mothers = @{ pre='Happy'; title='Mother''s Day'
    mid='For the meals, the lifts, the worrying,<br>and the thousand things we never saw you do.'
    to='For Ammi'; from='From Amara and Zain' }
  fathers = @{ pre='Happy'; title='Father''s Day'
    mid='For every early morning drive,<br>and every time you said it would be fine.'
    to='For Abbu'; from='From Hania' }
  newyear = @{ pre='Wishing you a'; title='Happy New Year'
    mid='May the year ahead be steadier than the last,<br>and kinder where it counts.'
    to='For the Rahman family'; from='From Meridian Studio' }
}

# --- category -----------------------------------------------------------------

$GCategory = @{
  slug  = 'greeting-cards'
  name  = 'Greeting Cards'
  short = 'Greetings'
  panel = 'Occasions'
  blurb = 'Twelve occasions, four designs each - plain, modern, and two with more on them.'
  h1    = 'Greeting Card Templates'
  title = 'Greeting Card Templates - Free Editable Designs'
  desc  = 'Free editable greeting cards for birthdays, Eid, Christmas, thank you notes, sympathy and more. Write your own message in the browser, then print or download.'
  intro = @(
    'Forty-eight cards across twelve occasions, and every one of them takes your own words. Type the greeting, the message and who it is from into the boxes beside the card, and it updates as you write - there is no account step and nothing is watermarked.',
    'Each occasion comes in four directions on purpose, because a card for a colleague and a card for your mother should not look the same. There is a plain one, a modern one, one with a little decoration, and one with a good deal more.'
  )
}

# New-GCard: greeting cards ke liye - New-Tpl jaisa hi.
function New-GCard($slug, $name, $style, $design, $font, $art, $bg, $ink, $accent, $soft, $body,
                   $bgstyle = 'bg-plain', $foil = $false) {
  @{ slug=$slug; name=$name; style=$style; design=$design; font=$font; art=$art
     bg=$bg; ink=$ink; accent=$accent; soft=$soft; body=$body; bgstyle=$bgstyle; foil=$foil }
}

$GSubcats = @(

 @{ slug='birthday-card-templates'; name='Birthday Cards'; nav='Birthday'
    kind='greeting'; size='sz-5x7'; fields=$FieldsGreeting; ornaments=$true
    h1='Birthday Card Templates'
    title='Birthday Card Template - Free Editable Designs to Print'
    desc='Free birthday card templates you can write in and print. Four styles from plain to decorated, editable in your browser with no account.'
    guideNote='The design takes a minute; the message is where most people stall. There are openings for a friend, a parent, a colleague and someone you barely know in <a href="../../guides/what-to-write-in-a-birthday-card/">what to write in a birthday card</a>.'
    intro=@(
      'The hard part of a birthday card is never the design, it is the two lines inside. These four give that message room instead of burying it under artwork, and you can write it straight into the card rather than printing a blank and hoping your handwriting behaves.',
      'Confetti Bright and Garden Party carry the decoration; Quiet Wish and Bold Type keep out of the way, which suits a card going to a colleague or a boss. All four print at 5&times;7 inches and fold to A6 if you want an inside message.')
    faq=@(
      @('What should I write in a birthday card?','Something only you could have written. One specific memory or one thing you admire about them beats three lines of general good wishes, and it takes less effort than people expect - our guide has openings you can adapt.'),
      @('What size should a birthday card be printed at?','5&times;7 inches is the standard, and it fits envelopes sold everywhere. Print on 250gsm or heavier or the card will not stand up on a shelf.'),
      @('Can I use these for a milestone birthday?','Yes - change the greeting line to the age and the card reads as a milestone card. Bold Type in particular is built for a number set large.'))
    templates=@(
      (New-GCard 'quiet-wish' 'Quiet Wish' 'Plain &middot; centred type' 'g-plain' 'f-tenor' '' '#fdfdfc' '#22262b' '#4c6377' '#5b656d' $GBody.birthday),
      (New-GCard 'bold-type-birthday' 'Bold Type' 'Modern &middot; offset band' 'g-modern' 'f-josefin' '' '#ffffff' '#1c2430' '#c1543f' '#5a6470' $GBody.birthday),
      (New-GCard 'garden-party' 'Garden Party' 'Decorated &middot; sprigs and script' 'g-soft' 'f-script' 'botanical' '#fdf7f4' '#4a3230' '#c07a5c' '#7a5f58' $GBody.birthday 'bg-wash'),
      (New-GCard 'confetti-bright-card' 'Confetti Bright' 'Decorated &middot; confetti and foil' 'g-rich' 'f-cinzel-dec' 'confetti' '#fffaf2' '#3a2f22' '#c9a227' '#6d6152' $GBody.birthday 'bg-grad' $true)) },

 @{ slug='thank-you-card-templates'; name='Thank You Cards'; nav='Thank You'
    kind='greeting'; size='sz-5x7'; fields=$FieldsGreeting; ornaments=$true
    h1='Thank You Card Templates'
    title='Thank You Card Template - Free Printable Designs'
    desc='Free thank you card templates for gifts, weddings, interviews and favours. Write the note in your browser, then print or save as PDF.'
    guideNote='Wedding thank you cards are the largest batch most people ever write - naming the specific gift in each is what separates them, and the guest list from your <a href="../../wedding-events/wedding-invitations/">invitations</a> is the list to work from.'
    intro=@(
      'A thank you card works on timing more than wording - sent within a week it means something, sent after a month it reads as an apology. These four are quick to fill in for exactly that reason.',
      'Fine Line and Modern Note are quiet enough for a professional thank you after an interview or a client meeting. Blush Sprig and Gold Laurel suit gifts, weddings and anything where warmth is the point.')
    faq=@(
      @('What do you write in a thank you card?','Name the specific thing, say what it meant, and close warmly. "Thank you for the mixer - I have used it twice already and thought of you both" does more than a paragraph of general gratitude.'),
      @('How soon should thank you cards be sent?','Within a week for a gift or a favour, within 24 hours after a job interview, and within three months after a wedding. Late is still better than never, and no one has ever minded receiving one.'),
      @('Do thank you cards need to be handwritten?','A handwritten note reads warmer, but a printed card with a signed name is entirely acceptable and far better than the card that never gets written. Print these, sign them, and post them.'))
    templates=@(
      (New-GCard 'fine-line' 'Fine Line' 'Plain &middot; hairline rule' 'g-plain' 'f-cormorant' '' '#fdfcf9' '#241f1b' '#8a6a3b' '#5f5850' $GBody.thankyou),
      (New-GCard 'modern-note' 'Modern Note' 'Modern &middot; offset band' 'g-modern' 'f-tenor' '' '#ffffff' '#1f2a23' '#2e5d4b' '#5a6660' $GBody.thankyou),
      (New-GCard 'blush-sprig' 'Blush Sprig' 'Decorated &middot; sprigs and script' 'g-soft' 'f-parisienne' 'botanical' '#fdf5f4' '#4a2c2a' '#c08497' '#7b5c5c' $GBody.thankyou 'bg-wash'),
      (New-GCard 'gold-laurel-thanks' 'Gold Laurel' 'Decorated &middot; laurel and foil' 'g-rich' 'f-cinzel' 'laurel' '#fdfaf3' '#2c2a24' '#a8823f' '#5f5b50' $GBody.thankyou 'bg-grad' $true)) },

 @{ slug='christmas-card-templates'; name='Christmas Cards'; nav='Christmas'
    kind='greeting'; size='sz-5x7'; fields=$FieldsGreeting; ornaments=$true
    h1='Christmas Card Templates'
    title='Christmas Card Template - Free Printable Designs to Edit'
    desc='Free Christmas card templates in classic and modern styles. Add your own message and family name, then print or send as an image.'
    guideNote='Most people post these in the same week as their <a href="../../greeting-cards/new-year-card-templates/">new year cards</a> - if you are sending both to the same list, one card carrying both wishes saves a stamp and reads as less of a duty.'
    intro=@(
      'Christmas cards go out in bulk, which is the whole design problem: the same card has to work for your aunt, your neighbour and the person who does your accounts. These four solve it by keeping the greeting general and giving the signature line enough room to be specific.',
      'Evergreen Wreath and Midnight Gold are the traditional ones. Winter Plain and Nordic Modern are quieter, and print cheaply in quantity - which matters when you are sending forty.')
    faq=@(
      @('When should Christmas cards be posted?','By the first week of December for domestic post, and by late November for anything going abroad. Cards that arrive after the twentieth tend to be opened in January.'),
      @('What do you write in a Christmas card for someone you do not know well?','Keep it warm and general - a good wish for the season and the year ahead. Save the personal note for the people who will notice its absence.'),
      @('Can I send these as digital cards?','Yes. Download the image and send it by WhatsApp or email. The square size in the editor is the one that displays properly in a chat without being cropped.'))
    templates=@(
      (New-GCard 'winter-plain' 'Winter Plain' 'Plain &middot; centred type' 'g-plain' 'f-tenor' '' '#fcfdfd' '#1e2a2e' '#3f6b6b' '#566469' $GBody.christmas),
      (New-GCard 'nordic-modern' 'Nordic Modern' 'Modern &middot; offset band' 'g-modern' 'f-josefin' 'geometric' '#ffffff' '#1b2b2b' '#8c3b3b' '#5a6666' $GBody.christmas),
      (New-GCard 'evergreen-wreath' 'Evergreen Wreath' 'Decorated &middot; wreath' 'g-soft' 'f-cormorant' 'wreath' '#f6f9f5' '#16321f' '#2e5d3b' '#57685c' $GBody.christmas 'bg-grad'),
      (New-GCard 'midnight-gold-christmas' 'Midnight Gold' 'Decorated &middot; dark card and foil' 'g-rich' 'f-cinzel' 'vine' '#16241d' '#f1ece0' '#c9a227' '#c2c8ba' $GBody.christmas 'bg-edge' $true)) },

 @{ slug='eid-card-templates'; name='Eid Cards'; nav='Eid'
    kind='greeting'; size='sz-5x7'; fields=$FieldsGreeting; ornaments=$true
    h1='Eid Card Templates'
    title='Eid Mubarak Card Template - Free Editable Designs to Print'
    desc='Free Eid Mubarak card templates with geometric and calligraphic designs. Write your own message, switch to Urdu or Arabic, then print or share.'
    guideNote='A card for your grandmother and one for a client differ mostly in length - there is wording for family, friends, colleagues and clients in <a href="../../guides/eid-card-messages/">what to write in an Eid card</a>, including notes on setting it in Urdu or Arabic.'
    intro=@(
      'Eid cards are sent to a wide circle in a short window, so the design has to carry warmth without needing a personal note on every one. These four do that, and all of them switch to Nastaliq, Amiri or Naskh in the editor if you would rather write the greeting in Urdu or Arabic.',
      'Emerald Mandala and Gold Lattice use geometric line work drawn here rather than borrowed - a pattern family that sits comfortably beside Arabic lettering. Ivory Plain and Crescent Modern are simpler, and suit a card going to colleagues.')
    faq=@(
      @('What do you write in an Eid card?','"Eid Mubarak" carries most of it. A line wishing peace or ease for the year, and the names of everyone sending it, is enough - Eid cards are read quickly and passed round a room.'),
      @('Can I write the card in Urdu or Arabic?','Yes. Pick Nastaliq, Amiri or Naskh from the typeface list and the whole card switches to right-to-left with the line spacing those scripts need, then type your own text.'),
      @('Are these suitable for both Eid al-Fitr and Eid al-Adha?','Yes - the greeting line is yours to change, so the same design serves either. Nothing in the artwork is specific to one.'))
    templates=@(
      (New-GCard 'ivory-plain-eid' 'Ivory Plain' 'Plain &middot; centred type' 'g-plain' 'f-marcellus' '' '#fcfaf5' '#2b2a26' '#8c7a4b' '#6d675c' $GBody.eid),
      (New-GCard 'crescent-modern' 'Crescent Modern' 'Modern &middot; offset band' 'g-modern' 'f-josefin' '' '#ffffff' '#14392c' '#1f5c45' '#4f6459' $GBody.eid),
      (New-GCard 'emerald-mandala' 'Emerald Mandala' 'Decorated &middot; mandala' 'g-soft' 'f-amiri' 'mandala' '#f5f8f4' '#14392c' '#2e7d5a' '#4f6459' $GBody.eid 'bg-grad'),
      (New-GCard 'gold-lattice-eid' 'Gold Lattice' 'Decorated &middot; dark card and foil' 'g-rich' 'f-cinzel' 'geometric' '#14201b' '#f0e6d2' '#c9a227' '#bfc6b8' $GBody.eid 'bg-edge' $true)) },

 @{ slug='anniversary-card-templates'; name='Anniversary Cards'; nav='Anniversary'
    kind='greeting'; size='sz-5x7'; fields=$FieldsGreeting; ornaments=$true
    h1='Anniversary Card Templates'
    title='Anniversary Card Template - Free Printable Designs to Edit'
    desc='Free anniversary card templates for couples and parents. Add your own message and years, then print or save as PDF.'
    guideNote='An anniversary card marks the day a <a href="../../wedding-events/wedding-invitations/">wedding invitation</a> once announced, which is why naming the year usually lands better than a general good wish.'
    intro=@(
      'An anniversary card is usually going to two people who have heard every general compliment already, so the useful thing a template can do is leave room for one specific line. These four keep the greeting short for that reason.',
      'Gold Vine and Rose Wreath are the celebratory ones and suit a milestone year. Simple Years and Modern Pair are quieter, and work as well for a first anniversary as a fortieth.')
    faq=@(
      @('What do you write in an anniversary card?','One thing you have actually seen between them. How they are with each other at a family dinner says more than a wish for many more years, and it is the line they will remember.'),
      @('Should the number of years be on the card?','On a milestone - twenty-five, forty, fifty - yes, set large. On an ordinary year it can make the card feel like a certificate rather than a note.'),
      @('Can I use these for my own anniversary?','Yes. Change the greeting and sign it from one name rather than several; the layouts do not assume the card is coming from a family.'))
    templates=@(
      (New-GCard 'simple-years' 'Simple Years' 'Plain &middot; centred type' 'g-plain' 'f-cormorant' '' '#fdfcfa' '#241f22' '#7b4a5a' '#5f545a' $GBody.anniversary),
      (New-GCard 'modern-pair' 'Modern Pair' 'Modern &middot; offset band' 'g-modern' 'f-tenor' '' '#ffffff' '#22282e' '#2f4858' '#5d666e' $GBody.anniversary),
      (New-GCard 'rose-wreath' 'Rose Wreath' 'Decorated &middot; wreath and script' 'g-soft' 'f-script' 'wreath' '#fdf5f6' '#4e2f38' '#b3697d' '#7d5f67' $GBody.anniversary 'bg-wash'),
      (New-GCard 'gold-vine-anniversary' 'Gold Vine' 'Decorated &middot; vine and foil' 'g-rich' 'f-cinzel-dec' 'vine' '#fdfaf3' '#2c2a24' '#a8823f' '#5f5b50' $GBody.anniversary 'bg-grad' $true)) },

 @{ slug='get-well-soon-card-templates'; name='Get Well Soon Cards'; nav='Get Well Soon'
    kind='greeting'; size='sz-5x7'; fields=$FieldsGreeting; ornaments=$true
    h1='Get Well Soon Card Templates'
    title='Get Well Soon Card Template - Free Printable Designs'
    desc='Free get well soon card templates for illness, surgery and recovery. Write a short message in your browser, then print or send.'
    guideNote='Keep it light and short - recovery is tiring to talk about. Where the news is worse rather than temporary, a <a href="../../greeting-cards/sympathy-card-templates/">sympathy card</a> is a different register entirely and the wording changes with it.'
    intro=@(
      'A get well card is read by someone with little energy for reading, which is the one design constraint that matters: short message, large enough type, nothing that needs deciphering. These four are built to that.',
      'Soft Bloom and Sunlit are warm without being relentlessly cheerful, which is the tone most people actually want. Plain Wish and Calm Modern are quieter still, and suit a card from an office rather than a family.')
    faq=@(
      @('What do you write in a get well card?','Take the pressure off. "No need to reply" and "everything here will keep" are worth more than instructions to rest, because they remove a small obligation rather than adding one.'),
      @('What should you avoid writing?','Anything that asks a question, describes your own similar illness, or promises they will be fine - none of it is yours to say. Keep it short and warm.'),
      @('Is a card from a whole office appropriate?','Yes, and it is often the most welcome kind. Sign it with everyone''s names rather than the department, so it reads as people rather than an organisation.'))
    templates=@(
      (New-GCard 'plain-wish' 'Plain Wish' 'Plain &middot; centred type' 'g-plain' 'f-tenor' '' '#fcfdfd' '#1f2a30' '#4a7c8c' '#586268' $GBody.getwell),
      (New-GCard 'calm-modern' 'Calm Modern' 'Modern &middot; offset band' 'g-modern' 'f-josefin' '' '#ffffff' '#24403a' '#64a88f' '#546a63' $GBody.getwell),
      (New-GCard 'soft-bloom' 'Soft Bloom' 'Decorated &middot; sprigs' 'g-soft' 'f-cormorant' 'botanical' '#f7fbf7' '#26402c' '#6e9a72' '#5a6a5c' $GBody.getwell 'bg-wash'),
      (New-GCard 'sunlit' 'Sunlit' 'Decorated &middot; flourish' 'g-rich' 'f-marcellus' 'flourish' '#fffbf0' '#453d26' '#d9a83f' '#6f6852' $GBody.getwell 'bg-grad')) },

 @{ slug='congratulations-card-templates'; name='Congratulations Cards'; nav='Congratulations'
    kind='greeting'; size='sz-5x7'; fields=$FieldsGreeting; ornaments=$true
    h1='Congratulations Card Templates'
    title='Congratulations Card Template - Free Printable Designs'
    desc='Free congratulations card templates for new jobs, exams, promotions and new homes. Write your own message, then print or download.'
    guideNote='For a graduation specifically, the family often sends a card and an invitation in the same envelope - the <a href="../../wedding-events/graduation-invitations/">graduation invitations</a> are the matching half of that.'
    intro=@(
      'Congratulations cards cover a wide range - a new job, an exam result, a promotion, a first house - so these keep the greeting broad and put the weight on the message, which is the part that has to fit the occasion.',
      'Bright Confetti and Gold Laurel read as celebration. Plain Congrats and Bold Modern are more restrained, which is usually the right call for a colleague or a client.')
    faq=@(
      @('What do you write in a congratulations card?','Name what they achieved and acknowledge what it cost. "Congratulations on the promotion - the last two years of it were not easy to watch, never mind live through" lands harder than praise alone.'),
      @('Is a card still appropriate for a work achievement?','Yes, and it stands out precisely because most congratulations now arrive as messages. A physical card on a desk is read more than once.'),
      @('Can I use one of these for an exam result?','Yes - change the greeting line to suit, and keep the message short. Results cards are usually opened in front of other people.'))
    templates=@(
      (New-GCard 'plain-congrats' 'Plain Congrats' 'Plain &middot; centred type' 'g-plain' 'f-tenor' '' '#fdfdfc' '#1f2a30' '#3f7a8c' '#586268' $GBody.congrats),
      (New-GCard 'bold-modern-congrats' 'Bold Modern' 'Modern &middot; offset band' 'g-modern' 'f-josefin' '' '#ffffff' '#1c2430' '#2f4858' '#5a6470' $GBody.congrats),
      (New-GCard 'bright-confetti' 'Bright Confetti' 'Decorated &middot; confetti' 'g-soft' 'f-parisienne' 'confetti' '#fdfbf4' '#33301f' '#c98a2e' '#6b6552' $GBody.congrats 'bg-wash'),
      (New-GCard 'gold-laurel-congrats' 'Gold Laurel' 'Decorated &middot; laurel and foil' 'g-rich' 'f-cinzel' 'laurel' '#f8f8f4' '#16233d' '#b08a3e' '#565f70' $GBody.congrats 'bg-grad' $true)) },

 @{ slug='sympathy-card-templates'; name='Sympathy Cards'; nav='Sympathy'
    kind='greeting'; size='sz-5x7'; fields=$FieldsGreeting; ornaments=$true
    h1='Sympathy Card Templates'
    title='Sympathy Card Template - Free Printable Condolence Designs'
    desc='Free sympathy and condolence card templates in quiet, restrained designs. Write a short message in your browser, then print.'
    guideNote='Most people put this card off out of fear of getting it wrong. Three or four sentences is the whole of it, and <a href="../../guides/what-to-write-in-a-sympathy-card/">what to write in a sympathy card</a> covers the few phrases that land badly however kindly they are meant.'
    intro=@(
      'A sympathy card should not be doing anything clever. These four are deliberately restrained - muted colour, generous space, no ornament that draws the eye away from the few words you have chosen.',
      'Quiet Grey and Still Modern carry no decoration at all. Olive Branch and Soft Laurel add a small amount, which some families prefer to a card that looks severe.')
    faq=@(
      @('What do you write in a sympathy card?','Say their name, say something true about them, and offer one specific thing rather than a general offer of help. "I will call on Sunday to see about the shopping" is easier to accept than "let me know if you need anything".'),
      @('What should you not write?','Anything that explains the loss or looks for a silver lining. Comparisons to your own losses also tend to land badly, however well meant.'),
      @('Is it too late to send one?','No. Cards arriving weeks later are often the most valued, because they come after everyone else has moved on and the house has gone quiet.'))
    templates=@(
      (New-GCard 'quiet-grey' 'Quiet Grey' 'Plain &middot; centred type' 'g-plain' 'f-cormorant' '' '#fbfbfa' '#2a2c2e' '#6b727a' '#5f6469' $GBody.sympathy),
      (New-GCard 'still-modern' 'Still Modern' 'Modern &middot; offset band' 'g-modern' 'f-tenor' '' '#ffffff' '#232c33' '#4c6377' '#5b656d' $GBody.sympathy),
      (New-GCard 'olive-branch' 'Olive Branch' 'Decorated &middot; sprigs' 'g-soft' 'f-marcellus' 'botanical' '#f7f8f4' '#2e352b' '#6f7d5c' '#5d6357' $GBody.sympathy 'bg-grad'),
      (New-GCard 'soft-laurel' 'Soft Laurel' 'Decorated &middot; laurel' 'g-rich' 'f-libre' 'laurel' '#fbf9f5' '#2f2b26' '#8a7a63' '#615c54' $GBody.sympathy 'bg-edge')) },

 @{ slug='valentines-card-templates'; name='Valentine''s Day Cards'; nav='Valentine''s Day'
    kind='greeting'; size='sz-5x7'; fields=$FieldsGreeting; ornaments=$true
    h1='Valentine''s Day Card Templates'
    title='Valentines Card Template - Free Printable Designs'
    desc='Free Valentine''s Day card templates from plain to romantic. Write your own message in the browser, then print or send as an image.'
    guideNote='For a couple further along, an <a href="../../greeting-cards/anniversary-card-templates/">anniversary card</a> naming a specific year usually says more than a Valentine''s card can.'
    intro=@(
      'The best Valentine''s cards are specific and slightly understated, which is the opposite of what most templates offer. These four leave the decoration restrained and give the message the middle of the card.',
      'Rose Wreath and Wine Script are the romantic ones. Plain Heart and Bold Red are drier, which suits couples who would find anything softer faintly embarrassing.')
    faq=@(
      @('What do you write in a Valentine''s card?','Something particular to the two of you rather than to romance in general. A private reference or an ordinary moment you both remember beats any borrowed line.'),
      @('Is a printed card acceptable?','Yes, especially one you wrote yourself and printed at home. What people remember is whether the words were yours, not whether the card came from a shop.'),
      @('Can I use these for a first Valentine''s?','Plain Heart and Bold Red are the safer two - warm without assuming more than has been said out loud yet.'))
    templates=@(
      (New-GCard 'plain-heart' 'Plain Heart' 'Plain &middot; centred type' 'g-plain' 'f-tenor' '' '#fdfcfc' '#2a2226' '#a05064' '#5f555a' $GBody.valentine),
      (New-GCard 'bold-red' 'Bold Red' 'Modern &middot; offset band' 'g-modern' 'f-josefin' '' '#ffffff' '#2b1620' '#a8324a' '#5f5257' $GBody.valentine),
      (New-GCard 'rose-wreath-valentine' 'Rose Wreath' 'Decorated &middot; wreath and script' 'g-soft' 'f-script' 'wreath' '#fdf4f6' '#4d2a34' '#c2687e' '#7a5c63' $GBody.valentine 'bg-wash'),
      (New-GCard 'wine-script' 'Wine Script' 'Decorated &middot; bouquet and foil' 'g-rich' 'f-sacramento' 'bouquet' '#2b1620' '#f5ebe9' '#c98a94' '#d8c6c6' $GBody.valentine 'bg-edge' $true)) },

 @{ slug='mothers-day-card-templates'; name='Mother''s Day Cards'; nav='Mother''s Day'
    kind='greeting'; size='sz-5x7'; fields=$FieldsGreeting; ornaments=$true
    h1='Mother''s Day Card Templates'
    title='Mothers Day Card Template - Free Printable Designs to Edit'
    desc='Free Mother''s Day card templates you can write in and print. Four styles from plain to floral, editable in your browser.'
    guideNote='Say the thing you assume she already knows - that advice comes from <a href="../../guides/what-to-write-in-a-birthday-card/">writing for a parent</a>, and it is the one line most of these cards are missing.'
    intro=@(
      'Mother''s Day cards are kept, often for years, which is an argument for writing something specific rather than choosing the prettiest card. These four give the message the room to be worth keeping.',
      'Peony Bloom and Gold Wreath are the floral ones. Plain Thanks and Modern Mum are simpler, and print well if the card is coming from a child who wants to add their own drawing.')
    faq=@(
      @('What do you write in a Mother''s Day card?','One thing she did that you only understood later. Cards that name something particular get kept; cards that thank her for everything get read once.'),
      @('Can children use these?','Yes - print one of the plainer designs and there is space for a child to write or draw inside. Fold the 5&times;7 card to A6 for that.'),
      @('What if Mother''s Day is a difficult day?','Keep it short and plain, and skip the celebration wording. Plain Thanks with two quiet lines is often the right card.'))
    templates=@(
      (New-GCard 'plain-thanks' 'Plain Thanks' 'Plain &middot; centred type' 'g-plain' 'f-cormorant' '' '#fdfcfa' '#26221f' '#8a6a5b' '#5f5850' $GBody.mothers),
      (New-GCard 'modern-mum' 'Modern Mum' 'Modern &middot; offset band' 'g-modern' 'f-tenor' '' '#ffffff' '#3f3550' '#8f7ab4' '#605a6b' $GBody.mothers),
      (New-GCard 'peony-bloom' 'Peony Bloom' 'Decorated &middot; bouquet and script' 'g-soft' 'f-parisienne' 'bouquet' '#fdf5f7' '#4e3038' '#d08c9e' '#7d5f67' $GBody.mothers 'bg-wash'),
      (New-GCard 'gold-wreath-mothers' 'Gold Wreath' 'Decorated &middot; wreath and foil' 'g-rich' 'f-cinzel-dec' 'wreath' '#fdfaf3' '#2c2a24' '#b08a3e' '#5f5b50' $GBody.mothers 'bg-grad' $true)) },

 @{ slug='fathers-day-card-templates'; name='Father''s Day Cards'; nav='Father''s Day'
    kind='greeting'; size='sz-5x7'; fields=$FieldsGreeting; ornaments=$true
    h1='Father''s Day Card Templates'
    title='Fathers Day Card Template - Free Printable Designs to Edit'
    desc='Free Father''s Day card templates in plain, modern and classic styles. Write your own message, then print or save as PDF.'
    guideNote='The <a href="../../greeting-cards/mothers-day-card-templates/">Mother''s Day designs</a> use the same layouts and fields, so a household sending both can keep them consistent and only change the wording.'
    intro=@(
      'Most Father''s Day cards fail in the same way: they are jokes about golf sent to men who do not play golf. These four are plain enough to carry whatever you actually want to say.',
      'Slate Plain and Bold Lines are the driest of the four. Deep Green and Classic Deco add a little more, and suit a card that is also marking a birthday or a retirement.')
    faq=@(
      @('What do you write in a Father''s Day card?','Something he did rather than something he is. A specific memory - a drive, a repair, a time he turned up - reads truer than a list of qualities.'),
      @('What if the tone between you is not sentimental?','Then do not force it. A short, dry line in his own register will mean more than warmth he would find awkward. Bold Lines is built for exactly that.'),
      @('Can these be used for a grandfather or stepfather?','Yes - the greeting line is editable, so change it to whatever he is actually called in your family.'))
    templates=@(
      (New-GCard 'slate-plain' 'Slate Plain' 'Plain &middot; centred type' 'g-plain' 'f-tenor' '' '#fcfcfb' '#22282e' '#4c6377' '#5b656d' $GBody.fathers),
      (New-GCard 'bold-lines' 'Bold Lines' 'Modern &middot; offset band' 'g-modern' 'f-josefin' '' '#ffffff' '#1c2430' '#2f4858' '#5a6470' $GBody.fathers),
      (New-GCard 'deep-green-fathers' 'Deep Green' 'Decorated &middot; laurel' 'g-soft' 'f-marcellus' 'laurel' '#f5f8f4' '#1f3328' '#3f6b4b' '#5d6b5f' $GBody.fathers 'bg-grad'),
      (New-GCard 'classic-deco-fathers' 'Classic Deco' 'Decorated &middot; art deco and foil' 'g-rich' 'f-cinzel' 'deco' '#16161a' '#f2eee4' '#c9a227' '#bdb9b0' $GBody.fathers 'bg-edge' $true)) },

 @{ slug='new-year-card-templates'; name='New Year Cards'; nav='New Year'
    kind='greeting'; size='sz-5x7'; fields=$FieldsGreeting; ornaments=$true
    h1='New Year Card Templates'
    title='New Year Card Template - Free Printable Designs to Edit'
    desc='Free Happy New Year card templates for family, friends and clients. Add your own message and year, then print or send as an image.'
    guideNote='A client new year card works on the same restraint as a business <a href="../../greeting-cards/thank-you-card-templates/">thank you card</a>: one line of thanks, one good wish, and the company name.'
    intro=@(
      'New Year cards are the ones businesses send as well as families, which is why two of these four are deliberately restrained enough to go out on a company letterhead without looking out of place.',
      'Midnight Gold and Deco Nights are the celebratory pair. Plain Year and Modern Turn are quieter, and work as a client card where anything more would read as trying too hard.')
    faq=@(
      @('When should New Year cards be sent?','Late December, or the first week of January if you missed the Christmas post. A card arriving in the first week of the year gets more attention than one lost in the December pile.'),
      @('What do you write in a New Year card for a client?','Thank them for the year''s work in one line and wish them well in the next. Keep it short - a client card that reads like marketing gets binned.'),
      @('Can I put the year on the card?','Yes, and on a New Year card it usually helps. Set it in the greeting line and it becomes the largest thing on the card.'))
    templates=@(
      (New-GCard 'plain-year' 'Plain Year' 'Plain &middot; centred type' 'g-plain' 'f-tenor' '' '#fcfcfd' '#1f2530' '#42566e' '#5a616b' $GBody.newyear),
      (New-GCard 'modern-turn' 'Modern Turn' 'Modern &middot; offset band' 'g-modern' 'f-josefin' '' '#ffffff' '#1b2430' '#22394f' '#59636e' $GBody.newyear),
      (New-GCard 'deco-nights' 'Deco Nights' 'Decorated &middot; art deco' 'g-soft' 'f-italiana' 'deco' '#fbfaf6' '#26262b' '#7b6a3f' '#605d55' $GBody.newyear 'bg-grad'),
      (New-GCard 'midnight-gold-newyear' 'Midnight Gold' 'Decorated &middot; dark card and foil' 'g-rich' 'f-cinzel-dec' 'flourish' '#1b2a41' '#f3efe6' '#c9a227' '#b9c2cf' $GBody.newyear 'bg-edge' $true)) }
)

# --- guides -------------------------------------------------------------------

$GGuides = @(
 @{ slug='what-to-write-in-a-birthday-card'
    title='What to Write in a Birthday Card - Lines That Are Not Filler'
    h1='What to Write in a Birthday Card'
    desc='How to write a birthday message that sounds like you, with openings for friends, parents, colleagues and people you barely know.'
    read='6 min read'
    body=@(
      @('p','Almost everyone writes the same four words and then stalls. The stall is not a lack of affection - it is that "happy birthday" has already said the obvious thing, and nothing after it feels necessary. Here is what to put there instead.'),
      @('h2','The one rule worth following'),
      @('p','Write something only you could have written. A card that could have been signed by anyone gets read once and recycled; a card naming one particular thing gets kept in a drawer. This is easier than it sounds, because you are not looking for something profound - you are looking for something specific.'),
      @('h2','Three openings that do the work for you'),
      @('ol',@(
        '<strong>Name a moment.</strong> "Still thinking about that afternoon we got lost near Murree." No point needed - the memory is the point.',
        '<strong>Name a quality, with evidence.</strong> Not "you are so generous" but "you drove two hours to help me move a sofa, and never mentioned it again".',
        '<strong>Name what this year held.</strong> "It has been a heavy year and you carried it well." This is the one people remember, because it acknowledges something rather than skipping past it.')),
      @('h2','For a colleague or a boss'),
      @('p','Warm, short, and about work is the safe register: something you have noticed them do well, and a good wish for the year. Avoid age jokes entirely - they read differently on paper than they sound aloud, and the card may sit on a desk for a fortnight.'),
      @('h2','For a parent'),
      @('p','Say the thing you assume they already know. They usually do not, or not in the words you would use. One sentence naming something they did for you, written plainly, is the whole card.'),
      @('h2','For someone you do not know well'),
      @('p','Keep it general and warm and do not strain for intimacy that is not there. "Wishing you a good year ahead" signed with your name is perfectly good. Forced familiarity is more awkward than brevity.'),
      @('h2','A milestone birthday'),
      @('p','Mark the number, then get off it quickly. The person turning fifty has heard every joke about it by the time your card arrives, and what they will actually reread is the line about who they are now.'),
      @('h2','Endings'),
      @('p','"With love" for family and close friends, "warmest wishes" for everyone else, and your name - not your full name, unless there are two of you. If you are stuck on the ending you are usually done; sign it and post it. Every <a href="../../greeting-cards/birthday-card-templates/">birthday card design here</a> takes the message as a field, so a long line and a short one both sit correctly on the card.'),
      @('cta','birthday-card-templates')) },

 @{ slug='what-to-write-in-a-sympathy-card'
    title='What to Write in a Sympathy Card - And What to Leave Out'
    h1='What to Write in a Sympathy Card'
    desc='How to write a condolence message that helps, the phrases that land badly however well meant, and why a late card is still worth sending.'
    read='6 min read'
    body=@(
      @('p','People put off sympathy cards because they are afraid of getting it wrong. The card that arrives clumsily is almost always better than the card that never arrives, and there are only a few things that genuinely land badly. For an illness rather than a bereavement, a <a href="../../greeting-cards/get-well-soon-card-templates/">get well card</a> carries a different register entirely and most of the advice below does not apply.'),
      @('h2','What to include'),
      @('ol',@(
        '<strong>Their name.</strong> Say the name of the person who died. Families notice when everyone avoids it, and hearing it is usually a relief rather than a wound.',
        '<strong>One true thing about them.</strong> A memory, a habit, something they said. This is the part that gets read again months later.',
        '<strong>One specific offer.</strong> Not "let me know if you need anything" - that hands them a task. "I will call on Sunday about the school run" is something they can accept by saying nothing.')),
      @('h2','What to leave out'),
      @('ul',@(
        'Explanations. Anything beginning "at least" or "everything happens for a reason" asks the bereaved to feel better for your comfort.',
        'Your own losses. However similar, this is not the moment, and it moves the card onto you.',
        'Instructions. "Be strong", "stay positive", "they would want you to" - all of it is a demand dressed as support.',
        'Questions. A card should need no reply.')),
      @('h2','If you did not know the person who died'),
      @('p','Then write about the person you do know. "I do not know what to say, but I am thinking of you and I am close by" is honest and entirely sufficient. Admitting you have no words is not a failure of the card - it is often the truest line in it.'),
      @('h2','If you knew them well'),
      @('p','Then the family will want your memory more than your sympathy. Write the small specific thing - how he answered the phone, what she always brought to dinner. Families collect these afterwards; several people have described rereading them for years.'),
      @('h2','On being late'),
      @('p','A card arriving three weeks after the funeral is often the most valued one, because it comes when the house has gone quiet and everyone else has moved on. If you missed the moment, send it anyway, and do not apologise for the delay at length.'),
      @('h2','Length'),
      @('p','Three or four sentences. A <a href="../../greeting-cards/sympathy-card-templates/">sympathy card</a> is not an essay, and the reader is exhausted. Say the name, say the true thing, make the offer, sign it.'),
      @('cta','sympathy-card-templates')) },

 @{ slug='eid-card-messages'
    title='Eid Card Messages for Family, Friends and Colleagues'
    h1='What to Write in an Eid Card'
    desc='Eid Mubarak wording for family, friends, colleagues and clients, plus notes on writing the card in Urdu or Arabic.'
    read='5 min read'
    body=@(
      @('p','"Eid Mubarak" carries most of the card on its own. What follows depends on who is opening it, and the difference between a card for your grandmother and one for a client is mostly a matter of length.'),
      @('h2','For family'),
      @('blockquote','Eid Mubarak.<br>May this Eid bring peace to your home and ease to the year ahead.<br>Missing you at the table this year.'),
      @('p','Family cards can name the absence - who is not there, who is far away. That line is usually the reason the card gets kept.'),
      @('h2','For friends'),
      @('blockquote','Eid Mubarak!<br>Wishing you a day of good food, better company, and no washing up.'),
      @('p','Lighter is fine here. A card between friends can be funny in a way a card to an elder cannot.'),
      @('h2','For colleagues'),
      @('blockquote','Eid Mubarak.<br>Wishing you and your family a peaceful and joyful Eid.'),
      @('p','Short and warm. If you are sending to colleagues who do not celebrate Eid, a line explaining what the day is turns a greeting into a small act of hospitality rather than an assumption.'),
      @('h2','For clients'),
      @('blockquote','Eid Mubarak from all of us at Meridian.<br>Thank you for a good year of working together. We hope the holiday brings you rest.'),
      @('p','One line of thanks, one good wish, and the company name. A client card that reads as marketing is worse than no card. Outside Eid, the same restraint works on a <a href="../../greeting-cards/thank-you-card-templates/">thank you card</a> to a client at the end of a project.'),
      @('h2','Eid al-Fitr and Eid al-Adha'),
      @('p','The greeting is the same for both, and most cards are used for either. Where you want to distinguish them, a card for Eid al-Fitr can mention the end of the fast, and one for Eid al-Adha the spirit of sacrifice and sharing - but neither is expected.'),
      @('h2','Writing in Urdu or Arabic'),
      @('p','Every <a href="../../greeting-cards/eid-card-templates/">Eid card here</a> switches to Nastaliq, Amiri or Naskh in the editor, and the layout flips to right-to-left with the line spacing those scripts need. Keep lines short: Nastaliq in particular needs vertical room, and a long line set in it becomes hard to read at card size.'),
      @('cta','eid-card-templates')) }
)
