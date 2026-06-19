# CSIRO Data61 — Automated Sector Productivity Report

**Client/Organisation:** CSIRO Data61 (Australia's national science and technology research agency)

This project delivers an automated, parameterised R Markdown reporting system that generates three-page sector productivity reports across multiple industry sectors. A single Rmd template renders consistent, data-driven analytical narratives for any sector passed to it, replacing manual write-ups with conditional logic tied to quantitative thresholds.

---

## What It Does

The report covers four analytical parts per sector:

1. **Sector Overview** — Revenue and employment trends, ownership structure, firm entry/exit dynamics, labour inclusion and productivity benchmarking against the all-sector average.
2. **Technology Adoption and Innovation** — KPI snapshots, equipment vs innovation investment adoption rates, diffusion levels, frontier-vs-laggard productivity gaps.
3. **Labour Productivity Decomposition** — Decomposes productivity growth into five drivers: capital deepening, frontier advancement, technology diffusion (equipment and innovation), and efficiency change. Classifies each sector into a growth regime (capital-led, frontier-led, diffusion-led, efficiency-led, or mixed).
4. **Policy Insights** — Diagnoses the binding constraint (diffusion bottleneck, innovation capability gap, capital-heavy growth, regional concentration) and provides a strategic closing statement tailored to the sector's regime.

---

## Methods

- Labour productivity decomposition (arithmetic driver decomposition)
- Quantile regression (tau = 0.90, natural spline) for conditional productivity frontier estimation
- Frontier-laggard gap analysis (top 3% vs remaining 97% of firm productivity distribution)
- Cohort panel analysis of equipment investment persistence
- Conditional text generation via 34 threshold-based classifiers (fully documented in `2026-06-09-combined-3page-interpretation-logic.md`)

---

## Tools

`R` · `R Markdown` · `dplyr` · `ggplot2` · `quantreg` · `glue` · `knitr`

---

## Files

| File | Description |
|---|---|
| `all_3page_sector_report_template_complete_combined.Rmd` | Main parameterised report template |
| `2026-05-28-batch_render_3page.R` | Batch rendering script — loops over all sectors and renders one HTML report per sector |
| `2026-06-09-combined-3page-interpretation-logic.md` | Full reference for every conditional sentence, threshold, and classifier used in the analytical notes |
| `all_3page_sector_report_template_complete_combined.html` | Sample rendered output |
