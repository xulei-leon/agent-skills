---
name: markdown-to-html
description: Convert Markdown documents into offline single-file HTML slide decks with embedded CSS/SVG, browser preview support, and reliable A4 landscape PDF export. Use when the user asks to transform Markdown, notes, reports, analysis docs, or structured text into HTML slides, printable decks, or PDF-ready browser presentations.
---

# MarkDown to HTML

Use this skill to turn an existing Markdown document into a complete single-file HTML slide deck. Preserve the source meaning and structure while improving page layout, readability, and PDF export stability.

## Core Rules

- Output a complete HTML file, not a fragment.
- Keep all CSS inside `<style>`.
- Keep all SVG inline; do not use external SVG files.
- Do not use external images, fonts, CSS, JS, iframes, or CDNs unless the user explicitly requests them.
- Preserve the Markdown document's core conclusions, hierarchy, evidence boundaries, and important labels.
- Do not invent facts, data, examples, claims, chapters, or conclusions.
- Convert long prose into slide-friendly short paragraphs, bullets, cards, tables, and comparison blocks without changing meaning.
- If content is unsupported or missing, use explicit placeholders such as `[data needed]`, `[evidence needed]`, or `[to confirm]`.

## Workflow

1. Read the Markdown source and identify its title, section hierarchy, tables, lists, quotes, code blocks, and key conclusions.
2. Split the document into slides. Prefer one core idea per slide.
3. Map Markdown structure to slide structure:
   - `#`: cover or chapter slide.
   - `##`: main slide title.
   - `###`: in-slide group, card, or column heading.
   - unordered lists: bullet lists, cards, or checklists.
   - ordered lists: process lines, step cards, or phase bars.
   - tables: HTML tables, comparison grids, or card matrices.
   - blockquotes: callout boxes or key judgment blocks.
   - code blocks: readable `<pre>` blocks with wrapping and max height.
4. Generate a complete offline HTML file using the slide shell below.
5. Add print CSS for A4 landscape export.
6. If content overflows, split the slide instead of shrinking global font sizes below readability.

## HTML Shell

Use a two-layer slide structure. `.slide` controls preview ratio and page breaks. `.stage` is the actual page canvas.

```html
<!doctype html>
<html lang="zh-CN">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Deck Title</title>
  <style>
    /* inline CSS */
  </style>
</head>
<body>
  <main class="deck">
    <section class="slide cover" id="slide-1" data-slide="1">
      <div class="stage">
        <svg class="deco" viewBox="0 0 600 360" aria-hidden="true">...</svg>
        <header class="slide-header">
          <div class="eyebrow">Section Label</div>
          <h1>Slide Title</h1>
        </header>
        <div class="slide-body">...</div>
        <footer class="slide-footer">
          <span>Source</span>
          <span>1 / N</span>
        </footer>
      </div>
    </section>
  </main>
</body>
</html>
```

## Base CSS

Use this CSS pattern as the default for browser preview and PDF-ready layout:

```css
:root {
  --bg: #eef4f1;
  --ink: #13231f;
  --muted: #5f6f6a;
  --line: #d8e2de;
  --brand: #0f766e;
  --brand-strong: #134e4a;
  --accent: #c9973a;
  --paper: #fbfdfb;
  --code: #10201d;
}

* { box-sizing: border-box; }

html,
body {
  margin: 0;
  background: var(--bg);
  color: var(--ink);
  font-family: "Microsoft YaHei", "PingFang SC", "Noto Sans SC", Arial, sans-serif;
}

body { min-height: 100vh; }

.deck {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 28px;
  padding: 28px;
}

.slide {
  width: min(96vw, 1280px);
  aspect-ratio: 16 / 9;
  page-break-after: always;
  break-after: page;
}

.stage {
  position: relative;
  width: 100%;
  height: 100%;
  overflow: hidden;
  background: var(--paper);
  border: 1px solid rgba(19, 78, 74, 0.18);
  box-shadow: 0 20px 60px rgba(19, 35, 31, 0.18);
  padding: 44px 56px 42px;
  border-radius: 6px;
  display: grid;
  grid-template-rows: auto 1fr auto;
}

.deco {
  position: absolute;
  right: 0;
  top: 0;
  width: 43%;
  height: 43%;
  pointer-events: none;
}

.slide-header {
  position: relative;
  z-index: 1;
  border-bottom: 2px solid var(--line);
  padding-bottom: 16px;
  margin-bottom: 18px;
}

.eyebrow {
  font-size: 20px;
  line-height: 1.2;
  color: var(--brand);
  font-weight: 700;
  letter-spacing: 0;
}

.slide h1 {
  margin: 8px 0 0;
  font-size: 42px;
  line-height: 1.12;
  color: var(--brand-strong);
  letter-spacing: 0;
  max-width: 1050px;
}

.cover h1 { font-size: 58px; max-width: 900px; }
.chapter h1 { font-size: 60px; }

.slide-body {
  position: relative;
  z-index: 1;
  min-height: 0;
  overflow: hidden;
  font-size: 23px;
  line-height: 1.48;
}

.slide-body p { margin: 0 0 14px; }
.slide-body ul,
.slide-body ol { margin: 0 0 16px 1.2em; padding: 0; }
.slide-body li { margin: 0 0 8px; }

.slide-footer {
  position: relative;
  z-index: 1;
  display: flex;
  justify-content: space-between;
  align-items: center;
  border-top: 1px solid var(--line);
  padding-top: 12px;
  margin-top: 16px;
  color: var(--muted);
  font-size: 15px;
}
```

## Tables And Code

Use fixed table layout and wrapping to prevent PDF overflow:

```css
.table-wrap {
  width: 100%;
  overflow: hidden;
  margin: 0 0 16px;
}

table {
  width: 100%;
  border-collapse: collapse;
  table-layout: fixed;
  background: white;
  border: 1px solid var(--line);
  font-size: 18px;
  line-height: 1.34;
}

th,
td {
  border: 1px solid var(--line);
  padding: 10px 11px;
  vertical-align: top;
  word-break: break-word;
}

th {
  background: #e8f3ef;
  color: var(--brand-strong);
  font-weight: 800;
}

.medium-table table { font-size: 16px; }
.wide-table table { font-size: 13.5px; line-height: 1.28; }
.wide-table th,
.wide-table td { padding: 7px; }

pre {
  margin: 0 0 16px;
  background: var(--code);
  color: #e7f2ef;
  border-radius: 8px;
  padding: 18px 20px;
  font-family: Consolas, "Courier New", monospace;
  font-size: 18px;
  line-height: 1.35;
  white-space: pre-wrap;
  word-break: break-word;
  max-height: 590px;
  overflow: hidden;
}
```

## Print CSS

For reliable PDF export, prefer A4 landscape in print mode even if the screen preview is 16:9:

```css
@media print {
  @page {
    size: A4 landscape;
    margin: 0;
  }

  html,
  body {
    width: 297mm;
    height: 210mm;
    margin: 0;
    background: white;
    -webkit-print-color-adjust: exact;
    print-color-adjust: exact;
  }

  .deck {
    display: block;
    width: 297mm;
    padding: 0;
  }

  .slide {
    width: 297mm;
    height: 210mm;
    aspect-ratio: auto;
    margin: 0;
    break-after: page;
    page-break-after: always;
  }

  .stage {
    border: 0;
    border-radius: 0;
    box-shadow: none;
    padding: 30px 38px 28px;
  }

  .slide-header {
    padding-bottom: 12px;
    margin-bottom: 14px;
  }

  .eyebrow { font-size: 22px; }
  .slide h1 { font-size: 48px; max-width: 1120px; }
  .cover h1 { font-size: 66px; }
  .chapter h1 { font-size: 68px; }

  .slide-body {
    font-size: 26px;
    line-height: 1.42;
  }

  .slide-body p { margin-bottom: 12px; }
  .slide-body li { margin-bottom: 7px; }

  table { font-size: 20px; }
  .medium-table table { font-size: 18px; }
  .wide-table table { font-size: 15.5px; }
  .wide-table th,
  .wide-table td { padding: 6px; }
  th,
  td { padding: 9px 10px; }

  pre {
    font-size: 20px;
    max-height: 620px;
  }

  .slide-footer {
    font-size: 17px;
    padding-top: 10px;
    margin-top: 12px;
  }

  .nav,
  .print-note {
    display: none !important;
  }

  a {
    color: inherit;
    text-decoration: none;
  }
}
```

## Layout Heuristics

- Use one slide per core idea.
- Keep body content to roughly 3-5 bullets when possible.
- Use two columns for comparisons.
- Use left/right contrast for "is / is not" or boundary content.
- Use three cards for A/B/C routes.
- Use a matrix or warning cards for risks and assumptions.
- Use a flow line or stage bar for steps and timelines.
- Use status chips for evidence levels or decision states.
- For dense content, prefer columns, cards, or split slides over tiny text.
- If a table or code block is too large, split it into continuation slides and mark the continuation in the title or a small label.

## Final Output

When the user asks for the generated HTML content directly, output only the complete HTML and no Markdown fences or explanatory text. When writing a file in a workspace, create or update the target `.html` file and summarize the path plus any verification performed.
