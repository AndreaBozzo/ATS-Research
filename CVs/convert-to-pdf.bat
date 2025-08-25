@echo off
:: Script per conversione HTML → PDF ottimizzata con wkhtmltopdf (Windows)
:: Preserva hack ATS e qualità visiva

echo 🔄 Conversione CV HTML → PDF con wkhtmltopdf
echo ================================================

:: Verifica se wkhtmltopdf è installato
where wkhtmltopdf >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ wkhtmltopdf non trovato!
    echo 📦 Scarica da: https://wkhtmltopdf.org/downloads.html
    echo 💡 Dopo installazione, riavvia il prompt
    pause
    exit /b 1
)

:: Parametri ottimizzati per qualità e hack ATS
set WKHTML_OPTS=--page-size A4 --margin-top 0.5in --margin-right 0.5in --margin-bottom 0.5in --margin-left 0.5in --encoding UTF-8 --enable-local-file-access --enable-javascript --javascript-delay 1000 --no-stop-slow-scripts --print-media-type --disable-smart-shrinking --zoom 1.0 --dpi 300 --image-quality 100 --background --images --no-pdf-compression

:: Lista dei file da convertire
set files=cv-andrea-control.html cv-andrea-minimal-control.html cv-andrea-experimental.html cv-andrea-experimental-stealth.html

set successful=0
set total=0

for %%f in (%files%) do (
    set /a total+=1
    if exist "%%f" (
        echo 🔄 Conversione: %%f
        set output=PDFs\%%~nf.pdf
        
        :: Conversione con parametri ottimizzati
        wkhtmltopdf %WKHTML_OPTS% "%%f" "!output!"
        
        if !errorlevel! equ 0 (
            echo ✅ Successo: !output! creato
            set /a successful+=1
            
            :: Verifica dimensione file
            for %%A in ("!output!") do set size=%%~zA
            set /a sizeKB=!size!/1024
            echo 📊 Dimensione: !sizeKB! KB
        ) else (
            echo ❌ Errore nella conversione di %%f
        )
    ) else (
        echo ⚠️  File %%f non trovato, salto...
    )
    echo ---
)

echo.
echo 📈 Risultati:
echo    Convertiti: %successful%/%total%
echo    Posizione: %cd%

echo.
echo ✨ Conversione completata!
echo 💡 Suggerimento: Apri i PDF e testa la selezione del testo (Ctrl+A) per verificare hack invisibili
pause
