# LEX v3.0 — Legal Excellence Writer

A GitHub Copilot custom instructions configuration that turns Copilot into **LEX v3.0**, a specialist AI for writing high-level Indonesian legal academic articles (Jurnal Konstitusi / Sinta 1 / Scopus Q1).

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/studentbrawijaya/lex-legal-writer?quickstart=1)

---

## 🚀 Jalankan di GitHub Codespaces (Free & Powerful)

**GitHub Codespaces** adalah environment terbaik untuk project ini — gratis (60 jam/bulan), powerful, berjalan di browser, dan otomatis mengaktifkan GitHub Copilot.

### Cara membuka

1. Klik tombol **"Open in GitHub Codespaces"** di atas, **atau**
2. Buka halaman repository → klik tombol hijau **`<> Code`** → tab **Codespaces** → **Create codespace on main**

Codespaces akan otomatis:
- Menginstal **TeX Live full** (semua paket LaTeX termasuk `tikz`, `pgfplots`, `pgf-pie`, `booktabs`, dll.)
- Menginstal ekstensi **LaTeX Workshop** (kompilasi + preview PDF di tab VS Code)
- Mengaktifkan **GitHub Copilot** + **Copilot Chat** dengan instruksi LEX v3.0

### Kompilasi artikel di terminal Codespaces

```bash
# Kompilasi semua artikel di folder artikel/
make all

# Kompilasi satu artikel tertentu
make artikel/out/nama-artikel.pdf

# Kompilasi semua template (untuk pengujian)
make templates

# Hapus file sementara (.aux, .log, dll)
make clean
```

Atau gunakan **LaTeX Workshop** di sidebar VS Code: klik ikon `▶` untuk kompilasi otomatis saat menyimpan file.

### Kuota gratis Codespaces

| Akun GitHub | Jam/bulan | Storage |
|---|---|---|
| Free (personal) | 60 jam | 15 GB |
| Pro | 180 jam | 20 GB |

> **Tip:** Matikan Codespace lewat `github.com/codespaces` setelah selesai agar kuota tidak terpakai saat idle.

---

## Usage

The file [`.github/copilot-instructions.md`](.github/copilot-instructions.md) is automatically loaded by GitHub Copilot for every chat session in this repository. Open GitHub Copilot Chat and start writing your legal article using the workflow commands below.

## Workflow Commands

| Command | Description |
|---|---|
| `/paper-discovery [topik]` | Find 5–10 primary articles from reputable databases (MKRI, Garuda, Sciencedirect) and produce a Source Registry table. |
| `/research-gap` | Analyse existing literature and identify 3 original research gaps (novelty). |
| `/draft-subbab [nama bagian]` | Write a specific article section (e.g. Pendahuluan/Pembahasan B.1) targeting 1000–2000 words with strict ATD protocol. |
| `/audit-lex` | Review a draft, flag banned words, remove AI fluff, and verify ATD theory is present in every paragraph. |
| `/generate-viz [jenis data]` | Convert statistical data into ready-to-compile LaTeX PGFPlots/TikZ code. |

## Core Framework: ATD Analysis

Every legal analysis must integrate:

1. **Asas Hukum** — Ratio legis / legal norm
2. **Teori Hukum** — Philosophical / juridical framework
3. **Doktrin Hukum** — Expert opinion / concept operationalisation

Formula: `[Norma Positif] + [Asas] + [Teori] + [Doktrin] = [Analisis Kasus/Konstatasi]`

## Output Standard

- Format: LaTeX (`.tex`) with `\footnote{}` citations
- Citation style: McGill — `\footnote{Author, \textit{Title} (City: Publisher, Year), p. X.}`
- Target length: minimum 12 A4 pages (7000–9000 words)

---

## Folder Structure

```
lex-legal-writer/
├── .devcontainer/
│   ├── devcontainer.json         ← GitHub Codespaces / VS Code Dev Container config
│   └── Dockerfile                ← Ubuntu + TeX Live full
├── .github/
│   └── copilot-instructions.md   ← LEX v3.0 system prompt (loaded automatically by Copilot)
├── templates/
│   ├── artikel-utama.tex         ← Main LaTeX article template (jurnal hukum)
│   ├── atd-diagram.tex           ← TikZ: ATD analysis diagram + flowchart
│   └── visualisasi.tex           ← PGFPlots / pgf-pie / radar / booktabs templates
├── artikel/                      ← Save your draft .tex files here
│   └── .gitkeep
├── referensi/
│   └── pustaka.bib               ← BibTeX bibliography (add entries after /paper-discovery)
├── Makefile                      ← Kompilasi artikel dengan `make`
└── README.md
```

### How to start a new article

1. Copy `templates/artikel-utama.tex` into the `artikel/` folder and rename it (e.g. `artikel/hak-konstitusional-2024.tex`).
2. Open GitHub Copilot Chat and run the workflow commands section by section:
   ```
   /paper-discovery [topik artikel Anda]
   /research-gap
   /draft-subbab Pendahuluan
   /draft-subbab Pembahasan A
   /draft-subbab Pembahasan B
   /draft-subbab Kesimpulan
   /audit-lex
   ```
3. Add entries returned by `/paper-discovery` to `referensi/pustaka.bib`.
4. Copy any visualisation code from `templates/visualisasi.tex` or `templates/atd-diagram.tex` into your article where needed, or use `/generate-viz` to generate new ones.
5. Compile — either save the file to trigger auto-build in LaTeX Workshop, or run in the terminal:
   ```bash
   make artikel/out/nama-artikel.pdf
   ```
   Manual equivalent:
   ```bash
   pdflatex -output-directory=artikel/out artikel/nama-artikel.tex
   bibtex   artikel/out/nama-artikel
   pdflatex -output-directory=artikel/out artikel/nama-artikel.tex
   pdflatex -output-directory=artikel/out artikel/nama-artikel.tex
   ```

### Required LaTeX packages

| Package | Purpose |
|---|---|
| `tikz` + libraries | ATD diagram & flowchart |
| `pgfplots` | Bar/line charts |
| `pgf-pie` | Pie charts |
| `booktabs` | Professional comparison tables |
| `pgfplots` polar library | Radar/spider charts |
| `babel` (bahasa) | Indonesian hyphenation |
| `times` | Times New Roman font |