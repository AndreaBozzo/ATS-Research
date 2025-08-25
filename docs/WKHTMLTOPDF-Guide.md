# Guida wkhtmltopdf per CV ATS-Optimized

## Installazione wkhtmltopdf

### Windows
1. Scarica da: https://wkhtmltopdf.org/downloads.html
2. Installa la versione "with patched qt" (importante!)
3. Aggiungi al PATH di sistema
4. Riavvia il prompt dei comandi

### macOS
```bash
brew install wkhtmltopdf
```

### Ubuntu/Debian
```bash
sudo apt-get update
sudo apt-get install wkhtmltopdf
```

## Conversione Ottimizzata

### Script Automatico
Usa gli script forniti:
- **Windows:** `convert-to-pdf.bat`
- **Linux/macOS:** `convert-to-pdf.sh`

### Comando Manuale
```bash
wkhtmltopdf \
  --page-size A4 \
  --margin-top 0.5in \
  --margin-right 0.5in \
  --margin-bottom 0.5in \
  --margin-left 0.5in \
  --encoding UTF-8 \
  --enable-local-file-access \
  --enable-javascript \
  --javascript-delay 1000 \
  --print-media-type \
  --disable-smart-shrinking \
  --zoom 1.0 \
  --dpi 300 \
  --image-quality 100 \
  --background \
  --images \
  --no-pdf-compression \
  input.html output.pdf
```

## Ottimizzazioni Implementate

### 1. CSS Specifico per wkhtmltopdf
```css
@media print {
    /* Font rendering migliorato */
    * {
        -webkit-font-smoothing: antialiased;
        -moz-osx-font-smoothing: grayscale;
    }
    
    /* Preserva colori e sfondi */
    body, header, .container {
        -webkit-print-color-adjust: exact;
        color-adjust: exact;
    }
    
    /* Evita interruzioni di pagina */
    .experience-item, .certification {
        page-break-inside: avoid;
        break-inside: avoid;
    }
}
```

### 2. Layer ATS Specifici per wkhtmltopdf
- **Clip rectangles:** `clip: rect(0,0,0,0)`
- **Position fixed:** Per elementi fuori pagina
- **Font-size minimo:** 0.3pt (più piccolo funziona meglio)
- **Opacity ultra-bassa:** 0.0001 per stealth mode

### 3. Gestione Font
wkhtmltopdf gestisce meglio i font web con:
```css
@font-face {
    font-family: 'JetBrains Mono';
    font-display: block;
}
```

## Vantaggi vs Chrome PDF

### wkhtmltopdf ✅
- **Rendering superiore** dei gradienti e ombre
- **Font più nitidi** e ben definiti
- **Gestione avanzata** di `position: fixed`
- **Migliore controllo** dell pagine
- **Preserva** tutti gli hack ATS
- **File più piccoli** con qualità superiore

### Chrome PDF ❌
- Font sfocati
- Gradienti con banding
- Hack ATS persi
- Controllo limitato

## Parametri Critici

### Per Qualità Visiva
- `--dpi 300`: Alta risoluzione
- `--image-quality 100`: Immagini perfette
- `--background`: Preserva gradienti
- `--disable-smart-shrinking`: No ridimensionamento automatico

### Per Hack ATS
- `--enable-javascript`: Permette script di manipolazione
- `--javascript-delay 1000`: Tempo per script
- `--print-media-type`: Usa CSS @media print
- `--no-pdf-compression`: Preserva testo nascosto

### Per Compatibilità
- `--encoding UTF-8`: Unicode completo
- `--enable-local-file-access`: File locali
- `--zoom 1.0`: Scala corretta

## Test di Verifica

### 1. Qualità Visiva
```bash
# Confronta visivamente HTML vs PDF
start file.html && start file.pdf
```

### 2. Estrazione ATS
```bash
# Test keywords (richiede pdftotext)
pdftotext -layout file.pdf - | grep -i "databricks\|osservatorio"
```

### 3. Dimensione File
```bash
# Verifica dimensione ragionevole (dovrebbe essere 200-500KB)
ls -lh *.pdf
```

## Risoluzione Problemi

### Font non caricati
```bash
# Usa font di sistema in fallback
wkhtmltopdf --debug-javascript input.html output.pdf
```

### JavaScript non funziona
```bash
# Aumenta delay e abilita debug
wkhtmltopdf --javascript-delay 2000 --debug-javascript input.html output.pdf
```

### Hack ATS persi
1. Verifica che `--print-media-type` sia attivo
2. Controlla che non ci sia `display: none` in @media print
3. Usa `--no-pdf-compression` per preservare testo

### Qualità scarsa
1. Aumenta `--dpi` a 300 o 600
2. Usa `--image-quality 100`
3. Verifica `--zoom 1.0`

## File di Output Attesi

Dopo la conversione dovresti avere:
- `cv-andrea-control.pdf` (baseline)
- `cv-andrea-minimal-control.pdf` (controllo minimo)
- `cv-andrea-experimental.pdf` (hack standard)
- `cv-andrea-experimental-stealth.pdf` (hack aggressivi)

### Dimensioni Tipiche
- Control: ~150KB
- Minimal: ~120KB  
- Experimental: ~200KB
- Stealth: ~250KB

La versione stealth sarà leggermente più grande per via degli hack aggiuntivi, ma la qualità visiva dovrebbe essere identica tra tutte le versioni.

## Comando Rapido
```bash
# Conversione singola ottimizzata
wkhtmltopdf --page-size A4 --margin-top 0.5in --margin-right 0.5in --margin-bottom 0.5in --margin-left 0.5in --enable-javascript --javascript-delay 1000 --print-media-type --dpi 300 --background --no-pdf-compression input.html output.pdf
```
