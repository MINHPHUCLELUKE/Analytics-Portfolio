# CSIRO Data61: Automated Sector Productivity Reports

**Industry partner:** CSIRO's Data61, under the Aus4Innovation programme with Vietnam's Ministry of Science and Technology

**My role:** I led the reporting template and its rule-based commentary in a team of four.

I built an automated reporting system in R that produces a three-page technology adoption and productivity report for each of the 34 sectors of Vietnam's economy, from firm-level survey data for 2019 to 2023. One parameterised R Markdown template generates every report, with charts, tables and written analysis that adapts to each sector's numbers, so 34 consistent reports come from a single run instead of 34 manual write-ups.

> **About this page.** The code, data and rendered reports belong to the research project and are confidential, so they are not shared here. This page describes the work and the methods.

---

## Key findings

The analysis of 4.17 million firm records across 34 sectors, 2019 to 2023, surfaced these headline results:

- **108x productivity gap** between the most and least productive sectors, measured as real output per worker (Petroleum at 46,347 vs Textile at 428 million real 2019 VND per worker). Textile employs about 3 million workers, roughly one in five of Vietnam's manufacturing workforce.
- **67.6x within-sector gap** in Wholesale and Retail: the top 3% of firms against the remaining 97%, up from 50.9x in 2019. Wholesale and Retail accounts for 28% of total survey revenue.
- **Growth decomposition across all sectors:** 48.3% of aggregate productivity growth came from capital deepening, 33.1% from frontier advancement, 11.6% from equipment diffusion and 7.0% from efficiency change.
- **Equipment investment per worker** fell from index 23.8 to 7.9 between 2019 and 2023, declining in 28 of 34 sectors.
- The 2023 within-sector productivity gap ranged from 15.1x to 119.5x across sectors.

The findings and policy recommendations were presented to the CSIRO Data61 team and form part of the project's deliverables under the Aus4Innovation programme.

---

## The problem

Researchers needed comparable productivity diagnostics for every sector of the economy: how each sector is growing, how fast it adopts technology, how far its typical firms trail the leaders, and what is holding it back. Writing that by hand for 34 sectors is slow, hard to keep consistent, and has to be redone whenever the data is updated.

## What I built

- **One template, any sector.** The sector is a parameter. A batch script loads the data once and renders a report for every sector.
- **Analysis that writes itself.** Each report's commentary is generated from the sector's own results through a set of documented threshold rules: for example whether growth is capital-led or diffusion-led, or whether the main constraint is slow technology diffusion, an innovation capability gap or regional concentration.
- **Consistent and repeatable.** When the data is updated, every report is regenerated with the same logic.

## What each report covers

1. **Sector overview:** revenue and employment trends, ownership structure, firm entry and exit, labour inclusion, and productivity against the all-sector average.
2. **Technology adoption and innovation:** equipment and innovation investment adoption rates, diffusion levels, and the productivity gap between frontier firms and the rest.
3. **Labour productivity decomposition:** growth split into five drivers (capital deepening, frontier advancement, equipment diffusion, innovation diffusion and efficiency change), and the sector classified into a growth regime (capital-led, frontier-led, diffusion-led, efficiency-led or mixed).
4. **Policy insights:** the binding constraint for the sector and a closing recommendation that fits its growth regime.

## Methods

- Labour productivity decomposition into five drivers: capital deepening, frontier advancement, equipment (hard-tech) diffusion, innovation (soft-tech) diffusion and efficiency change
- Three distinct views of the frontier, each answering a different question:
  - **Frontier advancement driver:** the technology frontier change term from the project's sector decomposition, which feeds the growth regime classification
  - **Conditional frontier:** quantile regression (90th percentile, natural spline) of revenue per worker on capital intensity, fitted for 2019 and 2023 to show how far the frontier shifted
  - **Frontier versus laggard gap:** median productivity of the top 3% of firms against the remaining 97%, showing whether leaders are pulling away
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
