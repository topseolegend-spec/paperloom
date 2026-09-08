# =============================================================================
#  Education &amp; School category
#  Subcategories search volume ke hisaab se tarteeb mein hain.
#
#  Zyadatar A4 documents hain, is liye CV/invoice wala system chalta hai.
#  Teen mein grid chahiye (timetable, report card, attendance) - un ke columns
#  "har field ki lines barabar" wale tareeqe se align hote hain: har column ek
#  area field hai aur sab ka line-height ek hai, to lines aapas mein mil jati
#  hain. Ye sada hai aur asli register bhi isi tarah chalte hain.
#
#  ZAROORI: is file mein Urdu/Arabic text seedha na likhein - HTML entities.
# =============================================================================

$FieldsWorksheet = @(
  (New-Field 'title'        'Worksheet title'  'text' 'Header'    ''),
  (New-Field 'meta'         'Subject and class' 'text' 'Header'   ''),
  (New-Field 'nameline'     'Name and date line' 'text' 'Header'  'Leave empty to hide'),
  (New-Field 'instructions' 'Instructions'     'area' 'Body'      ''),
  (New-Field 'items'        'Questions'        'area' 'Body'      'One per line - each gets a ruled answer space'),
  (New-Field 'footer'       'Footer'           'text' 'Footer'    '')
)

$FieldsLesson = @(
  (New-Field 'title'      'Lesson title'      'text' 'Header'  ''),
  (New-Field 'meta'       'Subject and class' 'text' 'Header'  ''),
  (New-Field 'date'       'Date'              'text' 'Header'  ''),
  (New-Field 'duration'   'Duration'          'text' 'Header'  ''),
  (New-Field 'secObj'     'Section heading'   'text' 'Plan'    ''),
  (New-Field 'objectives' 'Learning objectives' 'area' 'Plan'  'One per line'),
  (New-Field 'secMat'     'Section heading'   'text' 'Plan'    ''),
  (New-Field 'materials'  'Materials'         'area' 'Plan'    ''),
  (New-Field 'secAct'     'Section heading'   'text' 'Plan'    ''),
  (New-Field 'activities' 'Activities'        'area' 'Plan'    ''),
  (New-Field 'secAss'     'Section heading'   'text' 'Plan'    ''),
  (New-Field 'assessment' 'Assessment'        'area' 'Plan'    '')
)

$FieldsTimetable = @(
  (New-Field 'school'  'School or class name' 'text' 'Header' ''),
  (New-Field 'meta'    'Class and term'       'text' 'Header' ''),
  (New-Field 'periods' 'Times'                'area' 'Grid'   'One per line - keep every column the same number of lines'),
  (New-Field 'mon'     'Monday'               'area' 'Grid'   ''),
  (New-Field 'tue'     'Tuesday'              'area' 'Grid'   ''),
  (New-Field 'wed'     'Wednesday'            'area' 'Grid'   ''),
  (New-Field 'thu'     'Thursday'             'area' 'Grid'   ''),
  (New-Field 'fri'     'Friday'               'area' 'Grid'   ''),
  (New-Field 'footer'  'Footer'               'text' 'Footer' '')
)

$FieldsReport = @(
  (New-Field 'school'   'School name'      'text' 'Header'  ''),
  (New-Field 'title'    'Document title'   'text' 'Header'  ''),
  (New-Field 'student'  'Student name'     'text' 'Student' ''),
  (New-Field 'cls'      'Class and roll no' 'text' 'Student' ''),
  (New-Field 'term'     'Term and year'    'text' 'Student' ''),
  (New-Field 'subjects' 'Subjects'         'area' 'Marks'   'One per line - keep all three columns the same number of lines'),
  (New-Field 'marks'    'Marks'            'area' 'Marks'   ''),
  (New-Field 'grades'   'Grades'           'area' 'Marks'   ''),
  (New-Field 'remarks'  'Remarks'          'area' 'Footer'  ''),
  (New-Field 'sign1'    'Signed by'        'text' 'Footer'  ''),
  (New-Field 'sign1role' 'Signatory title' 'text' 'Footer'  '')
)

$FieldsAttendance = @(
  (New-Field 'school' 'School name'    'text' 'Header' ''),
  (New-Field 'meta'   'Class and month' 'text' 'Header' ''),
  (New-Field 'names'  'Student names'  'area' 'Register' 'One per line - the grid draws a row for each'),
  (New-Field 'footer' 'Footer'         'text' 'Footer' '')
)

$FieldsFlashcard = @(
  (New-Field 'tag'        'Label'       'text' 'Card' 'Topic or set - leave empty to hide'),
  (New-Field 'title'      'Term'        'text' 'Card' 'The big word'),
  (New-Field 'pron'       'Pronunciation or hint' 'text' 'Card' 'Leave empty to hide'),
  (New-Field 'definition' 'Definition'  'area' 'Card' ''),
  (New-Field 'example'    'Example'     'text' 'Card' 'Leave empty to hide')
)

$FieldsIdCard = @(
  (New-Field 'school' 'School name'  'text' 'Card'    ''),
  (New-Field 'title'  'Student name' 'text' 'Card'    ''),
  (New-Field 'cls'    'Class'        'text' 'Details' ''),
  (New-Field 'roll'   'Roll number'  'text' 'Details' ''),
  (New-Field 'valid'  'Valid until'  'text' 'Details' ''),
  (New-Field 'contact' 'Contact'     'text' 'Details' 'Leave empty to hide')
)

$FieldsDiploma = @(
  (New-Field 'school'   'School or institution' 'text' 'Diploma'    ''),
  (New-Field 'award'    'Diploma title'         'text' 'Diploma'    ''),
  (New-Field 'pre'      'Line above the name'   'text' 'Diploma'    ''),
  (New-Field 'name'     'Student name'          'text' 'Diploma'    ''),
  (New-Field 'reason'   'Course and detail'     'area' 'Diploma'    ''),
  (New-Field 'date'     'Date'                  'text' 'Diploma'    ''),
  (New-Field 'sign1'    'Signature 1 - name'    'text' 'Signatures' ''),
  (New-Field 'sign1role' 'Signature 1 - title'  'text' 'Signatures' ''),
  (New-Field 'sign2'    'Signature 2 - name'    'text' 'Signatures' 'Leave empty to hide'),
  (New-Field 'sign2role' 'Signature 2 - title'  'text' 'Signatures' '')
)

# --- sample content -----------------------------------------------------------

$EBody = @{
  worksheet = @{
    title='Fractions: Adding and Subtracting'; meta='Mathematics &middot; Class 5'
    nameline='Name ______________________     Date ____________'
    instructions='Show your working for each question. Give answers in their simplest form.'
    items='1/4 + 2/4 =<br>3/8 + 1/8 =<br>5/6 - 2/6 =<br>2/3 + 1/6 =<br>7/10 - 1/5 =<br>1/2 + 1/3 =<br>Ayesha ate 3/8 of a cake and Bilal ate 2/8. How much is left?<br>Write 6/8 in its simplest form.'
    footer='Marigold Public School &middot; Term 2' }
  lesson = @{
    title='Introduction to Fractions'; meta='Mathematics &middot; Class 5'
    date='Monday, 14 March 2026'; duration='40 minutes'
    secObj='Learning objectives'
    objectives='Recognise a fraction as part of a whole.<br>Read and write fractions with denominators up to 10.<br>Compare two fractions with the same denominator.'
    secMat='Materials'
    materials='Paper circles for folding<br>Fraction wall poster<br>Worksheet - adding and subtracting fractions'
    secAct='Activities'
    activities='Starter (5 min): fold paper circles into halves and quarters.<br>Main (20 min): build the fraction wall together on the board.<br>Practice (10 min): worksheet in pairs.<br>Plenary (5 min): three quick questions on the board.'
    secAss='Assessment'
    assessment='Circulate during pair work and note who is still counting rather than reasoning. Collect worksheets.' }
  timetable = @{
    school='Marigold Public School'; meta='Class 5-B &middot; Term 2, 2026'
    periods='08:00 - 08:40<br>08:40 - 09:20<br>09:20 - 10:00<br>10:00 - 10:20<br>10:20 - 11:00<br>11:00 - 11:40<br>11:40 - 12:20'
    mon='Mathematics<br>English<br>Science<br>Break<br>Urdu<br>Islamiat<br>Games'
    tue='English<br>Mathematics<br>Urdu<br>Break<br>Science<br>Computer<br>Art'
    wed='Science<br>Urdu<br>Mathematics<br>Break<br>English<br>Social Studies<br>Library'
    thu='Mathematics<br>Science<br>English<br>Break<br>Computer<br>Urdu<br>Games'
    fri='Islamiat<br>English<br>Mathematics<br>Break<br>Social Studies<br>Assembly<br>-'
    footer='Timings subject to change &middot; Office: 042 1234567' }
  report = @{
    school='Marigold Public School'; title='Progress Report'
    student='Ayesha Sheikh'; cls='Class 5-B &middot; Roll no. 14'; term='Term 2, 2026'
    subjects='Mathematics<br>English<br>Urdu<br>Science<br>Social Studies<br>Islamiat<br>Computer'
    marks='84 / 100<br>78 / 100<br>91 / 100<br>72 / 100<br>80 / 100<br>88 / 100<br>95 / 100'
    grades='A<br>B+<br>A+<br>B<br>A-<br>A<br>A+'
    remarks='Ayesha has had a strong term, particularly in Urdu and Computer. Science would improve with more attention to written working rather than answers alone.'
    sign1='Nadia Rahman'; sign1role='Class Teacher' }
  attendance = @{
    school='Marigold Public School'; meta='Class 5-B &middot; March 2026'
    names='Ayesha Sheikh<br>Bilal Ahmed<br>Fatima Khan<br>Hamza Ali<br>Hania Malik<br>Imran Shah<br>Sara Mahmood<br>Usman Tariq<br>Zain Ali<br>Zara Ahmed<br>Amara Rafiq<br>Danish Iqbal'
    footer='P = present &middot; A = absent &middot; L = late &middot; H = holiday' }
  flashcard = @{
    tag='Biology &middot; Set 3'; title='Photosynthesis'
    pron='foh-toh-SIN-thuh-sis'
    definition='The process by which green plants use sunlight to turn water and carbon dioxide into food.'
    example='Leaves are wide and flat to catch as much light as possible.' }
  idcard = @{
    school='Marigold Public School'; title='Ayesha Sheikh'
    cls='Class 5-B'; roll='14'; valid='June 2027'; contact='042 1234567' }
  diploma = @{
    school='Marigold Public School'; award='Diploma of Completion'
    pre='This is to certify that'; name='Zain Ali'
    reason='has successfully completed the Secondary School Certificate<br>with distinction in Mathematics and Computer Science'
    date='14 June 2026'
    sign1='Dr Nadia Rahman'; sign1role='Principal'
    sign2='Imran Shah'; sign2role='Head of Examinations' }
}

# --- category -----------------------------------------------------------------

$ECategory = @{
  slug  = 'education-school'
  name  = 'Education &amp; School'
  short = 'Education'
  panel = 'Document types'
  blurb = 'The paperwork a classroom runs on - worksheets, plans, registers and reports.'
  h1    = 'Education and School Templates'
  title = 'School Templates - Free Editable Worksheets, Lesson Plans and Report Cards'
  desc  = 'Free editable school templates: worksheets, lesson plans, timetables, report cards, attendance registers, flashcards, student ID cards and diplomas. Fill them in and print.'
  intro = @(
    'Eight document types, thirty-two designs, all of them editable in the browser and built to print on ordinary school paper. Type into the boxes beside the page and it updates as you write.',
    'Everything here is set to A4 and prints cleanly in black and white, because most school printers are not colour and most schools are counting pages. The registers and timetables are laid out to be filled in by hand after printing, which is how they are actually used.'
  )
}

function New-Edu($slug, $name, $style, $design, $font, $art, $bg, $ink, $accent, $soft, $body,
                 $bgstyle = 'bg-plain', $foil = $false) {
  @{ slug=$slug; name=$name; style=$style; design=$design; font=$font; art=$art
     bg=$bg; ink=$ink; accent=$accent; soft=$soft; body=$body; bgstyle=$bgstyle; foil=$foil }
}

$ESubcats = @(

 @{ slug='worksheet-templates'; name='Worksheet Templates'; nav='Worksheets'
    kind='worksheet'; size='sz-a4'; fields=$FieldsWorksheet
    h1='Worksheet Templates'
    title='Worksheet Template - Free Editable Blank Worksheets to Print'
    desc='Free editable worksheet templates for any subject. Type your own questions, print in black and white, and use the same layout every week.'
    intro=@(
      'A worksheet has one job that most designs get wrong: leaving enough room to answer in. These four give every question working space and keep the header to a single line, so a page of eight questions stays a page rather than becoming two.',
      'Type one question per line and each one gets a ruled answer space beneath it. All four print cleanly in black and white, which is what most school printers are set to.')
    faq=@(
      @('How much space should a worksheet leave for answers?','Roughly twice the height of the question for written work, and a full ruled line per step for maths. Running out of room is the commonest reason a child writes an answer without the working.'),
      @('Should worksheets be printed in colour?','No need. These are designed so the accent colour carries information nowhere - print them in black and white and nothing is lost.'),
      @('Can I reuse the same worksheet layout each week?','That is the point of them. Keep the header and instructions, change the questions, and children stop spending the first two minutes working out what the page wants.'))
    templates=@(
      (New-Edu 'ruled-lines' 'Ruled Lines' 'Simple &middot; answer lines' 's-plain' 'f-tenor' '' '#ffffff' '#1d2228' '#2f4858' '#57606a' $EBody.worksheet),
      (New-Edu 'boxed-questions' 'Boxed Questions' 'Modern &middot; boxed items' 's-boxed' 'f-josefin' '' '#ffffff' '#1b2430' '#2e5d4b' '#59636e' $EBody.worksheet),
      (New-Edu 'header-band-ws' 'Header Band' 'Filled &middot; coloured header' 's-band' 'f-tenor' '' '#ffffff' '#20262c' '#b4472e' '#5c666d' $EBody.worksheet),
      (New-Edu 'friendly-round' 'Friendly Round' 'Filled &middot; soft panels' 's-panel' 'f-josefin' '' '#fdfbf6' '#33302a' '#c98a2e' '#6b6558' $EBody.worksheet 'bg-grad')) },

 @{ slug='lesson-plan-templates'; name='Lesson Plan Templates'; nav='Lesson Plans'
    kind='lesson'; size='sz-a4'; fields=$FieldsLesson
    h1='Lesson Plan Templates'
    title='Lesson Plan Template - Free Editable Weekly and Daily Plans'
    desc='Free editable lesson plan templates with objectives, materials, activities and assessment. Fill them in online and print for your file.'
    intro=@(
      'A lesson plan is written for two readers: you at eight in the morning, and whoever inspects the file in six months. These four keep the objectives and the timings visible at a glance, which serves the first reader, and carry the sections a file check expects.',
      'Timings live in the activities block rather than in a separate column, because that is where they are read from. Any section you leave empty disappears instead of leaving a gap.')
    faq=@(
      @('What should a lesson plan include?','Objectives written as what children will be able to do, the materials you need to have ready, the activities with timings, and how you will know whether it worked. Everything else is optional.'),
      @('How detailed should objectives be?','Specific enough to check. "Understand fractions" cannot be assessed; "compare two fractions with the same denominator" can be, in one question at the end.'),
      @('Daily or weekly plans?','Weekly for the overview, daily for anything you are teaching for the first time. These are daily plans - print five for a week.'))
    templates=@(
      (New-Edu 'clear-plan' 'Clear Plan' 'Simple &middot; stacked sections' 's-plain' 'f-tenor' '' '#ffffff' '#1d2228' '#2f4858' '#57606a' $EBody.lesson),
      (New-Edu 'label-column' 'Label Column' 'Modern &middot; headings in a side column' 's-grid' 'f-josefin' '' '#ffffff' '#1b2430' '#22394f' '#59636e' $EBody.lesson),
      (New-Edu 'header-band-lp' 'Header Band' 'Filled &middot; coloured header' 's-band' 'f-tenor' '' '#ffffff' '#1f2a23' '#2e5d4b' '#5a6660' $EBody.lesson),
      (New-Edu 'panelled-plan' 'Panelled Plan' 'Filled &middot; tinted sections' 's-panel' 'f-libre' '' '#fdfcf9' '#241f1b' '#8a6a3b' '#5f5850' $EBody.lesson 'bg-grad')) },

 @{ slug='timetable-templates'; name='Timetable Templates'; nav='Timetables'
    kind='timetable'; size='sz-a4'; fields=$FieldsTimetable
    h1='Class Timetable Templates'
    title='Timetable Template - Free Editable Class Schedule to Print'
    desc='Free editable class timetable templates for schools and students. Type your periods and subjects, then print for the wall or the front of a file.'
    intro=@(
      'A timetable is read in a hurry by someone who is already late, so the useful ones are the ones you can scan down a column. These four keep the day columns even and the times in their own column at the left.',
      'Type one period per line in each column. Keep the number of lines the same in every day and the rows line up on their own - which is also how a timetable behaves when a day has a free period, so write a dash rather than leaving the line out.')
    faq=@(
      @('What size should a class timetable be printed at?','A4 for a file or a noticeboard, A3 if it is going on a classroom wall where children read it from their desks.'),
      @('How do I show breaks and free periods?','Type them as a period like any other - "Break" or a dash. Leaving the line out shifts everything below it up and the columns stop lining up.'),
      @('Can I use this for a personal study timetable?','Yes. Replace the day columns with your own headings and the times with study blocks; nothing in the layout assumes a school.'))
    templates=@(
      (New-Edu 'clean-grid' 'Clean Grid' 'Simple &middot; ruled columns' 's-plain' 'f-tenor' '' '#ffffff' '#1d2228' '#2f4858' '#57606a' $EBody.timetable),
      (New-Edu 'banded-rows' 'Banded Rows' 'Modern &middot; alternating rows' 's-boxed' 'f-josefin' '' '#ffffff' '#1b2430' '#22394f' '#59636e' $EBody.timetable),
      (New-Edu 'header-band-tt' 'Header Band' 'Filled &middot; coloured header' 's-band' 'f-tenor' '' '#ffffff' '#1f2a23' '#2e5d4b' '#5a6660' $EBody.timetable),
      (New-Edu 'warm-grid' 'Warm Grid' 'Filled &middot; tinted columns' 's-panel' 'f-josefin' '' '#fdfbf6' '#33302a' '#c98a2e' '#6b6558' $EBody.timetable 'bg-grad')) },

 @{ slug='report-card-templates'; name='Report Card Templates'; nav='Report Cards'
    kind='report'; size='sz-a4'; fields=$FieldsReport
    h1='Report Card Templates'
    title='Report Card Template - Free Editable Student Progress Reports'
    desc='Free editable report card and progress report templates for schools. Enter subjects, marks and remarks, then print or save as PDF.'
    intro=@(
      'A report card is read by a parent in about a minute, and the part they remember is the remark rather than the marks. These four give the remark real space instead of a two-line box at the bottom.',
      'Subjects, marks and grades are three columns you fill separately - keep the same number of lines in each and the rows align. Any subject you leave out simply is not there.')
    faq=@(
      @('What goes on a report card?','The student and class, the term, a subject-by-subject record, an overall remark, and a signature. Attendance is often added, and belongs beside the term rather than in the subject table.'),
      @('How should remarks be written?','Name one strength and one specific thing to work on, in plain language a parent can act on. "Needs to improve" tells a family nothing they can help with.'),
      @('Can these be used for a homeschool record?','Yes. Replace the school name with your own heading; nothing in the layout requires an institution.'))
    templates=@(
      (New-Edu 'plain-report' 'Plain Report' 'Simple &middot; ruled table' 's-plain' 'f-tenor' '' '#ffffff' '#1d2228' '#2f4858' '#57606a' $EBody.report),
      (New-Edu 'banded-report' 'Banded Report' 'Modern &middot; alternating rows' 's-boxed' 'f-josefin' '' '#ffffff' '#1b2430' '#22394f' '#59636e' $EBody.report),
      (New-Edu 'crest-report' 'Crest Report' 'Filled &middot; coloured header' 's-band' 'f-libre' '' '#ffffff' '#1f2a23' '#2e5d4b' '#5a6660' $EBody.report),
      (New-Edu 'formal-report' 'Formal Report' 'Filled &middot; framed and serif' 's-formal' 'f-cormorant' 'vine' '#fdfcf9' '#241f1b' '#8a6a3b' '#5f5850' $EBody.report 'bg-grad')) },

 @{ slug='attendance-sheet-templates'; name='Attendance Sheet Templates'; nav='Attendance Sheets'
    kind='attendance'; size='sz-a4'; fields=$FieldsAttendance
    h1='Attendance Sheet Templates'
    title='Attendance Sheet Template - Free Printable Class Register'
    desc='Free printable attendance register templates with a month of columns. Type your class list, print, and tick by hand.'
    intro=@(
      'An attendance register is filled in by hand at nine in the morning, so what matters is the row height and whether the columns are wide enough to tick without hitting the neighbouring day. These four are set for a pen rather than a keyboard.',
      'Type your class list one name per line and the grid draws a row for each. Thirty-one day columns are ruled across, with the key at the foot.')
    faq=@(
      @('How many names fit on one sheet?','Around twenty-five at a comfortable row height. Past that the rows tighten enough that ticking becomes awkward, so print a second sheet rather than squeezing.'),
      @('Should I use one sheet per month?','Yes - a month per sheet is what makes the totals meaningful and keeps the columns wide enough to write in. The month goes in the header line.'),
      @('What do the letters at the bottom mean?','They are yours to set. The footer line is editable, so use whatever marking your school already uses rather than adopting ours.'))
    templates=@(
      (New-Edu 'plain-register' 'Plain Register' 'Simple &middot; ruled grid' 's-plain' 'f-tenor' '' '#ffffff' '#1d2228' '#2f4858' '#57606a' $EBody.attendance),
      (New-Edu 'banded-register' 'Banded Register' 'Modern &middot; alternating rows' 's-boxed' 'f-josefin' '' '#ffffff' '#1b2430' '#22394f' '#59636e' $EBody.attendance),
      (New-Edu 'header-band-at' 'Header Band' 'Filled &middot; coloured header' 's-band' 'f-tenor' '' '#ffffff' '#1f2a23' '#2e5d4b' '#5a6660' $EBody.attendance),
      (New-Edu 'warm-register' 'Warm Register' 'Filled &middot; tinted header' 's-panel' 'f-josefin' '' '#fdfbf6' '#33302a' '#b4722e' '#6b6558' $EBody.attendance 'bg-grad')) },

 @{ slug='flashcard-templates'; name='Flashcard Templates'; nav='Flashcards'
    kind='flashcard'; size='sz-flash'; sizeset='flash'; fields=$FieldsFlashcard
    ornaments=$true
    h1='Flashcard Templates'
    title='Flashcard Template - Free Printable Study Cards You Can Edit'
    desc='Free editable flashcard templates for vocabulary, definitions and revision. Type the term and definition, then print and cut.'
    intro=@(
      'A flashcard works by being answerable in about two seconds, which means one idea per card and a term large enough to read across a desk. These four keep the definition short and the term dominant.',
      'They print four to an A4 sheet at the standard size, or singly at the larger one. Cut along the outer edge and the margin is already allowed for.')
    faq=@(
      @('What should go on a flashcard?','One term and one definition. The moment a card carries two ideas you cannot tell which one you failed to recall, and the card stops teaching you anything.'),
      @('How large should the term be?','Large enough to read at arm''s length without leaning in - roughly three times the size of the definition, which is how these are set.'),
      @('Should I write the answer on the back?','If you are printing double-sided, yes. If not, the definition sits under the term and you cover it with a hand, which works just as well for most revision.'))
    templates=@(
      (New-Edu 'plain-card' 'Plain Card' 'Simple &middot; term and rule' 'fc-plain' 'f-tenor' '' '#ffffff' '#1d2228' '#2f4858' '#57606a' $EBody.flashcard),
      (New-Edu 'label-card' 'Label Card' 'Modern &middot; corner label' 'fc-label' 'f-josefin' '' '#ffffff' '#1b2430' '#c1543f' '#59636e' $EBody.flashcard),
      (New-Edu 'tinted-card' 'Tinted Card' 'Filled &middot; tinted panel' 'fc-panel' 'f-libre' '' '#fdfbf6' '#33302a' '#2e7d5a' '#6b6558' $EBody.flashcard 'bg-grad'),
      (New-Edu 'bordered-card' 'Bordered Card' 'Filled &middot; framed' 'fc-bordered' 'f-cormorant' 'geometric' '#fdfcf9' '#241f1b' '#8a6a3b' '#5f5850' $EBody.flashcard)) },

 @{ slug='student-id-card-templates'; name='Student ID Card Templates'; nav='Student ID Cards'
    kind='idcard'; size='sz-idcard'; sizeset='idcard'; fields=$FieldsIdCard
    ornaments=$true
    h1='Student ID Card Templates'
    title='Student ID Card Template - Free Editable School ID Designs'
    desc='Free editable student ID card templates at standard card size. Add the school name, student details and print for lamination.'
    intro=@(
      'A student card is checked at a gate by someone glancing at it for a second, so the name and the class have to be the two things that read first. These four put them there and keep the rest small.',
      'They are set at the standard 85 by 54mm card size, with a portrait option for lanyards. A space is left for a photograph to be attached after printing, which is how most schools do it.')
    faq=@(
      @('What size is a student ID card?','85 by 54mm - the same as a bank card, so it fits standard holders and laminating pouches. A portrait version for lanyards is in the editor.'),
      @('Should the card carry a photograph?','Most schools attach one after printing rather than printing it in, which is what the space on these is for. It also means one printed batch works for a whole class.'),
      @('What details should not go on a student card?','A home address, a date of birth, or a parent''s phone number. A card that is lost should not tell a stranger where a child lives - the school''s own number is the safe contact.'))
    templates=@(
      (New-Edu 'plain-id' 'Plain ID' 'Simple &middot; name first' 'id-plain' 'f-tenor' '' '#ffffff' '#1d2228' '#2f4858' '#57606a' $EBody.idcard),
      (New-Edu 'band-id' 'Band ID' 'Modern &middot; coloured band' 'id-band' 'f-josefin' '' '#ffffff' '#1b2430' '#22394f' '#59636e' $EBody.idcard),
      (New-Edu 'crest-id' 'Crest ID' 'Filled &middot; school crest bar' 'id-crest' 'f-libre' '' '#ffffff' '#1f2a23' '#2e5d4b' '#5a6660' $EBody.idcard 'bg-grad'),
      (New-Edu 'formal-id' 'Formal ID' 'Filled &middot; framed' 'id-formal' 'f-cormorant' 'geometric' '#16241d' '#f1ece0' '#c9a227' '#c2c8ba' $EBody.idcard 'bg-edge' $true)) },

 @{ slug='diploma-templates'; name='Diploma Templates'; nav='Diplomas'
    kind='diploma'; size='sz-cert'; sizeset='cert'; fields=$FieldsDiploma
    ornaments=$true
    h1='Diploma Templates'
    title='Diploma Template - Free Printable Graduation Diploma Designs'
    desc='Free printable diploma templates for schools and colleges. Add the institution, student name and course, then print at A4 landscape.'
    intro=@(
      'A diploma is framed and kept, which is the whole design brief: the institution at the top, the name large in the middle, and enough space around both that it does not look crowded behind glass.',
      'These are landscape A4, the size that fits ready-made frames. If you want an award or completion certificate rather than a diploma, the certificate designs in Business &amp; Office cover that - they are shorter on institutional detail and quicker to fill in.')
    faq=@(
      @('What is the difference between a diploma and a certificate?','A diploma records completion of a course of study and names the institution awarding it. A certificate marks an achievement, an award, or attendance - shorter, and usually issued in greater numbers.'),
      @('What should a diploma say?','The institution, the award, the recipient, what was completed, the date, and at least one signature with a title. Anything more and the type has to shrink.'),
      @('What should it be printed on?','200gsm or heavier, matt. Anything lighter buckles in a frame, and gloss shows every fingerprint from the day it is handed over.'))
    templates=@(
      (New-Edu 'plain-diploma' 'Plain Diploma' 'Simple &middot; ruled and centred' 'c-modern' 'f-libre' '' '#ffffff' '#1d2228' '#2f4858' '#57606a' $EBody.diploma),
      (New-Edu 'classic-diploma' 'Classic Diploma' 'Modern &middot; geometric border' 'c-classic' 'f-josefin' 'geometric' '#ffffff' '#1b2430' '#22394f' '#59636e' $EBody.diploma 'bg-grad'),
      (New-Edu 'laurel-diploma' 'Laurel Diploma' 'Filled &middot; laurel and foil' 'c-classic' 'f-cinzel' 'laurel' '#f8f8f5' '#16233d' '#b08a3e' '#565f70' $EBody.diploma 'bg-grad' $true),
      (New-Edu 'deco-diploma' 'Deco Diploma' 'Filled &middot; art deco and foil' 'c-classic' 'f-cinzel-dec' 'deco' '#fdfaf3' '#2c2a24' '#a8823f' '#5f5b50' $EBody.diploma 'bg-edge' $true)) }
)

# --- guides -------------------------------------------------------------------

$EGuides = @(
 @{ slug='how-to-make-a-worksheet'
    title='How to Make a Worksheet Children Can Actually Finish'
    h1='How to Make a Worksheet'
    desc='How much answer space to leave, how many questions to set, and the layout mistakes that make a worksheet take twice as long.'
    read='6 min read'
    body=@(
      @('p','Most worksheets are set by someone who already knows the answers, which is why so many of them leave three lines for a question that needs eight. Here is what changes when you design for the child holding the pen.'),
      @('h2','Answer space is the whole design'),
      @('p','The single most common fault is too little room. For written answers, leave about twice the height of the question. For maths, leave a full line per step you expect - a child who has nowhere to put the working will write the answer alone, and you lose the only thing that would have told you where they went wrong.'),
      @('h2','How many questions'),
      @('p','Six to ten for a forty minute lesson, including one that is harder than the rest. A page of twenty questions is not more practice - it is a page most of the class will not finish, which teaches them that finishing is not expected.'),
      @('h2','Put the instruction where it is read'),
      @('p','At the top, in one sentence, in the same size as the questions. Instructions set small are not read; instructions set in a box at the bottom are read after the child has already done it their own way.'),
      @('h2','One layout, every week'),
      @('p','Keep the header, the instruction position and the numbering identical from week to week. The first two minutes of every worksheet are spent working out what the page wants, and a familiar layout gives those two minutes back.'),
      @('h2','Print in black and white'),
      @('p','Assume it. If colour carries meaning - a key, a highlighted row - the worksheet fails the moment it goes through a mono printer, which in most schools it will. These templates use colour for decoration only, so nothing is lost.'),
      @('h2','Leave a name line'),
      @('p','Obvious, and still the most common omission. Name and date on one line at the top, with enough room for a child''s handwriting rather than an adult''s.'),
      @('cta','worksheet-templates')) },

 @{ slug='what-to-write-in-a-report-card'
    title='What to Write in a Report Card Comment'
    h1='Writing Report Card Comments'
    desc='How to write remarks parents can act on, phrases that say nothing, and how to raise a problem without damaging the child.'
    read='6 min read'
    body=@(
      @('p','Parents read the comment before the marks, and remember it long after. It is also the part teachers write thirty of on a Sunday evening, which is how the phrases that say nothing come to exist.'),
      @('h2','The shape that works'),
      @('ol',@(
        '<strong>One specific strength.</strong> Not "a pleasure to teach" - something you actually saw. "Ayesha explained her method to the group without being asked."',
        '<strong>One thing to work on, described as an action.</strong> "Would benefit from writing the working out before the answer" can be helped with at home. "Needs to try harder" cannot.',
        '<strong>One sentence looking forward.</strong> Short. This is where the tone is set.')),
      @('h2','Phrases to avoid'),
      @('ul',@(
        '<strong>"Satisfactory."</strong> Says nothing, and reads as disappointment.',
        '<strong>"Could do better."</strong> True of everyone alive, actionable by nobody.',
        '<strong>"Lacks confidence."</strong> A description of a symptom, not something a parent can work with. Say what happens instead: "hesitates to answer aloud, though her written work is strong."',
        '<strong>"Chatty."</strong> A complaint about your lesson dressed as a comment about the child.')),
      @('h2','Raising a real problem'),
      @('p','Name the behaviour, not the character. "Hamza has been late to four lessons this term" is a fact a family can address; "Hamza is lazy" is a judgement they will defend against, and the conversation ends there. Where the issue is serious, the report is the wrong place to break the news - it should already have been said in person.'),
      @('h2','Length'),
      @('p','Three or four sentences. A long comment is read as a warning sign regardless of what it says, and a short specific one is read twice.'),
      @('h2','Write them in one sitting, but not in one voice'),
      @('p','The efficiency of doing thirty at once is real; the risk is that they start sounding identical. Read three in a row aloud - if you cannot tell the children apart from the comments, none of them are specific enough yet.'),
      @('cta','report-card-templates')) }
)
