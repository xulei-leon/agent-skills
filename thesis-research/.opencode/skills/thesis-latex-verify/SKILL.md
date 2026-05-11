---
name: thesis-latex-verify
description: >
  Converts Markdown paper drafts to LaTeX source, performs silent compilation with BibTeX,
  captures and auto-fixes formatting errors and citation failures, and produces a compilable
  paper.tex and paper.pdf output.
license: MIT
---

# thesis-latex-verify — LaTeX Conversion & Verification

## Purpose

Convert the Markdown draft to LaTeX source code, perform background silent compilation, capture
syntax errors, formula formatting issues, or citation failures, and automatically feedback repair
strategies.

## Trigger

Loaded during the `/thesis-write` phase. Receives the revised draft.

## Input

| Field | Source | Description |
|-------|--------|-------------|
| `draft.md` | thesis_revise | Final revised Markdown draft |
| `sections/*.md` | thesis_revise | Individual section files |
| `references.bib` | thesis_survey | Bibliography |
| `outline.json` | thesis_outline | Outline for structure reference |
| `thesis/templates/article.tex` | templates/ | LaTeX document skeleton |

## Output Artifacts

| File | Format | Description |
|------|--------|-------------|
| `paper.tex` | LaTeX | Complete compilable LaTeX document |
| `paper.pdf` | PDF | Compiled output |
| `compile_report.md` | Markdown | Compilation diagnostics and fix log |

---

## Phase 1: Markdown → LaTeX Conversion

### Section Conversion

Convert each `sections/{id}.md` to `sections/{id}.tex` using these transformation rules:

| Markdown | LaTeX |
|----------|-------|
| `## {number} {title}` | `\section{{title}}\label{{sec:{id}}}` |
| `### {number} {title}` | `\subsection{{title}}\label{{subsec:{id}}}` |
| `#### {number} {title}` | `\subsubsection{{title}}` |
| `[@key]` | `\cite{key}` |
| `[@key1; @key2]` | `\cite{key1,key2}` |
| `**bold**` | `\textbf{bold}` |
| `*italic*` | `\textit{italic}` |
| `$inline_math$` | `$inline_math$` (unchanged, escape underscores) |
| `$$display_math$$` | `\begin{equation}...\end{equation}` or `\[...\]` |
| `- bullet` | `\begin{itemize}\item ...\end{itemize}` |
| `1. numbered` | `\begin{enumerate}\item ...\end{enumerate}` |
| `![caption](path)` | `\begin{figure}[t]\centering\includegraphics[width=0.8\linewidth]{path}\caption{caption}\label{fig:{id}}\end{figure}` |
| `| a | b |` (table) | `\begin{table}[t]\centering\caption{...}\label{tab:{id}}\begin{tabular}{...}...\end{tabular}\end{table}` |
| `[^1]: footnote` | `\footnote{footnote text}` |
| `<!-- HTML comment -->` | `% comment` |

### Math Conversion Rules

| Pattern in Markdown | LaTeX Equivalent |
|--------------------|------------------|
| `$...$` (inline) | Pass through, but escape underscores: `_` → `\_` |
| `$$...$$` (display) | Convert to `\begin{equation}...\end{equation}` |
| `\begin{aligned}` etc. | Pass through as-is |

Math validation:
- Check for missing `\right` with `\left` (or vice versa)
- Check for unescaped `_` outside math mode
- Check for unbalanced `{` `}` in math environments
- Flag any `$` that doesn't properly close

### Figure/Table Conversion

For figure placeholders in Markdown:
1. Check if the referenced file exists in `figures/`
2. If missing, generate a warning: `% WARNING: figure file not found: {path}`
3. Add proper `\label{fig:{id}}` for cross-referencing

For tables:
1. Count columns from the Markdown table
2. Generate `\begin{tabular}{lcc...}` with appropriate column count
3. Replace `|---|` separators with `\toprule`, `\midrule`, `\bottomrule`
4. Add `\label{tab:{id}}`

---

## Phase 2: Document Assembly

Read `thesis/templates/article.tex` and:
1. Replace `{PAPER_TITLE}` with the paper title
2. Replace `{AUTHOR_NAME}`, `{AUTHOR_EMAIL}`, `{AFFILIATION}` with metadata
3. Replace each `\input{sections/...}` with the converted `.tex` files
4. Extract abstract: first 150-200 words of introduction → `\begin{abstract}...\end{abstract}`
5. Write the complete document to `paper.tex`

### Preamble Verification

Ensure `paper.tex` includes all needed packages: `amsmath`, `amssymb`, `graphicx`, `natbib`,
`booktabs`, `hyperref`, `geometry`. If the template is missing a package needed by the content,
add it to the preamble.

---

## Phase 3: Silent Compilation

Run LaTeX compilation using `bash`:

```bash
pdflatex -interaction=nonstopmode -halt-on-error paper.tex 2>&1
bibtex paper 2>&1
pdflatex -interaction=nonstopmode paper.tex 2>&1
pdflatex -interaction=nonstopmode paper.tex 2>&1
```

### Error Capture

Parse the compilation log for these error types:

| Error Pattern | Category | Auto-Fix Strategy |
|---------------|----------|-------------------|
| `Undefined control sequence \X` | Missing package/typo | Search for `\X` → check if known LaTeX command → add `\usepackage` or fix typo |
| `Citation 'X' undefined` | Missing bib entry | Search `references.bib` for key `X` → fix typo or flag as missing |
| `Reference 'X' undefined` | Missing label | Search for `\label{X}` → add label or fix `\ref{}`/`\label{}` |
| `Missing \begin{document}` | Text before preamble | Move errant text into document body |
| `There's no line here to end` | Extra `\\` | Remove unnecessary line break |
| `Overfull \hbox` | Line too long | Rephrase sentence or add hyphenation |
| `Missing $ inserted` | Math mode error | Wrap math in `$...$` or escape `_` |
| `Extra }` / `Missing {` | Bracket imbalance | Count and balance `{` `}` pairs |
| `File 'X' not found` | Missing file | Check path, create placeholder, or remove `\include`/`\input` |
| `! Emergency stop` | Fatal error | Read preceding errors — fix root cause |

---

## Phase 4: Auto-Fix Loop

For each captured error, attempt automatic repair:

```
FOR each error (sorted by severity):
  1. Identify error location (line number from log)
  2. Read the surrounding context in paper.tex (±5 lines)
  3. Apply the auto-fix strategy from the table above
  4. Recompile
  5. If error persists after 2 attempts: flag as manual_fix_needed
  6. If error resolved: log the fix applied
```

**Halt conditions:**
- All errors resolved → proceed
- Only warnings remain → proceed (warnings logged)
- `manual_fix_needed` for any error → stop, report in compile_report
- Compilation produces `paper.pdf` → success

---

## Output: Compile Report

Write `compile_report.md` with: compilation result, conversion summary, per-pass error/warning
counts, errors & fixes applied table, warnings list, manual fixes required, and final verdict.

---

## Quality Gate

Before completing, verify:
- [ ] All 5 sections converted from `.md` to `.tex`
- [ ] `paper.tex` assembled with complete preamble and document body
- [ ] pdflatex executed (3 passes + bibtex)
- [ ] All `\cite{}` keys resolve (or flagged as missing with fix suggestion)
- [ ] All `\ref{}` have matching `\label{}` (or flagged)
- [ ] `paper.pdf` exists (if compilation succeeded)
- [ ] `compile_report.md` written with full diagnostics
- [ ] Any manual-fix-required items clearly documented

## Return Format

```
Status: completed
Compilation result: {SUCCESS | WARNINGS | FAILED}
PDF generated: {yes | no} — paper.pdf ({KB})
Errors auto-fixed: {N}
Warnings remaining: {M}
Manual fixes required: {K}
Artifacts produced:
  - paper.tex
  - paper.pdf (if successful)
  - compile_report.md
```
