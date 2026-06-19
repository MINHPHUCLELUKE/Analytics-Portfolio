# Combined 3-Page Sector Report. Interpretation Logic Reference

Companion to `all_3page_sector_report_template_complete_combined.Rmd`.

This file catalogues every conditional sentence, threshold, and classifier used in the analytical notes across all four parts of the report. The goal is to make logic editable without reading R code, and to make any change to a threshold or branch traceable to a single place.

Conventions used below.

* `pp` denotes percentage points.
* "Share" thresholds in Part III are share of total labour productivity growth (`driver_value / gLP_check`).
* Variable names match chunk names in the Rmd so you can locate the source quickly.
* All decomposition variables reference `gLP_check` (arithmetic sum of the five driver components), not `gLP_macro` (directly measured macro rate).

---

## 1. Helpers used everywhere

### `safe_divide(numerator, denominator)`
Returns `NA_real_` if denominator is `NA` or zero. Safe for scalar inputs. Do not use inside `dplyr::mutate()` with a scalar denominator and a vector numerator — `ifelse()` will truncate the result to length 1 and dplyr will silently recycle it. Use direct division (`value / denominator`) inside `mutate()` instead.

### `format_change(x, unit = "pct")`
Renders a coloured inline arrow and signed number. Green up arrow if `x >= 0`, red down arrow otherwise. `unit = "pct"` for percentage changes, `unit = "pp"` for percentage-point changes.

### `growth_strength(x)`
Plain-English magnitude label used inside glue sentences.

| Condition | Label |
|---|---|
| `is.na(x)` | "showed limited measurable change" |
| `x >= 0.20` | "increased strongly" |
| `x >= 0.05` | "increased moderately" |
| `x > -0.05` | "remained broadly stable" |
| `x > -0.20` | "declined moderately" |
| otherwise | "declined strongly" |

### `interp(text)`
Renders a styled interpretation box in the HTML output. Every analytical note is wrapped in this call.

---

## 2. Part I: Sector Overview

### 2.1 Revenue and Employment Trends (Section 1.1)

#### Benchmark position: `rev_ratio_msg`

Input: `rev_ratio = revenue_per_firm / all_sector_avg_revenue_per_firm`.

| Condition | Phrase |
|---|---|
| `rev_ratio >= 1` | "`<n>`x the all-sector average" |
| otherwise | "`<pct>` of the all-sector average" |

#### Benchmark movement over the period: `benchmark_gap_msg`

Inputs: `rev_ratio_base` (base year), `rev_ratio` (snapshot year).

| Condition | Sentence |
|---|---|
| `is.na(rev_ratio_base)` or `is.na(rev_ratio)` | silent (empty string) |
| `rev_ratio > rev_ratio_base + 0.2` | "The sector's revenue advantage over the all-sector average widened (from `<n>`x in `<base>` to `<n>`x in `<snap>`), indicating that the sector expanded its relative economic footprint." |
| `rev_ratio < rev_ratio_base - 0.2` | "The sector's revenue position relative to the all-sector average narrowed (from `<n>`x to `<n>`x), suggesting other sectors grew faster over the period." |
| otherwise | "The sector's revenue position relative to the all-sector average remained broadly stable across the period." |

The ±0.2 band treats a ratio movement of less than 0.2x as noise rather than a structural shift.

#### Revenue-vs-employment divergence: `revenue_labour_msg`

Inputs: `v1_stats$revenue_growth`, `v1_stats$labour_growth` (proportional growth rates over the full period).

| Condition | Sentence |
|---|---|
| `revenue_growth > labour_growth + 0.05` | "Revenue grew materially faster than employment, consistent with improving revenue intensity and rising labour productivity at the sector level." |
| `labour_growth > revenue_growth + 0.05` | "Employment expanded faster than revenue, suggesting the sector absorbed labour without equivalent productivity gains over the period." |
| otherwise | "Revenue and employment grew at broadly similar rates, indicating stable revenue per worker rather than productivity improvement." |

The ±5 pp threshold treats smaller divergences as noise within the measurement error of the survey.

---

### 2.2 Five-Year Revenue Share by Ownership (Section 1.3)

#### Benchmark gap: `gap_dominant_msg`

Input: `gap_dominant = dominant_owner$revenue_share - all_sector_dominant_share`.

| Condition | Phrase |
|---|---|
| `gap_dominant > 0` | "`<pct>` percentage points above the all-sector benchmark" |
| otherwise | "`<pct>` percentage points below the all-sector benchmark" |

#### Structural ownership interpretation: `structural_ownership_msg`

Input: dominant ownership type and its revenue share.

| Condition | Sentence |
|---|---|
| `dominant == "FDI"` and share `> 0.50` | "FDI-dominated revenue structures typically bring higher capital intensity and technology exposure, but may limit domestic capability spillovers if supplier linkages with local firms are weak." |
| `dominant == "SOE"` and share `> 0.50` | "State-owned enterprise dominance often reflects regulated or capital-intensive activities; productivity performance in such sectors tends to depend heavily on reform of managerial incentives rather than investment volume alone." |
| `dominant == "Domestic private firms"` and share `> 0.50` | "A domestic-private-led revenue structure places firms that face competitive market pressure at the centre of the sector; productivity gains tend to be driven by selection, entry and capability upgrading rather than by state direction." |
| otherwise | "The mixed ownership profile means productivity dynamics are shaped by interactions between firm types with different incentive structures, investment horizons and technology access." |

The 50% threshold marks outright majority. Below 50%, the TRUE branch fires regardless of who leads, because no single ownership type commands a structural majority.

---

### 2.3 Firm Entry and Exit Dynamics (Section 1.4)

#### Entry-vs-exit: `entry_exit_msg`

Input: `firm_2023$entry`, `firm_2023$exit` (counts in snapshot year).

| Condition | Sentence |
|---|---|
| `entry > exit` | "Entry exceeded exit, suggesting positive firm renewal and sector attractiveness." |
| otherwise | "Exit exceeded entry, indicating restructuring pressure or consolidation within the sector." |

#### Output trajectory: `output_direction`

Input: `firm_2023$output_index` (sector output index, base year = 100).

| Condition | Phrase |
|---|---|
| `output_index >= 100` | "expanded to an index of `<n>` (`<base>` = 100)" |
| otherwise | "contracted to an index of `<n>` (`<base>` = 100)" |

#### Renewal-vs-output narrative: `renewal_narrative`

Inputs: `corr_firm_output` (Pearson correlation between active-firm count and output index across all years), `avg_annual_churn_v3` = mean of `(entry + exit) / total_active_firms` for years after the base year.

Let `high_churn = (avg_annual_churn_v3 >= 0.10)`, `pos_corr = (corr > 0.5)`, `neg_corr = (corr < -0.5)`.

| Condition | Sentence |
|---|---|
| `pos_corr & high_churn` | "Across the period, firm count and output moved together with high churn, consistent with renewal driving output: new entrants reshaped the productive base while aggregate revenue expanded." |
| `pos_corr & !high_churn` | "Firm count and output moved together against a broadly stable firm population, consistent with incumbent-led growth rather than renewal-driven expansion." |
| `neg_corr` | "Firm count and output moved in opposite directions across the period, suggesting restructuring: consolidation among fewer, more productive firms sustained performance while total firm numbers declined." |
| `is.na(corr_firm_output)` | "The relationship between firm population dynamics and aggregate output could not be assessed with available data." |
| otherwise | "Firm count and output moved largely independently, suggesting the link between firm renewal and aggregate performance was weak across the period." |

The 0.5 correlation threshold and 10% churn threshold are set conservatively so the classifier fires only when the signal is strong enough to support a directional claim.

---

### 2.4 Labour Inclusion and Productivity Performance (Section 1.5)

#### Productivity gap trend: `prod_trend_msg`

Inputs: `prod_gap = sector_LP - all_sector_LP` in snapshot year; `prod_gap_base` = same measure in base year.

| Condition | Sentence |
|---|---|
| `is.na(prod_gap_base)` or `is.na(prod_gap)` | silent (empty string) |
| `prod_gap > 0 & prod_gap_base <= 0` | "The sector has moved from below to above the economy average in productivity since the base year, recovering a deficit recorded in the base year." |
| `prod_gap > 0 & prod_gap_base > 0 & prod_gap > prod_gap_base` | "The sector's productivity advantage over the economy average has strengthened since the base year." |
| `prod_gap > 0 & prod_gap <= prod_gap_base` | "The sector retains a productivity advantage but it has narrowed relative to the base year." |
| `prod_gap < 0 & prod_gap > prod_gap_base` | "The sector remains below the economy average but has been closing the gap, indicating catch-up dynamics." |
| `prod_gap < 0 & prod_gap <= prod_gap_base` | "The sector's productivity shortfall relative to the economy average has deepened since the base year." |
| otherwise | silent (empty string) |

The transition branch (`prod_gap_base <= 0` and `prod_gap > 0`) is evaluated first so that a below-to-above crossing is not mislabelled as "advantage strengthened."

#### Inclusion quadrant: `inclusion_msg`

Inputs: `prod_gap` (sign indicates above/below average LP), `female_gap = sector_female_share - all_sector_female_share`.

| Condition | Sentence |
|---|---|
| `prod_gap >= 0 & female_gap >= 0` | "Above-average productivity alongside above-average female labour share suggests the sector combines economic performance with broad workforce participation, a favourable combination from both efficiency and inclusion perspectives." |
| `prod_gap >= 0 & female_gap < 0` | "Above-average productivity but below-average female labour share may reflect capital- or skill-intensive activity with limited workforce inclusion. Policies that widen access without diluting capability could address both dimensions." |
| `prod_gap < 0 & female_gap >= 0` | "Below-average productivity despite above-average female labour inclusion suggests employment concentration in lower-productivity activities; capability upgrading is the more binding lever than further workforce expansion." |
| otherwise | "Below-average performance on both productivity and female inclusion indicates a sector where capability investment and active workforce participation policy are both warranted." |

The zero boundary is used for both gaps — exactly at the all-sector average triggers the above-average branch. This is deliberate: a sector at the exact benchmark is no worse than average and should not attract a deficit label.

---

## 3. Part II: Technology Adoption and Innovation Dynamics

### 3.1 KPI Snapshot (Section 2.1)

#### Innovation-share benchmark: `innov_benchmark_msg`

Inputs: `innov_share_of_total = innovation_investment / total_investment` in snapshot year; `all_innov_share_snap` = same ratio economy-wide.

| Condition | Sentence |
|---|---|
| either `NA` | "The all-sector innovation share benchmark is unavailable." |
| `innov_share_of_total > all_innov_share_snap + 0.02` | "This is above the all-sector average of `<pct>`, indicating above-average emphasis on capability-led investment relative to the broader economy." |
| `innov_share_of_total < all_innov_share_snap - 0.02` | "This is below the all-sector average of `<pct>`, suggesting the sector remains more reliant on physical capital than the broader economy." |
| otherwise | "This is broadly in line with the all-sector average of `<pct>`." |

The ±2 pp band protects against reporting a difference that could arise from rounding differences in the sector aggregation.

---

### 3.2 Investment Scale and Adoption Diffusion (Section 2.2)

#### Equipment-vs-innovation adoption gap: `adoption_gap_msg`

Input: `adoption_gap_pp_v1 = abs(equip_rate_2023 - innov_rate_2023) * 100`.

| Condition | Sentence |
|---|---|
| `adoption_gap_pp_v1 <= 5` | "Equipment and innovation adoption rates are closely matched, suggesting firms treat the two investment types as complementary rather than substitutes." |
| `equip_rate_2023 > innov_rate_2023 + 0.05` | "Equipment adoption is materially higher than innovation adoption (`<pct>` vs `<pct>`), consistent with a sector still in an earlier upgrading phase where hardware investment leads capability development." |
| `innov_rate_2023 > equip_rate_2023 + 0.05` | "Innovation adoption is materially higher than equipment adoption (`<pct>` vs `<pct>`), suggesting firms are emphasising intangible capability ahead of physical hardware, an advanced adoption profile." |
| otherwise | silent (empty string) |

Both thresholds map to 5 pp: branch 1 uses `<= 5` on the percentage-point scale; branches 2 and 3 use `+ 0.05` on the rate scale. Using `<=` in branch 1 prevents a silent empty string at exactly 5 pp.

#### Overall diffusion level: `diffusion_level_msg`

Input: `max(equip_rate_2023, innov_rate_2023)`.

| Condition | Sentence |
|---|---|
| `max < 0.10` | "Overall adoption remains very limited, with the large majority of firms not investing in either category." |
| `max < 0.20` | "Adoption is still in early diffusion across both categories, with most firms not yet participating in either type of investment." |
| `max < 0.40` | "Adoption has reached moderate breadth in at least one category, suggesting technology investment is beginning to move beyond early adopters." |
| otherwise | "Adoption is relatively broad-based across at least one investment type, indicating technology investment has diffused well beyond a narrow group of early adopters." |

Bands at 10%, 20%, and 40% mark early-stage, growth-stage, and broad diffusion respectively.

---

### 3.3 Investment Allocation Mix (Section 2.3)

#### Dominant category interpretation: `investment_mix_msg`

Input: `dominant_investment$Investment category` (category with highest share in snapshot year).

| Condition | Sentence |
|---|---|
| `"Machinery and equipment"` | "This indicates a stronger focus on hard-technology adoption and physical capital upgrading." |
| `"Innovation Investment"` | "This indicates a stronger emphasis on innovation capability, R&D, and soft-technology investment." |
| otherwise | "Investment is directed primarily toward infrastructure, construction, or maintenance activities." |

#### Innovation share trend: `innov_trend_sentence`

Inputs: `innov_share_base`, `innov_share_snap` (innovation as share of total investment in each year), `innov_trend_pp = (innov_share_snap - innov_share_base) * 100`.

| Condition | Sentence |
|---|---|
| `is.na(innov_trend_pp)` | silent (empty string) |
| otherwise | "The innovation investment share `<rose/fell>` from `<pct>` in `<base>` to `<pct>` in `<snap>` (`<signed pp>` percentage points), indicating `<a growing / a shrinking>` role for innovation relative to physical capital." |

---

### 3.4 Frontier vs Laggard Gap (Section 2.4)

Frontier firms are defined as those in the top 3% of the firm-productivity distribution within the sector in each year (`productivity_rank >= 0.97`). Labels used in the chart and pivot: `"Frontier: top 3%"` and `"Laggard: remaining 97%"`.

#### Gap trend direction: `gap_trend`

Inputs: `prod_ratio_base_val` and `prod_ratio_val` (frontier-to-laggard productivity ratio in base and snapshot years).

| Condition | Phrase |
|---|---|
| both available and `prod_ratio_val > prod_ratio_base_val` | "widened" |
| both available and `prod_ratio_val <= prod_ratio_base_val` | "narrowed" |
| either `NA` | "could not be trended with available data" |

#### Gap magnitude interpretation: `gap_msg`

Input: `prod_ratio_val`.

| Condition | Sentence |
|---|---|
| `prod_ratio_val > 10` | "The large gap points to substantial unevenness, with a small frontier cohort capturing a disproportionate share of sector productivity." |
| otherwise | "The productivity gap is present but less extreme, suggesting some degree of capability diffusion across the sector." |

The 10x threshold is deliberately conservative. It fires only when the gap is severe enough to constitute a major structural statement.

#### Binding diffusion constraint: `binding_gap_msg`

Inputs: `equip_ratio_val`, `innov_ratio_val` (frontier-to-laggard ratios for equipment and innovation investment intensity).

| Condition | Sentence |
|---|---|
| either `NA` | "The two diffusion gaps could not be compared with available data." |
| `equip_ratio_val > innov_ratio_val + 0.5` | "The larger gap is in equipment intensity, pointing to capital and financing constraints as the more binding barrier when laggard firms attempt to upgrade machinery." |
| `innov_ratio_val > equip_ratio_val + 0.5` | "The larger gap is in innovation intensity, pointing to skills, organisational capability and digital readiness as the more binding constraint on laggard firm catch-up." |
| otherwise | "The equipment-intensity and innovation-intensity gaps are of similar magnitude, indicating that capital and capability constraints likely operate together rather than one dominating the other." |

---

### 3.5 Equipment Investment Cohort Panel (Section 2.5)

#### First-year investing rate message: `early_msg`

Input: `early_rate` = fraction of balanced-panel firms that had invested in equipment by their first investment year.

| Condition | Sentence |
|---|---|
| `is.na(early_rate)` | silent (empty string) |
| `early_rate > 0.5` | indicates "strong" early penetration |
| otherwise | indicates "moderate" early penetration |

#### Cohort trajectory: `cohort_trajectory_msg`

Inputs: `latest_cohort_rate` and `early_rate`.

| Condition | Sentence |
|---|---|
| either `NA` | "Cohort trajectory could not be compared with available data." |
| `latest_cohort_rate > early_rate` | "Later cohorts show higher sustained investment rates than earlier cohorts, suggesting that cumulative learning or improved access is raising investment persistence over time." |
| otherwise | "Earlier cohorts show higher sustained investment rates than later cohorts, which may indicate that the most committed investors entered first while later entrants are less persistent." |

#### Panel representation: `panel_rep_msg`

Input: `never_count` = firms in the balanced panel that never invested in equipment.

| Condition | Sentence |
|---|---|
| `never_count == 0` | "All balanced-panel firms invested in equipment at some point across the period." |
| `never_count / panel_total > 0.50` | "More than half of balanced-panel firms never invested in equipment across the full observation window, indicating that non-adoption is the dominant pattern among persistent firms." |
| otherwise | "A minority of balanced-panel firms never invested in equipment, suggesting that non-adoption persists among a subset of incumbents even after several years in the sector." |

---

## 4. Part III: Labour Productivity Decomposition

### 4.1 Regime Classifier and Shares (chunk `s3-decomp-prep`)

#### Growth regime: `regime_decomp`

Inputs: `gLP_check` (total LP growth = arithmetic sum of five drivers), and the five driver shares.

| Priority | Condition | Label |
|---|---|---|
| 0 | `is.na(gLP_check)` or `gLP_check <= 0` | "contraction" |
| 1 | `capital_share > 0.50` | "capital-led" |
| 2 | `frontier_share > 0.40` | "frontier-led" |
| 3 | `diffusion_share > 0.40` | "diffusion-led" |
| 4 | `efficiency_share > 0.40` | "efficiency-led" |
| 5 | otherwise | "mixed" |
| fallback | `have_decomp == FALSE` | "unavailable" |

Capital deepening uses a 50% threshold because it represents a single channel claiming majority of all growth. The other four channels each use 40% because they represent sub-channels of TFP, and 40% within the total means dominance within the TFP block. The "contraction" guard is evaluated first: without it, dividing a negative driver value by a negative total would produce a positive share and incorrectly fire "capital-led" or another growth-mode label.

---

### 4.2 Average Driver Contributions — Waterfall (Section 3.1)

#### Diffusion-versus-frontier balance: `diff_frontier_msg`

Inputs: `diffusion_share = (g_equip_change + g_inno_change) / gLP_check`, `frontier_share = g_tech_change / gLP_check`.

| Condition | Sentence |
|---|---|
| either `NA` | (not checked — safe_divide returns NA and branches evaluate to FALSE) |
| `diffusion_share > frontier_share + 0.10` | "Diffusion-related drivers contributed `<pct>` of growth vs `<pct>` from frontier change, meaning capability is spreading across the firm distribution faster than leading firms are advancing the boundary." |
| `frontier_share > diffusion_share + 0.10` | "Technology Frontier Change contributed `<pct>` of growth vs `<pct>` from diffusion, meaning leading firms are advancing faster than the broader sector can absorb, a pattern that tends to widen the frontier-laggard gap over time." |
| otherwise | "Frontier change (`<pct>`) and diffusion (`<pct>`) contributed in broadly similar magnitudes, indicating a relatively balanced productivity structure with neither channel dominating." |

The 10 pp gap threshold ensures the diffusion/frontier contrast is only reported when the imbalance is strong enough to carry a policy implication.

#### Regime description: `regime_msg`

Driven by `regime_decomp`. Each value maps to a one-paragraph explanation.

| Regime | Core message |
|---|---|
| "capital-led" | Growth relies heavily on rising capital per worker and faces diminishing returns unless complemented by capability upgrading. |
| "frontier-led" | Leading firms carry a large share of productivity improvement, creating risk of widening within-sector gaps if diffusion does not keep pace. |
| "diffusion-led" | Adoption and capability spread are central to growth; gains are reaching a wider set of firms rather than concentrating at the frontier. |
| "efficiency-led" | Resource allocation and operational performance are the main growth channels; gains are real but bounded once easy efficiency improvements are captured. |
| "mixed" | No single driver fully dominates; no single policy lever in isolation is likely to materially shift the productivity trajectory. |
| otherwise (data issue) | "The sector's growth regime could not be classified reliably from the available decomposition data." |

---

### 4.3 Year-by-Year Driver Dynamics — Stacked Bar (Section 3.2)

#### Diffusion trend: `diffusion_trend_msg`

Inputs: `diffusion_2020 = g_equip_change + g_inno_change` in 2020; `diffusion_2023` = same in 2023.

| Condition | Sentence |
|---|---|
| either `NA` | "The diffusion trend across the period could not be measured." |
| `diffusion_2023 > diffusion_2020 + 0.5` | "Combined diffusion contributions strengthened from `<n>` pp in 2020 to `<n>` pp in 2023, suggesting broader technology absorption as the period progressed." |
| `diffusion_2023 < diffusion_2020 - 0.5` | "Combined diffusion contributions declined from `<n>` pp in 2020 to `<n>` pp in 2023, indicating that adoption gains were concentrated in the early years." |
| otherwise | "Diffusion contributions remained broadly stable across the period (from `<n>` pp to `<n>` pp), indicating a consistent but not accelerating absorption capacity." |

The ±0.5 pp movement threshold avoids claiming a trend when the year-on-year swing is smaller than typical measurement noise.

#### Year-to-year volatility: `volatility_msg`

Input: `lp_range = LP_best_val - LP_worst_val`.

| Condition | Sentence |
|---|---|
| `lp_range > 5` | "The range between the best and worst year exceeds 5 percentage points, indicating high year-to-year volatility in the sector's productivity trajectory." |
| `lp_range > 2` | "Moderate year-to-year variation in labour productivity growth suggests the sector's performance is sensitive to annual shocks rather than following a smooth structural trend." |
| otherwise | "Relatively stable year-to-year variation indicates that the sector's growth structure is consistent rather than driven by year-specific shocks." |

---

### 4.4 Conditional Productivity Frontier (Section 3.3)

The frontier is estimated by quantile regression at tau = 0.90 with a natural spline (df = 3) fit to `revenue_per_worker ~ capital_intensity`. The early year is 2019, the late year is 2023. Firms above the 97th percentile of the productivity or capital distribution are trimmed before fitting. Minimum sample requirement: 30 observations in each year.

#### Frontier shift message: `frontier_msg`

Input: `frontier_mid_change = (frontier_mid_late / frontier_mid_early) - 1`, measured at the mid-range of the capital-intensity distribution (45th–55th percentile of `k_pw`).

| Condition | Sentence |
|---|---|
| `!is.na(frontier_mid_change) & frontier_mid_change > 0` | "The conditional frontier shifted upward by approximately `<pct>` around the mid-range of capital intensity." |
| otherwise | "The conditional frontier did not clearly shift upward around the mid-range of capital intensity." |

#### Industry average message: `avg_msg`

Input: `avg_lp_change = (avg_late$y_avg / avg_early$y_avg) - 1`.

| Condition | Sentence |
|---|---|
| `avg_lp_change > 0` | "The labour-weighted industry average output per worker also increased by `<pct>`, while average capital per worker changed by `<pct>`." |
| otherwise | "The labour-weighted industry average output per worker did not materially improve, despite a `<pct>` change in average capital per worker." |

#### Structural interpretation: `structural_interp_msg`

Inputs: `frontier_mid_change`, `avg_lp_change`.

| Condition | Sentence |
|---|---|
| `is.na(frontier_mid_change)` | "The frontier shift cannot be assessed from available data." |
| `frontier_mid_change > 0.10 & avg_lp_change > 0` | "Both the frontier and the industry average improved. If the frontier outpaced the average, this is consistent with a wide and stable leader-laggard gap, signalling that diffusion is not fully keeping pace with frontier advancement." |
| `frontier_mid_change > 0.10 & avg_lp_change <= 0` (or NA) | "The frontier shifted upward but the industry average did not improve materially: the clearest signal of a diffusion constraint: leading firms are advancing while most firms are not." |
| `frontier_mid_change <= 0 & avg_lp_change > 0` | "The industry average improved despite a flat or declining frontier, consistent with catch-up by laggard firms rather than frontier-driven growth." |
| otherwise | "Neither the frontier nor the industry average showed clear improvement, suggesting the sector's productivity structure was broadly stagnant over the period." |

The 10% frontier movement threshold separates a real upward shift from a flat or ambiguous one.

---

## 5. Part IV: Summary Highlights and Policy Insights

### 5.1 NA-guard design for highlight blocks (`s4-highlights`)

All decomposition-dependent and potentially missing values in the highlight grid are pre-formatted as safe strings before the `structure_blocks` list is built. Each string substitutes "not available" when its source is `NA`.

| String variable | Source | Used in block |
|---|---|---|
| `frontier_gap_highlight_str` | `frontier_gap_latest` | "Frontier and laggard gap" |
| `lp_growth_str` | `lp_growth_avg` (= `gLP_check` when available) | "Productivity growth engine" |
| `dom_value_str` | `dominant_value` | "Productivity growth engine" |
| `dom_share_str` | `dominant_share` | "Productivity growth engine" |
| `dom_owner_share_str` | `dominant_owner_share` | "Ownership structure" |

---

### 5.2 Frontier Gap Trend (`s4-prep`, C1)

#### `frontier_trend_msg`

Inputs: `frontier_gap_base` (frontier-to-laggard ratio in base year, computed from `sector_df`); `frontier_gap_latest` (same measure in snapshot year, drawn from `frontier_year_metrics` if available, otherwise recomputed from `sector_df`).

| Condition | Phrase |
|---|---|
| either `NA` | "not available across both years" |
| `frontier_gap_latest > frontier_gap_base * 1.15` | "widened from `<n>`x in `<base>` to `<n>`x in `<snap>`, indicating that diffusion from leading firms to the wider sector has not kept pace with frontier advancement" |
| `frontier_gap_latest < frontier_gap_base * 0.85` | "narrowed from `<n>`x in `<base>` to `<n>`x in `<snap>`, indicating that laggard firms are catching up and diffusion mechanisms are working" |
| otherwise | "remained broadly stable between `<n>`x in `<base>` and `<n>`x in `<snap>`, suggesting the frontier-laggard structure is entrenched rather than converging" |

The ±15% band means a gap must move by more than 15% of its base-year value to be classified as widening or narrowing. This prevents reclassification from measurement noise.

---

### 5.3 Hard-Tech / Soft-Tech / Efficiency Split (`s4-prep`, C2)

#### Technology diffusion type: `diffusion_type_msg`

Inputs: `hd_value = g_equip_change`, `sd_value = g_inno_change` (both in pp, from `decomp_avg`).

| Condition | Sentence |
|---|---|
| either `NA` | silent (empty string) |
| `hd_value > sd_value + 0.5` | "Within adoption, equipment investment (hard-tech diffusion) was the larger channel, pointing to capital-embodied upgrading that may not yet be matched by organisational and capability development." |
| `sd_value > hd_value + 0.5` | "Within adoption, innovation investment (soft-tech diffusion) was the larger channel, a relatively advanced pattern where capability and management practices are outpacing physical equipment as productivity drivers." |
| otherwise | "Hard-tech (equipment) and soft-tech (innovation) diffusion contributed in roughly similar proportions, indicating a balanced adoption profile." |

#### Efficiency change sign: `effi_sign_msg`

Input: `effi_value = g_effi_change` (pp).

| Condition | Sentence |
|---|---|
| `is.na(effi_value)` | silent (empty string) |
| `effi_value < -0.5` | "Efficiency change was negative (`<n>` percentage points): laggard firms are falling further behind best-practice operations, acting as a drag on aggregate productivity that management and organisational improvement could address." |
| `effi_value > 0.5` | "Efficiency change was positive (`<n>` percentage points): laggard firms are closing the gap to frontier operating standards, a healthy sign that soft capabilities are diffusing alongside investment." |
| otherwise | "Efficiency change was near zero (`<n>` percentage points): laggard firm performance relative to best practice has not materially improved or deteriorated." |

Both thresholds use ±0.5 pp to distinguish a meaningful efficiency change from near-zero.

---

### 5.4 Policy Constraint Diagnosis (`s4-policy`, C3)

#### Boolean constraint flags

Three binary flags are computed first and feed into `main_constraint`.

| Flag | Condition |
|---|---|
| `diffusion_constraint` | `have_decomp` AND `frontier_gap_latest > 5` AND `diffusion_share < 0.30` |
| `innovation_constraint` | `innovation_investment_share < 0.20` AND `adoption_snapshot$innov_rate < 0.20` |
| `regional_constraint` | `top_equip_province$rate > adoption_snapshot$equip_rate * 1.5` |

#### Main constraint classifier: `main_constraint`

`case_when` evaluated top-down; first TRUE branch wins.

| Priority | Condition | Label |
|---|---|---|
| 1 | `diffusion_constraint` | "diffusion bottleneck" |
| 2 | `innovation_constraint` | "innovation capability constraint" |
| 3 | `regime_decomp == "capital-led"` | "capital-heavy growth with capability absorption risk" |
| 4 | `regime_decomp == "frontier-led"` | "frontier-led growth with spillover risk" |
| 5 | `regime_decomp == "diffusion-led"` | "diffusion-led growth that requires scaling support" |
| 6 | `regime_decomp == "efficiency-led"` | "efficiency-led growth with management and allocation constraints" |
| 7 | `regional_constraint` | "regional diffusion gap" |
| otherwise | | "mixed productivity constraint" |

Diffusion and innovation constraints are evaluated before regime labels because they are based on quantitative thresholds that override the regime classification when the signal is clear.

#### Creation-vs-adoption framing: `adoption_gap_framing`

Inputs: `creation_share = g_tech_change / gLP_check`, `diffusion_share`.

| Condition | Appended sentence |
|---|---|
| either `NA` | silent (empty string) |
| `creation_share < 0.10 & diffusion_share < 0.30` | "Both frontier advancement and adoption diffusion are constrained: the sector faces a dual gap where neither the creation of new technological capacity nor the spread of existing practices is generating strong momentum." |
| `creation_share < 0.10 & diffusion_share >= 0.30` | "Diffusion is the primary productivity engine but frontier creation is limited. Gains depend on spreading existing technology rather than generating new capability, sustainable in the short run but exposed to exhaustion of the adoptable stock." |
| `creation_share >= 0.40 & diffusion_share < 0.20` | "A frontier-diffusion imbalance: leading firms are advancing but the broader sector cannot absorb these advances. The bottleneck is diffusion capacity (absorption capability, skills and finance), not the supply of technology." |
| otherwise | silent (empty string) |

#### FDI spillover risk: `fdi_spillover_risk`

Boolean flag. Fires only when all three conditions hold simultaneously: `dominant_owner == "FDI"` AND `dominant_owner_share > 0.50` AND `regime_decomp == "capital-led"`. Adds a dedicated paragraph to the policy box when TRUE.

#### NA-guard for policy box display

Before `cat(glue(...))`, five safe display strings are pre-computed:

| String variable | Source |
|---|---|
| `regime_decomp_str` | `regime_decomp` (shows "not available (no decomposition data)" when `have_decomp == FALSE`) |
| `frontier_gap_str` | `frontier_gap_latest` |
| `diffusion_share_str` | `diffusion_share` |
| `effi_str` | `effi_value` |
| `innov_invest_str` | `innovation_investment_share` |

Each substitutes "not available" when its source is `NA`.

---

### 5.5 Strategic Closing Statement (Section 4.3)

Driven by `regime_decomp`. Seven branches.

| Regime | Core closing theme |
|---|---|
| "capital-led" | Transition from capital accumulation toward capability upgrading; diminishing returns to physical investment; FDI dependence risk. |
| "frontier-led" | Whether frontier firms can act as engines of broader capability diffusion; spillover mechanisms; supplier linkage. |
| "diffusion-led" | Risk of diffusion channel losing momentum as adoptable stock exhausts; need to pair diffusion support with fresh frontier innovation. |
| "efficiency-led" | Gains are real but bounded; need to transition toward technology intensity before efficiency catch-up is exhausted. |
| "contraction" | Diagnose shock vs structural shift before applying growth-mode policies; preserve firm capability during contraction. |
| "unavailable" | Data limitation notice directing readers to pages 1–2 as the primary evidence base. |
| otherwise (TRUE) | Mixed-regime narrative: sector at a structural transition point; identify the emerging dominant channel before the leapfrogging window closes. |

The TRUE branch is reserved exclusively for genuinely mixed regimes. The "unavailable" branch is explicit to prevent a data-absent sector from silently receiving a mixed-regime narrative.

---

## 6. Threshold Summary Table

For quick scanning when tuning the report.

| Logic | Threshold | Location |
|---|---|---|
| Revenue benchmark movement | ±0.2x ratio | Section 1.1 `benchmark_gap_msg` |
| Revenue-vs-employment divergence | ±5 pp growth rate | Section 1.1 `revenue_labour_msg` |
| Majority ownership threshold | 50% revenue share | Section 1.3 `structural_ownership_msg` |
| Renewal-vs-output correlation | ±0.5 | Section 1.4 `renewal_narrative` |
| High-churn threshold | 10% annual churn | Section 1.4 `renewal_narrative` |
| LP gap: above-to-below transition | `prod_gap_base <= 0` | Section 1.5 `prod_trend_msg` |
| Innovation share benchmark band | ±2 pp | Section 2.1 `innov_benchmark_msg` |
| Adoption gap: closely matched | ≤ 5 pp | Section 2.2 `adoption_gap_msg` |
| Adoption gap: materially different | > 5 pp (i.e. `+ 0.05` on rate scale) | Section 2.2 `adoption_gap_msg` |
| Adoption diffusion level bands | 10%, 20%, 40% of firms | Section 2.2 `diffusion_level_msg` |
| LP gap — large vs moderate | 10x | Section 2.4 `gap_msg` |
| Investment intensity gap | ±0.5x | Section 2.4 `binding_gap_msg` |
| LP gap trend (widening/narrowing) | ±0.5x from base | (Section 2.4 uses directional, no band) |
| Capital-led regime | KD share > 50% | Section 3.1 `regime_decomp` |
| Frontier, diffusion, efficiency regimes | respective share > 40% | Section 3.1 `regime_decomp` |
| Diffusion-vs-frontier imbalance | ±10 pp share difference | Section 3.1 `diff_frontier_msg` |
| Diffusion trend (strengthening/fading) | ±0.5 pp | Section 3.2 `diffusion_trend_msg` |
| LP growth volatility | 2 pp, 5 pp range | Section 3.2 `volatility_msg` |
| Frontier shift (material upward) | > 10% ratio change | Section 3.3 `structural_interp_msg` |
| HD vs SD diffusion balance | ±0.5 pp driver value | Section 4 `diffusion_type_msg` |
| Efficiency change sign | ±0.5 pp | Section 4 `effi_sign_msg` |
| Frontier gap trend (widening/narrowing) | ±15% of base-year ratio | Section 4 `frontier_trend_msg` |
| Diffusion constraint flag | gap > 5x AND diffusion share < 30% | Section 4 `diffusion_constraint` |
| Innovation constraint flag | innov share < 20% AND innov rate < 20% | Section 4 `innovation_constraint` |
| Regional concentration flag | top province > 1.5x sector average | Section 4 `regional_constraint` |
| Creation-adoption dual gap | creation < 10%, diffusion < 30% | Section 4 `adoption_gap_framing` |
| Creation-adoption frontier imbalance | creation >= 40%, diffusion < 20% | Section 4 `adoption_gap_framing` |
| FDI spillover risk | FDI majority AND capital-led | Section 4 `fdi_spillover_risk` |

Adjusting any threshold flows through to all 34 sector renders on the next batch run. Review calibration against the full distribution of sector values before changing.

---

## 7. How to Extend

Adding a new conditional branch requires three steps.

1. Compute the input variable in the same chunk where the note is produced. Assign `NA` defaults explicitly for any case where the required data is absent (decomp, frontier, etc.).
2. Build a `case_when` or `if_else` block that returns a character string. Ensure the TRUE fallback always produces valid output, never an NA.
3. Insert the fragment into the `interp(glue(...))` or `cat(glue(...))` call at the appropriate position.

When adding a decomposition-dependent variable to the policy box or highlight grid, add a corresponding safe display string to the pre-computation block above `structure_blocks` or above the `cat(glue(...))` call in `s4-policy`. Pattern: `my_str <- if (!is.na(my_val)) format(my_val) else "not available"`.

When adjusting `regime_decomp` branches, preserve the priority order. "contraction" must remain first to prevent positive-share mislabelling on sectors with negative total LP growth.

When adjusting `main_constraint` branches, note that `diffusion_constraint` and `innovation_constraint` take precedence over regime labels by design. A new constraint flag should be inserted above the regime branches if it is meant to override regime-based classification.
