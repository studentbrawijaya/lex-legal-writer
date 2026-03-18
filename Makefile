# LEX v3.0 — Makefile untuk kompilasi artikel LaTeX
# Cara pakai:
#   make artikel/out/nama-artikel.pdf   → kompilasi satu file
#   make all                            → kompilasi semua file di folder artikel/
#   make clean                          → hapus file build sementara

ARTIKEL_DIR  := artikel
OUT_DIR      := out
TEMPLATES    := templates

# Cari semua .tex di folder artikel/
SOURCES := $(wildcard $(ARTIKEL_DIR)/*.tex)
PDFS    := $(patsubst $(ARTIKEL_DIR)/%.tex, $(ARTIKEL_DIR)/$(OUT_DIR)/%.pdf, $(SOURCES))

.PHONY: all clean help

## Default target
all: $(PDFS)
	@echo ""
	@echo "✓ Semua artikel berhasil dikompilasi. Lihat folder artikel/out/"

## Kompilasi satu artikel: pdflatex → bibtex → pdflatex × 2
$(ARTIKEL_DIR)/$(OUT_DIR)/%.pdf: $(ARTIKEL_DIR)/%.tex | $(ARTIKEL_DIR)/$(OUT_DIR)
	@echo "──────────────────────────────────────────"
	@echo "Mengompilasi: $<"
	@echo "──────────────────────────────────────────"
	pdflatex -interaction=nonstopmode -output-directory=$(ARTIKEL_DIR)/$(OUT_DIR) $<
	-bibtex $(ARTIKEL_DIR)/$(OUT_DIR)/$(basename $(notdir $<))
	pdflatex -interaction=nonstopmode -output-directory=$(ARTIKEL_DIR)/$(OUT_DIR) $<
	pdflatex -interaction=nonstopmode -output-directory=$(ARTIKEL_DIR)/$(OUT_DIR) $<
	@echo "✓ PDF: $@"

## Pastikan folder output ada
$(ARTIKEL_DIR)/$(OUT_DIR):
	mkdir -p $@

## Kompilasi template (untuk pengujian)
templates: $(TEMPLATES)/$(OUT_DIR)/artikel-utama.pdf \
           $(TEMPLATES)/$(OUT_DIR)/atd-diagram.pdf \
           $(TEMPLATES)/$(OUT_DIR)/visualisasi.pdf

$(TEMPLATES)/$(OUT_DIR)/%.pdf: $(TEMPLATES)/%.tex | $(TEMPLATES)/$(OUT_DIR)
	pdflatex -interaction=nonstopmode -output-directory=$(TEMPLATES)/$(OUT_DIR) $<
	@echo "✓ Template PDF: $@"

$(TEMPLATES)/$(OUT_DIR):
	mkdir -p $@

## Bersihkan file sementara
clean:
	find $(ARTIKEL_DIR) $(TEMPLATES) -maxdepth 2 \
	  \( -name "*.aux" -o -name "*.log" -o -name "*.bbl" \
	     -o -name "*.blg" -o -name "*.out" -o -name "*.toc" \
	     -o -name "*.synctex.gz" -o -name "*.fls" -o -name "*.fdb_latexmk" \) \
	  -delete
	@echo "✓ File sementara dihapus."

## Hapus semua PDF hasil kompilasi
distclean: clean
	[ ! -d $(ARTIKEL_DIR)/$(OUT_DIR) ] || find $(ARTIKEL_DIR)/$(OUT_DIR) -name "*.pdf" -delete
	[ ! -d $(TEMPLATES)/$(OUT_DIR) ]  || find $(TEMPLATES)/$(OUT_DIR)  -name "*.pdf" -delete
	@echo "✓ Semua PDF dihapus."

## Tampilkan bantuan
help:
	@echo ""
	@echo "LEX v3.0 — Perintah Makefile"
	@echo "──────────────────────────────────────────"
	@echo "  make all                         Kompilasi semua artikel di artikel/"
	@echo "  make artikel/out/nama.pdf        Kompilasi satu artikel"
	@echo "  make templates                   Kompilasi semua template"
	@echo "  make clean                       Hapus file sementara (.aux, .log, dll)"
	@echo "  make distclean                   Hapus semua PDF hasil kompilasi"
	@echo ""
	@echo "Contoh workflow:"
	@echo "  cp templates/artikel-utama.tex artikel/hak-konstitusional-2024.tex"
	@echo "  make artikel/out/hak-konstitusional-2024.pdf"
	@echo ""
