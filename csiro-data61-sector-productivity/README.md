# CSIRO Data61: Automated Sector Productivity Reports

**Industry partner:** CSIRO Data61, Australia's national science and technology research agency

I built an automated reporting system in R that produces a three-page technology adoption and productivity report for each of the 34 sectors of Vietnam's economy, from firm-level survey data for 2019 to 2023. One parameterised R Markdown template generates every report, with charts, tables and written analysis that adapts to each sector's numbers, so 34 consistent reports come from a single run instead of 34 manual write-ups.

> **About this page.** The code, data and rendered reports belong to the research project and are confidential, so they are not shared here. This page describes the work and the methods.

---

## The problem

Researchers needed comparable productivity diagnostics for every sector of the economy: how each sector is growing, how fast it adopts technology, how far its typical firms trail the leaders, and what is holding it back. Writing that by hand for 34 sectors is slow, hard to keep consistent, and has to be redone whenever the data is updated.

## What I built

```mermaid
flowchart LR
    A[Firm-level survey panel<br>2019 to 2023] --> B[Cleaning and sector<br>aggregation]
    B --> C[Productivity decomposition<br>and frontier estimation]
    C --> D[Threshold rules turn<br>numbers into findings]
    D --> E[Parameterised R Markdown<br>template]
    E --> F[Batch render:<br>34 sector reports]
```

- **One template, any sector.** The sector is a parameter. A batch script loads the data once and renders a report for every sector.
- **Analysis that writes itself.** Each report's commentary is generated from the sector's own results through a set of documented threshold rules: for example whether growth is capital-led or diffusion-led, or whether the main constraint is slow technology diffusion, an innovation capability gap or regional concentration.
- **Consistent and repeatable.** When the data is updated, every report is regenerated with the same logic.

## What each report covers

1. **Sector overview:** revenue and employment trends, ownership structure, firm entry and exit, labour inclusion, and productivity against the all-sector average.
2. **Technology adoption and innovation:** equipment and innovation investment adoption rates, diffusion levels, and the productivity gap between frontier firms and the rest.
3. **Labour productivity decomposition:** growth split into capital deepening, frontier advancement, technology diffusion and efficiency change, and the sector classified into a growth regime (capital-led, frontier-led, diffusion-led, efficiency-led or mixed).
4. **Policy insights:** the binding constraint for the sector and a closing recommendation that fits its growth regime.

## Methods

- Labour productivity decomposition into five drivers
- Quantile regression (90th percentile, natural spline) to estimate the conditional productivity frontier
- Frontier versus laggard gap analysis (top 3% of firms against the remaining 97%)
- Cohort panel analysis of how persistent equipment investment is
- Rule-based text generation from quantitative thresholds
- Regional mapping by province

## Data

- **Source:** Vietnam Enterprise Survey, a firm-level panel aggregated to 34 economic sectors
- **Period:** 2019 to 2023
- **Units:** real 2019 Vietnamese dong, so growth figures are net of inflation
- **Not shared:** the survey microdata is not public and remains with the project

## Tools

`R` · `R Markdown` · `dplyr` · `ggplot2` · `quantreg` · `sf` · `glue` · `knitr`
