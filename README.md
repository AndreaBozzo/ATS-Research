# ATS Research Project

A comprehensive research project analyzing Applicant Tracking System (ATS) parsing capabilities and optimization techniques for CV/resume processing.

## Overview

This project investigates how different ATS systems parse and extract information from CVs in various formats, with a focus on understanding the effectiveness of different optimization strategies.

## Project Structure

```
ATS-Research/
├── CVs/                    # CV variants (HTML source files - not tracked)
├── PDFs/                   # Generated PDF outputs for testing
├── analysis/               # Data analysis and research notebooks
├── convert-to-pdf.bat      # Windows conversion script
└── convert-to-pdf.sh       # Unix/Linux conversion script
```

## CV Variants

The research includes four distinct CV versions designed to test different scenarios:

- **Control**: Baseline CV with standard formatting
- **Minimal Control**: Simplified version with minimal styling
- **Experimental**: Enhanced with ATS optimization techniques
- **Experimental Stealth**: Advanced version with aggressive ATS hacks

## Methodology

### ATS Optimization Techniques Tested

1. **Hidden Keywords**: Strategically placed invisible text
2. **Semantic Markup**: Structured HTML for better parsing
3. **Microtext Elements**: Ultra-small font content
4. **Unicode Techniques**: Zero-width characters and special encoding
5. **SVG Hidden Text**: Vector-based invisible content
6. **Canvas Rendering**: Programmatic text insertion
7. **CSS Pseudo-elements**: Generated content techniques
8. **Data Attributes**: Metadata embedding

### PDF Generation

CVs are converted to PDF using `wkhtmltopdf` with optimized parameters to preserve ATS-friendly elements while maintaining professional presentation quality.

**Key Parameters:**
- High DPI (300) for quality
- Background preservation for visual elements
- JavaScript execution for dynamic content
- Local file access for complete resource loading

## Research Goals

- **Parse Rate Analysis**: Measure how different ATS systems extract information
- **Keyword Detection**: Test visibility of hidden optimization elements
- **Format Compatibility**: Compare HTML vs PDF parsing effectiveness
- **Visual Quality**: Balance between ATS optimization and human readability

## Usage

### Generate PDFs

**Windows:**
```bash
cd CVs
.\convert-to-pdf.bat
```

**Unix/Linux:**
```bash
cd CVs
chmod +x convert-to-pdf.sh
./convert-to-pdf.sh
```

### Analysis

Research data and analysis can be found in the `analysis/` directory using Jupyter notebooks.

## Requirements

- `wkhtmltopdf` (for PDF generation)
- Python 3.x (for analysis)
- Jupyter Notebook (for research documentation)

## Results

PDF outputs are automatically saved to the `PDFs/` directory, organized for systematic ATS testing across different platforms and systems.

---

*This is a research project for educational and professional development purposes.*
