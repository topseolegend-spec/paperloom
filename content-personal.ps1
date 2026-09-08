# =============================================================================
#  Personal &amp; Lifestyle category
#  Subcategories search volume ke hisaab se tarteeb mein hain.
#
#  Paanch mein grid chahiye - wahi "har column ek field, line-height ek" wala
#  tareeqa jo timetable aur attendance mein bana tha.
#
#  Calendar iss se alag hai: uske din ke numbers likhe nahi jate, month aur year
#  se nikaale jate hain. Wo kaam editor.js karta hai - dekhein calendar section.
#
#  ZAROORI: is file mein Urdu/Arabic text seedha na likhein - HTML entities.
# =============================================================================

$FieldsCalendar = @(
  (New-Field 'title' 'Heading'   'text' 'Calendar' 'Leave empty to hide'),
  (New-Field 'month' 'Month'     'text' 'Calendar' 'January, February...'),
  (New-Field 'year'  'Year'      'text' 'Calendar' ''),
  (New-Field 'note'  'Note'      'area' 'Footer'   'Leave empty to hide')
)

$FieldsPlanner = @(
  (New-Field 'title'      'Heading'        'text' 'Header'   ''),
  (New-Field 'meta'       'Date line'      'text' 'Header'   ''),
  (New-Field 'secTop'     'Section heading' 'text' 'Priorities' ''),
  (New-Field 'top'        'Top priorities' 'area' 'Priorities' 'One per line'),
  (New-Field 'secPlan'    'Section heading' 'text' 'Schedule' ''),
  (New-Field 'times'      'Times'          'area' 'Schedule' 'One per line - keep both columns the same number of lines'),
  (New-Field 'slots'      'What is on'     'area' 'Schedule' ''),
  (New-Field 'secNotes'   'Section heading' 'text' 'Notes'    ''),
  (New-Field 'notes'      'Notes'          'area' 'Notes'    '')
)

$FieldsTodo = @(
  (New-Field 'title'  'Heading'   'text' 'Header' ''),
  (New-Field 'meta'   'Date line' 'text' 'Header' 'Leave empty to hide'),
  (New-Field 'items'  'Tasks'     'area' 'List'   'One per line - each gets a tick box'),
  (New-Field 'footer' 'Footer'    'text' 'Footer' 'Leave empty to hide')
)

$FieldsBudget = @(
  (New-Field 'title'      'Heading'         'text' 'Header'  ''),
  (New-Field 'meta'       'Month'           'text' 'Header'  ''),
  (New-Field 'secIn'      'Section heading' 'text' 'Income'  ''),
  (New-Field 'inNames'    'Income sources'  'area' 'Income'  'One per line - keep both columns the same number of lines'),
  (New-Field 'inAmounts'  'Amounts'         'area' 'Income'  ''),
  (New-Field 'secOut'     'Section heading' 'text' 'Spending' ''),
  (New-Field 'outNames'   'Spending'        'area' 'Spending' ''),
  (New-Field 'outAmounts' 'Amounts'         'area' 'Spending' ''),
  (New-Field 'totalLabel' 'Total label'     'text' 'Total'   ''),
  (New-Field 'total'      'Left over'       'text' 'Total'   ''),
  (New-Field 'notes'      'Notes'           'area' 'Total'   'Leave empty to hide')
)

$FieldsRecipe = @(
  (New-Field 'title'       'Recipe name'  'text' 'Header'  ''),
  (New-Field 'meta'        'Serves and time' 'text' 'Header' ''),
  (New-Field 'secIng'      'Section heading' 'text' 'Recipe' ''),
  (New-Field 'ingredients' 'Ingredients'  'area' 'Recipe'  'One per line'),
  (New-Field 'secMethod'   'Section heading' 'text' 'Recipe' ''),
  (New-Field 'method'      'Method'       'area' 'Recipe'  'One step per line'),
  (New-Field 'note'        'Note'         'text' 'Footer'  'Leave empty to hide')
)

$FieldsVoucher = @(
  (New-Field 'business' 'Business name' 'text' 'Voucher' ''),
  (New-Field 'title'    'Heading'       'text' 'Voucher' ''),
  (New-Field 'value'    'Value'         'text' 'Voucher' 'The big number'),
  (New-Field 'to'       'To'            'text' 'Details' ''),
  (New-Field 'from'     'From'          'text' 'Details' ''),
  (New-Field 'code'     'Code'          'text' 'Details' 'Leave empty to hide'),
  (New-Field 'expiry'   'Valid until'   'text' 'Details' ''),
  (New-Field 'terms'    'Terms'         'text' 'Footer'  'Leave empty to hide')
)

$FieldsHabit = @(
  (New-Field 'title'  'Heading'  'text' 'Header'  ''),
  (New-Field 'meta'   'Month'    'text' 'Header'  ''),
  (New-Field 'habits' 'Habits'   'area' 'Tracker' 'One per line - the grid draws a row for each'),
  (New-Field 'footer' 'Footer'   'text' 'Footer'  'Leave empty to hide')
)

$FieldsMeal = @(
  (New-Field 'title'  'Heading'      'text' 'Header' ''),
  (New-Field 'meta'   'Week'         'text' 'Header' ''),
  (New-Field 'meals'  'Meal names'   'area' 'Grid'   'One per line - keep every column the same number of lines'),
  (New-Field 'mon'    'Monday'       'area' 'Grid'   ''),
  (New-Field 'tue'    'Tuesday'      'area' 'Grid'   ''),
  (New-Field 'wed'    'Wednesday'    'area' 'Grid'   ''),
  (New-Field 'thu'    'Thursday'     'area' 'Grid'   ''),
  (New-Field 'fri'    'Friday'       'area' 'Grid'   ''),
  (New-Field 'sat'    'Saturday'     'area' 'Grid'   ''),
  (New-Field 'sun'    'Sunday'       'area' 'Grid'   ''),
  (New-Field 'list'   'Shopping list' 'area' 'Footer' 'Leave empty to hide')
)

# --- sample content -----------------------------------------------------------

$PBody = @{
  calendar = @{ title='Marigold House'; month='March'; year='2027'
    note='Bin day Tuesday &middot; Rent due on the 1st' }
  planner = @{
    title='Daily Plan'; meta='Monday, 15 March 2027'
    secTop='Top three'
    top='Finish the payments write-up<br>Call the printer about the flyers<br>Walk before it gets dark'
    secPlan='The day'
    times='07:00<br>09:00<br>11:00<br>13:00<br>15:00<br>17:00<br>19:00'
    slots='Breakfast and reading<br>Deep work - payments doc<br>Standup, then email<br>Lunch, out of the house<br>Calls<br>Errands and printer<br>Dinner'
    secNotes='Notes'
    notes='Ask Sara whether the venue needs the final count this week.' }
  todo = @{
    title='Things To Do'; meta='Week of 15 March'
    items='Renew the passport<br>Pay the electricity bill<br>Book the car service<br>Reply to Hania about Saturday<br>Order more coffee<br>Take the winter coats to the cleaners<br>Water the plants on the balcony<br>Find the warranty for the heater'
    footer='Anything left goes to next week - that is allowed' }
  budget = @{
    title='Monthly Budget'; meta='March 2027'
    secIn='Money in'
    inNames='Salary<br>Freelance work<br>Rent from the flat'
    inAmounts='180,000<br>45,000<br>35,000'
    secOut='Money out'
    outNames='Rent<br>Utilities<br>Groceries<br>Transport<br>School fees<br>Savings<br>Everything else'
    outAmounts='60,000<br>18,000<br>42,000<br>12,000<br>30,000<br>40,000<br>25,000'
    totalLabel='Left over'; total='33,000'
    notes='Savings goes out first, on the day the salary lands - not whatever is left at the end.' }
  recipe = @{
    title='Cardamom Kheer'; meta='Serves 6 &middot; 1 hour 20 minutes'
    secIng='Ingredients'
    ingredients='1 litre full-fat milk<br>60g basmati rice, rinsed<br>90g sugar<br>6 green cardamom pods, crushed<br>A handful of pistachios, slivered<br>A pinch of saffron (optional)'
    secMethod='Method'
    method='Soak the rice in cold water for 20 minutes, then drain.<br>Bring the milk to a gentle boil in a heavy pan, stirring so it does not catch.<br>Add the rice and cardamom. Simmer on low for 45 minutes, stirring every few minutes.<br>When the rice has broken down and the milk has thickened, add the sugar.<br>Cook for another 10 minutes, then take off the heat.<br>Cool, then chill. Scatter the pistachios just before serving.'
    note='It thickens further in the fridge - take it off the heat looser than you want it.' }
  voucher = @{
    business='Meridian Coffee'; title='Gift Voucher'; value='PKR 2,000'
    to='For Ayesha'; from='From Sara'; code='MC-2027-0184'; expiry='31 December 2027'
    terms='Redeemable in store &middot; No cash value &middot; One per visit' }
  habit = @{
    title='Habit Tracker'; meta='March 2027'
    habits='Walk 30 minutes<br>Read before bed<br>No phone before 9am<br>Water - 8 glasses<br>Stretch<br>Write something<br>In bed by 11'
    footer='Fill the box on the days you managed it' }
  meal = @{
    title='Meals This Week'; meta='15 - 21 March 2027'
    meals='Breakfast<br>Lunch<br>Dinner'
    mon='Porridge<br>Leftover daal<br>Chicken karahi'
    tue='Eggs and toast<br>Sandwiches<br>Vegetable pulao'
    wed='Porridge<br>Soup<br>Fish, rice, salad'
    thu='Yoghurt and fruit<br>Leftover pulao<br>Chana with roti'
    fri='Parathas<br>Out<br>Biryani'
    sat='Eggs<br>Sandwiches<br>Pasta'
    sun='Halwa puri<br>Late lunch at Ammi''s<br>Soup and bread'
    list='Milk, eggs, chicken, river fish, chana, yoghurt, spinach, tomatoes, coriander, rice' }
}

# --- category -----------------------------------------------------------------

$PCategory = @{
  slug  = 'personal-lifestyle'
  name  = 'Personal &amp; Lifestyle'
  short = 'Personal'
  panel = 'Document types'
  blurb = 'Calendars, planners and trackers for the paperwork of an ordinary week.'
  h1    = 'Personal and Lifestyle Templates'
  title = 'Printable Planner Templates - Free Calendars, Budgets and Trackers'
  desc  = 'Free editable calendars, daily planners, to-do lists, budget sheets, recipe cards, gift vouchers, habit trackers and meal planners. Fill them in and print.'
  intro = @(
    'Eight things worth printing rather than keeping in an app, and thirty-two designs across them. Type into the boxes beside the page and it updates as you write.',
    'Most of these are meant to be filled in by hand after printing, so the rows are set for a pen: tick boxes big enough to tick, ruled lines you can write on, and nothing that depends on colour to be readable.'
  )
}

function New-Personal($slug, $name, $style, $design, $font, $art, $bg, $ink, $accent, $soft, $body,
                      $bgstyle = 'bg-plain', $foil = $false) {
  @{ slug=$slug; name=$name; style=$style; design=$design; font=$font; art=$art
     bg=$bg; ink=$ink; accent=$accent; soft=$soft; body=$body; bgstyle=$bgstyle; foil=$foil }
}

$PSubcats = @(

 @{ slug='calendar-templates'; name='Calendar Templates'; nav='Calendars'
    kind='calendar'; size='sz-a4'; fields=$FieldsCalendar
    h1='Calendar Templates'
    title='Calendar Template - Free Printable Monthly Calendars You Can Edit'
    desc='Free printable monthly calendar templates. Type the month and year and the dates fill themselves in, then print for the wall or a planner.'
    intro=@(
      'Type a month and a year and the dates work themselves out - the grid knows which weekday the first falls on and how many days the month has, including February in a leap year. You are not filling in thirty-one numbers by hand.',
      'Four looks, from a plain wall calendar to one with room for notes under each week. All print at A4, portrait or landscape.')
    faq=@(
      @('How do I change the month?','Type the month name and the year into the boxes and the grid redraws itself. Any month of any year works, and leap years are handled.'),
      @('Can I print a whole year?','Print one month at a time, changing the month box between prints. Twelve prints is a year, and it takes about two minutes.'),
      @('Which day does the week start on?','Monday, which is standard in Pakistan, Europe and most of the world. If you need a Sunday start, say so and we will add the option.'))
    templates=@(
      (New-Personal 'plain-month' 'Plain Month' 'Simple &middot; ruled grid' 'cal-plain' 'f-tenor' '' '#ffffff' '#1d2228' '#2f4858' '#57606a' $PBody.calendar),
      (New-Personal 'bold-month' 'Bold Month' 'Modern &middot; big month, banded rows' 'cal-bold' 'f-josefin' '' '#ffffff' '#161a20' '#c1543f' '#5a6470' $PBody.calendar),
      (New-Personal 'warm-month' 'Warm Month' 'Filled &middot; tinted weekends' 'cal-warm' 'f-marcellus' '' '#fdfbf6' '#33302a' '#b4722e' '#6b6558' $PBody.calendar 'bg-grad'),
      (New-Personal 'garden-month' 'Garden Month' 'Filled &middot; sprigs and serif' 'cal-warm' 'f-cormorant' 'botanical' '#f7faf6' '#25361f' '#5b7f4a' '#5c6a54' $PBody.calendar 'bg-grad')) },

 @{ slug='planner-templates'; name='Planner Templates'; nav='Planners'
    kind='planner'; size='sz-a4'; fields=$FieldsPlanner
    h1='Daily Planner Templates'
    title='Daily Planner Template - Free Printable Planners You Can Edit'
    desc='Free printable daily planner templates with priorities, an hourly schedule and notes. Fill them in online or print blank.'
    intro=@(
      'A planner earns its place by making you choose. These four put three priorities at the top - not ten - and give the rest of the day an hourly column beside them, because a list without times is a wish list.',
      'Fill it in here and print it done, or print it blank and write by hand. The hours are yours to change; a day that starts at seven and one that starts at eleven are both just lines in a box.')
    faq=@(
      @('Why only three priorities?','Because a day rarely has more. A list of ten leaves you at the end of it having done the easy six, and the planner has taught you nothing.'),
      @('Can I use this as a weekly planner?','Change the date line to a week and use the hours column for days instead. The layout does not care what the left column holds.'),
      @('Should I print it blank or filled in?','Blank if you plan in the morning with a pen, filled in if you plan the night before at a keyboard. Both work; doing neither is what does not.'))
    templates=@(
      (New-Personal 'clear-day' 'Clear Day' 'Simple &middot; ruled columns' 'pl-plain' 'f-tenor' '' '#ffffff' '#1d2228' '#2f4858' '#57606a' $PBody.planner),
      (New-Personal 'focus-blocks' 'Focus Blocks' 'Modern &middot; banded hours' 'pl-boxed' 'f-josefin' '' '#ffffff' '#1b2430' '#22394f' '#59636e' $PBody.planner),
      (New-Personal 'calm-panel' 'Calm Panel' 'Filled &middot; tinted sections' 'pl-panel' 'f-libre' '' '#fbfbf8' '#2a2c26' '#5b7f4a' '#5f6358' $PBody.planner 'bg-grad'),
      (New-Personal 'warm-day' 'Warm Day' 'Filled &middot; header band' 'pl-band' 'f-marcellus' '' '#fdfbf6' '#33302a' '#b4722e' '#6b6558' $PBody.planner)) },

 @{ slug='to-do-list-templates'; name='To-Do List Templates'; nav='To-Do Lists'
    kind='todo'; size='sz-a4'; fields=$FieldsTodo
    h1='To-Do List Templates'
    title='To Do List Template - Free Printable Checklists You Can Edit'
    desc='Free printable to-do list and checklist templates with tick boxes. Type your tasks or print blank and write them in.'
    intro=@(
      'The tick box is the whole point, so these give it room: a box big enough to tick with a real pen, and a line long enough to write a task that is not one word.',
      'Type your tasks one per line and each gets its own box, or leave the list empty and print a blank sheet of ruled boxes to fill in by hand.')
    faq=@(
      @('How many tasks should a list have?','Enough that finishing is possible. A list of thirty is a record of everything you have ever meant to do; the useful list is today''s, and it is short.'),
      @('Should I carry unfinished tasks over?','Rewrite them rather than tick them across. A task that has been rewritten three times is telling you something - usually that it is not really a task but a project, or that you are not going to do it.'),
      @('Can I print a blank one?','Clear the tasks box and the sheet prints as empty ruled boxes.'))
    templates=@(
      (New-Personal 'plain-list' 'Plain List' 'Simple &middot; ruled boxes' 'td-plain' 'f-tenor' '' '#ffffff' '#1d2228' '#2f4858' '#57606a' $PBody.todo),
      (New-Personal 'banded-list' 'Banded List' 'Modern &middot; alternating rows' 'td-boxed' 'f-josefin' '' '#ffffff' '#1b2430' '#c1543f' '#59636e' $PBody.todo),
      (New-Personal 'panel-list' 'Panel List' 'Filled &middot; tinted panel' 'td-panel' 'f-libre' '' '#fbfbf8' '#2a2c26' '#5b7f4a' '#5f6358' $PBody.todo 'bg-grad'),
      (New-Personal 'warm-list' 'Warm List' 'Filled &middot; header band' 'td-band' 'f-marcellus' '' '#fdfbf6' '#33302a' '#b4722e' '#6b6558' $PBody.todo)) },

 @{ slug='budget-templates'; name='Budget Templates'; nav='Budgets'
    kind='budget'; size='sz-a4'; fields=$FieldsBudget
    h1='Monthly Budget Templates'
    title='Budget Template - Free Printable Monthly Budget Planner'
    desc='Free printable monthly budget templates with income, spending and what is left. Fill them in online, then print or save as PDF.'
    intro=@(
      'A budget on paper works because it is slow. Writing each figure takes long enough to notice it, which is the part an app that categorises everything automatically quietly removes.',
      'Money in on the left, money out beneath it, and what is left set large at the foot. Type the amounts here or print it blank and fill it in with the bank app open beside you.')
    faq=@(
      @('What should go in the spending list?','Fixed costs first - rent, utilities, fees - then savings, then everything else. Putting savings above "everything else" rather than below it is the single change that makes budgets work.'),
      @('Should I budget by month or by week?','By month for rent, fees and bills; by week for food and everyday spending, because that is the rhythm you actually shop in. Use the month sheet for the first and a note for the second.'),
      @('It never balances. What am I doing wrong?','Probably nothing. Most first budgets are missing an irregular cost - a service, a gift, a fee that comes twice a year. Add a line for those and divide the yearly figure by twelve.'))
    templates=@(
      (New-Personal 'plain-budget' 'Plain Budget' 'Simple &middot; ruled columns' 'bd-plain' 'f-tenor' '' '#ffffff' '#1d2228' '#2f4858' '#57606a' $PBody.budget),
      (New-Personal 'banded-budget' 'Banded Budget' 'Modern &middot; alternating rows' 'bd-boxed' 'f-josefin' '' '#ffffff' '#1b2430' '#22394f' '#59636e' $PBody.budget),
      (New-Personal 'panel-budget' 'Panel Budget' 'Filled &middot; tinted sections' 'bd-panel' 'f-libre' '' '#fbfbf8' '#2a2c26' '#2e7d5a' '#5f6358' $PBody.budget 'bg-grad'),
      (New-Personal 'ledger-budget' 'Ledger Budget' 'Filled &middot; header band, serif' 'bd-band' 'f-cormorant' '' '#fdfcf9' '#241f1b' '#8a6a3b' '#5f5850' $PBody.budget)) },

 @{ slug='recipe-card-templates'; name='Recipe Card Templates'; nav='Recipe Cards'
    kind='recipe'; size='sz-recipe'; sizeset='recipe'; fields=$FieldsRecipe
    ornaments=$true
    h1='Recipe Card Templates'
    title='Recipe Card Template - Free Printable 4x6 Recipe Cards'
    desc='Free printable recipe card templates at 4x6 and A5. Type the ingredients and method, then print for a recipe box or to pass on.'
    intro=@(
      'A recipe card is read standing up with one hand busy, so the ingredients have to be scannable and the method numbered down the page rather than run together in a paragraph.',
      'These come at the standard 4&times;6 inch recipe box size and at A5 for longer recipes. Handing one to somebody is still the best way to pass a recipe on, and it survives being splashed better than a phone.')
    faq=@(
      @('What size are recipe cards?','4&times;6 inches is the standard recipe box size, which is the default here. A5 is in the editor for anything that will not fit.'),
      @('Should ingredients be listed in the order used?','Yes. It is the difference between a recipe you can follow and one you have to read twice - and it means you can check the list as you go rather than hunting.'),
      @('What paper should I use?','Card of 250gsm or heavier, and if it is going near a stove, laminate it. A recipe you actually cook from gets splashed within a month.'))
    templates=@(
      (New-Personal 'plain-recipe' 'Plain Recipe' 'Simple &middot; two column' 'rp-plain' 'f-tenor' '' '#ffffff' '#1d2228' '#2f4858' '#57606a' $PBody.recipe),
      (New-Personal 'kitchen-modern' 'Kitchen Modern' 'Modern &middot; header band' 'rp-band' 'f-josefin' '' '#ffffff' '#1f2a23' '#2e7d5a' '#5a6660' $PBody.recipe),
      (New-Personal 'warm-kitchen' 'Warm Kitchen' 'Filled &middot; sprigs and serif' 'rp-panel' 'f-cormorant' 'botanical' '#fdfbf4' '#332c22' '#b4722e' '#6b6252' $PBody.recipe 'bg-grad'),
      (New-Personal 'framed-recipe' 'Framed Recipe' 'Filled &middot; framed' 'rp-framed' 'f-marcellus' 'vine' '#fdfcf9' '#241f1b' '#8a6a3b' '#5f5850' $PBody.recipe)) },

 @{ slug='gift-voucher-templates'; name='Gift Voucher Templates'; nav='Gift Vouchers'
    kind='voucher'; size='sz-voucher'; sizeset='voucher'; fields=$FieldsVoucher
    ornaments=$true
    h1='Gift Voucher Templates'
    title='Gift Voucher Template - Free Printable Gift Certificates'
    desc='Free printable gift voucher and gift certificate templates for small businesses and personal gifts. Add the value and details, then print.'
    intro=@(
      'A voucher has to make the value obvious and the conditions findable - in that order. These set the amount as the largest thing on the card and keep the expiry and terms legible without letting them compete.',
      'They work as a business voucher with a code and terms, or as a personal one with those cleared away. Four looks, from a plain card to a foiled one.')
    faq=@(
      @('What has to be on a gift voucher?','The business, the value, who it is for, an expiry date, and any conditions. A code helps you track redemption; for a personal gift, clear that box and it disappears.'),
      @('How long should a voucher be valid?','A year is usual and generous. Check local rules before setting anything shorter - several countries set a legal minimum, and an expiry that breaks it is unenforceable anyway.'),
      @('Can I use this for a small business?','Yes, and the code field is there for exactly that. Keep a list of issued codes and mark them off; a voucher scheme without a record is a voucher scheme you cannot balance.'))
    templates=@(
      (New-Personal 'plain-voucher' 'Plain Voucher' 'Simple &middot; value first' 'vc-plain' 'f-tenor' '' '#ffffff' '#1d2228' '#2f4858' '#57606a' $PBody.voucher),
      (New-Personal 'modern-voucher' 'Modern Voucher' 'Modern &middot; side band' 'vc-band' 'f-josefin' '' '#ffffff' '#1f2a23' '#2e5d4b' '#5a6660' $PBody.voucher),
      (New-Personal 'botanical-voucher' 'Botanical Voucher' 'Filled &middot; sprigs' 'vc-panel' 'f-cormorant' 'botanical' '#fdf9f4' '#332c22' '#b4722e' '#6b6252' $PBody.voucher 'bg-grad'),
      (New-Personal 'gold-voucher' 'Gold Voucher' 'Filled &middot; framed and foiled' 'vc-framed' 'f-cinzel' 'deco' '#16241d' '#f1ece0' '#c9a227' '#c2c8ba' $PBody.voucher 'bg-edge' $true)) },

 @{ slug='habit-tracker-templates'; name='Habit Tracker Templates'; nav='Habit Trackers'
    kind='habit'; size='sz-a4'; fields=$FieldsHabit
    h1='Habit Tracker Templates'
    title='Habit Tracker Template - Free Printable Monthly Trackers'
    desc='Free printable monthly habit tracker templates with a box for every day. Type your habits, print, and fill the boxes in by hand.'
    intro=@(
      'A habit tracker works because the row of filled boxes is visible and you would rather not break it. That only happens on paper on a wall - which is why these are built to be printed and ticked, not filled in on screen.',
      'Type your habits one per line and the grid draws a row of thirty-one boxes for each. Five or six habits is the useful maximum; a sheet of fifteen gets abandoned in the second week.')
    faq=@(
      @('How many habits should I track?','Five or six. Tracking is itself a small daily task, and a sheet with fifteen rows becomes work rather than a record of work.'),
      @('What happens when I miss a day?','Nothing. Miss one, fill the next - the rule that matters is never missing twice, and a tracker exists to show you the second miss coming.'),
      @('Should the habits be specific?','Yes. "Exercise" is hard to tick honestly; "walk 30 minutes" either happened or it did not, and that is the whole value of the box.'))
    templates=@(
      (New-Personal 'plain-tracker' 'Plain Tracker' 'Simple &middot; ruled grid' 'hb-plain' 'f-tenor' '' '#ffffff' '#1d2228' '#2f4858' '#57606a' $PBody.habit),
      (New-Personal 'banded-tracker' 'Banded Tracker' 'Modern &middot; alternating rows' 'hb-boxed' 'f-josefin' '' '#ffffff' '#1b2430' '#22394f' '#59636e' $PBody.habit),
      (New-Personal 'green-tracker' 'Green Tracker' 'Filled &middot; header band' 'hb-band' 'f-tenor' '' '#ffffff' '#1f2a23' '#2e7d5a' '#5a6660' $PBody.habit),
      (New-Personal 'warm-tracker' 'Warm Tracker' 'Filled &middot; tinted header' 'hb-panel' 'f-marcellus' '' '#fdfbf6' '#33302a' '#b4722e' '#6b6558' $PBody.habit 'bg-grad')) },

 @{ slug='meal-planner-templates'; name='Meal Planner Templates'; nav='Meal Planners'
    kind='meal'; size='sz-a4'; fields=$FieldsMeal
    h1='Weekly Meal Planner Templates'
    title='Meal Planner Template - Free Printable Weekly Meal Plans'
    desc='Free printable weekly meal planner templates with a shopping list. Fill in the week, print, and stick it on the fridge.'
    intro=@(
      'The point of planning meals is the shopping list that falls out of it, so these keep the list on the same sheet rather than on a separate one you will leave at home.',
      'Seven day columns and a row for each meal. Type one meal per line in each column and keep the line counts equal - the rows line up on their own, and a day you are eating out is a dash rather than a gap.')
    faq=@(
      @('How far ahead should I plan?','A week. Two weeks looks efficient and collapses by the fourth day, because plans made a fortnight out do not survive one late evening.'),
      @('Should I plan every meal?','Plan dinners properly and leave breakfast and lunch loose - those are habits rather than decisions, and planning them adds work for nothing.'),
      @('What about leftovers?','Write them in as a meal. A plan that pretends every dinner is cooked fresh is the plan that produces waste on Thursday.'))
    templates=@(
      (New-Personal 'plain-week' 'Plain Week' 'Simple &middot; ruled columns' 'ml-plain' 'f-tenor' '' '#ffffff' '#1d2228' '#2f4858' '#57606a' $PBody.meal),
      (New-Personal 'banded-week' 'Banded Week' 'Modern &middot; alternating rows' 'ml-boxed' 'f-josefin' '' '#ffffff' '#1f2a23' '#2e7d5a' '#5a6660' $PBody.meal),
      (New-Personal 'kitchen-week' 'Kitchen Week' 'Filled &middot; header band' 'ml-band' 'f-tenor' '' '#ffffff' '#33302a' '#b4722e' '#6b6558' $PBody.meal),
      (New-Personal 'garden-week' 'Garden Week' 'Filled &middot; tinted columns' 'ml-panel' 'f-cormorant' '' '#f8fbf6' '#25361f' '#5b7f4a' '#5c6a54' $PBody.meal 'bg-grad')) }
)

# --- guides -------------------------------------------------------------------

$PGuides = @(
 @{ slug='how-to-make-a-monthly-budget'
    title='How to Make a Monthly Budget That Survives the Month'
    h1='How to Make a Monthly Budget'
    desc='What order to list things in, why savings goes before spending, and what to do about the costs that only come twice a year.'
    read='6 min read'
    body=@(
      @('p','Most budgets fail in the same two ways: savings is whatever is left at the end, and the irregular costs are missing entirely. Fix those two and a budget mostly works on its own.'),
      @('h2','Write the income first, and be honest about it'),
      @('p','Take-home pay, not the headline figure. If your income varies - freelance work, commission, a shop - use the lowest of the last three months rather than the average. A budget built on a good month is a budget that fails in a normal one.'),
      @('h2','Savings goes above "everything else", not below it'),
      @('p','This is the single change that makes the difference. Saving what is left at the end of the month means saving what you failed to spend, which is almost nothing. Move a fixed amount on the day the money arrives and budget the rest - the spending adjusts, quietly and without much pain.'),
      @('h2','List fixed costs, then variable ones'),
      @('ol',@(
        '<strong>Fixed:</strong> rent, utilities, school fees, loan payments, insurance. These are the same every month and you cannot negotiate them this week.',
        '<strong>Savings:</strong> the amount you decided above.',
        '<strong>Variable:</strong> groceries, transport, eating out, everything else. This is the part that flexes.')),
      @('h2','The costs that come twice a year'),
      @('p','Car servicing, a school uniform, Eid, a wedding, an insurance renewal. These are what break a budget that balanced perfectly on paper. Add up a year of them, divide by twelve, and put that figure in as a monthly line - even if the money just sits there most months. That line is the reason the budget survives March.'),
      @('h2','Track for two months before you judge it'),
      @('p','The first month tells you what you actually spend, which is rarely what you assumed. The second tells you whether the first was typical. Changing the numbers before you have two months of data is guessing with extra steps.'),
      @('h2','Why paper'),
      @('p','An app that categorises everything automatically removes the only part that changes behaviour: noticing. Writing "42,000 - groceries" takes four seconds, and those four seconds are where the thinking happens.'),
      @('cta','budget-templates')) },

 @{ slug='how-to-plan-meals-for-a-week'
    title='How to Plan a Week of Meals Without Giving Up by Wednesday'
    h1='How to Plan Meals for a Week'
    desc='Why weekly beats fortnightly, which meals are worth planning, and how to build the shopping list out of the plan rather than beside it.'
    read='5 min read'
    body=@(
      @('p','Meal planning fails in a predictable way: an ambitious fortnight of new recipes, abandoned on the fourth evening when somebody comes home late. Here is the version that survives.'),
      @('h2','Plan a week, not a fortnight'),
      @('p','A fortnight looks more efficient and is not. Plans made two weeks out do not survive one changed evening, and fresh food bought for day eleven is thrown away on day nine.'),
      @('h2','Only dinners need planning'),
      @('p','Breakfast is a habit and lunch is usually leftovers or whatever is nearby. Planning them adds work without removing a decision, because you were not really deciding them anyway. Plan seven dinners and the week is planned.'),
      @('h2','Write leftovers in as a meal'),
      @('p','A plan where every dinner is cooked fresh is the plan that produces a bin full of food on Thursday. Cook once for two nights deliberately - it is the difference between a plan and an aspiration.'),
      @('h2','Leave one night open'),
      @('p','Something will happen on one evening. Marking it as "out" or "whatever is in" ahead of time means the plan bends rather than breaks, and you do not spend Friday feeling you failed at cooking.'),
      @('h2','Build the list from the plan'),
      @('p','Go through the seven dinners and write what each needs, then cross off what you already have. A shopping list written separately from the plan is a list of things you usually buy, which is how three bunches of coriander end up in the fridge.'),
      @('h2','Put it where you will see it'),
      @('p','On the fridge, not in a drawer. The plan''s job at six in the evening is to answer the question before you open the fridge and start improvising - and it can only do that if it is in front of you.'),
      @('cta','meal-planner-templates')) }
)
