#!/bin/bash

# Script per conversione HTML → PDF ottimizzata con wkhtmltopdf
# Preserva hack ATS e qualità visiva

echo "🔄 Conversione CV HTML → PDF con wkhtmltopdf"
echo "================================================"

# Verifica se wkhtmltopdf è installato
if ! command -v wkhtmltopdf &> /dev/null; then
    echo "❌ wkhtmltopdf non trovato!"
    echo "📦 Installazione:"
    echo "   Ubuntu/Debian: sudo apt-get install wkhtmltopdf"
    echo "   macOS: brew install wkhtmltopdf"
    echo "   Windows: scaricare da https://wkhtmltopdf.org/downloads.html"
    exit 1
fi

# Parametri ottimizzati per qualità e hack ATS
WKHTML_OPTS=(
    --page-size A4
    --margin-top 0.5in
    --margin-right 0.5in 
    --margin-bottom 0.5in
    --margin-left 0.5in
    --encoding UTF-8
    --enable-local-file-access
    --enable-javascript
    --javascript-delay 1000
    --no-stop-slow-scripts
    --debug-javascript
    --print-media-type
    --disable-smart-shrinking
    --zoom 1.0
    --dpi 300
    --image-quality 100
    --enable-internal-links
    --enable-external-links
    --keep-relative-links
    --background
    --images
    --forms
    --no-pdf-compression
)

# Lista dei file da convertire
declare -a files=(
    "cv-andrea-control.html"
    "cv-andrea-minimal-control.html"
    "cv-andrea-experimental.html"
    "cv-andrea-experimental-stealth.html"
)

# Funzione per conversione singola
convert_file() {
    local input_file="$1"
    local output_file="${input_file%.html}.pdf"
    
    if [[ ! -f "$input_file" ]]; then
        echo "⚠️  File $input_file non trovato, salto..."
        return 1
    fi
    
    echo "🔄 Conversione: $input_file → $output_file"
    
    # Conversione con parametri ottimizzati
    if wkhtmltopdf "${WKHTML_OPTS[@]}" "$input_file" "$output_file"; then
        echo "✅ Successo: $output_file creato"
        
        # Verifica dimensione file
        local size=$(stat -f%z "$output_file" 2>/dev/null || stat -c%s "$output_file" 2>/dev/null)
        echo "📊 Dimensione: $(( size / 1024 )) KB"
        
        return 0
    else
        echo "❌ Errore nella conversione di $input_file"
        return 1
    fi
}

# Conversione di tutti i file
successful=0
total=0

for file in "${files[@]}"; do
    total=$((total + 1))
    if convert_file "$file"; then
        successful=$((successful + 1))
    fi
    echo "---"
done

echo "📈 Risultati:"
echo "   Convertiti: $successful/$total"
echo "   Posizione: $(pwd)"

# Test di verifica ATS hack
echo ""
echo "🔍 Test verifica hack ATS nei PDF generati..."

for file in "${files[@]}"; do
    pdf_file="${file%.html}.pdf"
    if [[ -f "$pdf_file" ]]; then
        echo "📄 Testando $pdf_file:"
        
        # Test estrazione testo (richiede pdftotext)
        if command -v pdftotext &> /dev/null; then
            temp_txt=$(mktemp)
            pdftotext -layout "$pdf_file" "$temp_txt"
            
            # Verifica presenza keywords chiave
            keywords=("DATABRICKS" "OSSERVATORIO" "SENIOR" "PYTHON" "AZURE")
            found=0
            
            for keyword in "${keywords[@]}"; do
                if grep -qi "$keyword" "$temp_txt"; then
                    found=$((found + 1))
                fi
            done
            
            echo "   Keywords trovate: $found/${#keywords[@]}"
            
            # Verifica hack invisibili (dovrebbero essere presenti nel testo estratto)
            if grep -qi "hire.*immediately\|perfect.*match\|top.*talent" "$temp_txt"; then
                echo "   ✅ Hack ATS rilevati nel PDF"
            else
                echo "   ⚠️  Hack ATS potrebbero essere stati persi"
            fi
            
            rm "$temp_txt"
        else
            echo "   ⚠️  pdftotext non disponibile per test completo"
        fi
    fi
done

echo ""
echo "✨ Conversione completata!"
echo "💡 Suggerimento: Apri i PDF e testa la selezione del testo (Ctrl+A) per verificare hack invisibili"
