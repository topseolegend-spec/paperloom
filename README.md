# Paperloom — printable invitation template site

Static website. Har page `build.ps1` se generate hota hai, content `content.ps1` mein hai.

## Site build karna

```powershell
powershell -ExecutionPolicy Bypass -File build.ps1
```

Ye `docs/` folder banata hai — GitHub Pages isi folder ko serve karta hai.

## Local preview

```powershell
powershell -ExecutionPolicy Bypass -File serve.ps1
```

Phir browser mein `http://localhost:8080` kholein. Band karne ke liye us window mein `Ctrl+C`.

## Files

| File | Kaam |
|---|---|
| `content.ps1` | Saara content — categories, subcategories, templates, guides, FAQs. **Naya content yahan add karein.** |
| `build.ps1` | HTML generate karta hai (header, footer, SEO tags, sitemap) |
| `assets/css/style.css` | Site ka design |
| `assets/css/cards.css` | Card template designs |
| `assets/css/editor.css`, `assets/js/editor.js` | In-browser card editor |
| `serve.ps1` | Local preview server |
| `docs/` | Generated output — ise manually edit **na** karein, har build par dobara banta hai |

## Naya occasion add karna

`content.ps1` mein `$Subcats` array ke andar ek naya block add karein (slug, name, h1, title, desc,
intro, faq, templates), phir `build.ps1` chala dein. Header ka dropdown, sitemap, aur internal links
khud update ho jayenge.

## Abhi set karna baqi hai

- `content.ps1` ke `$Site` block mein asal domain aur contact email
- Brand ka naam (`Paperloom` filhal placeholder hai)

## Design ke bare mein

Har card CSS aur inline SVG se banaya gaya hai — koi stock photo ya third-party artwork use nahi
hua, is liye copyright ka masla nahi hai.

## Editor (template detail pages)

`assets/js/editor.js` har template page par ye features deta hai — bina kisi account ke:

- **Inline editing** — card ki kisi bhi line par click karke apna text likhein
- **Colours** — 6 ready palettes, ya background/text/accent khud choose karein
- **Typefaces** — 5 Latin faces + Urdu (Nastaliq) aur Arabic (Amiri), jo layout ko RTL kar dete hain
- **Auto-save** — edits browser ke localStorage mein mehfooz rehte hain
- **Share link** — "Copy link" edits ko URL hash mein encode karta hai, koi bhi wo link khol kar
  aapka version dekh sakta hai
- **PNG download** — 1500 × 2100 px (5×7 inch @ 300dpi), html2canvas se
- **Print / PDF** — browser ke print dialog se

## Do zaroori baatein

**Encoding:** `content.ps1` aur `build.ps1` mein Urdu/Arabic text seedha na likhein — PowerShell 5.1
in files ko ANSI samajhta hai aur text kharab ho jata hai. HTML entities use karein
(`&#1575;&#1585;&#1583;&#1608;` = Urdu ka "اردو").

Isi wajah se in files ko `Get-Content`/`Set-Content` se bulk-edit bhi na karein — wo bhi text kharab
kar deta hai. Editor mein kholein aur seedha edit karein.

**keywords.csv:** keyword research `.gitignore` mein hai, taake public repo mein na jaye.
