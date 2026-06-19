# Climate-Responsive Time Series Forecasting

Three-task MATH1307 Forecasting final project applying distributed lag models, dynamic regression, and intervention analysis to real ecological and public health time series. Rainfall is identified as the dominant climate predictor across all three tasks.

---

## Task 1 — Mortality Forecasting, Paris

- **Data:** 508 weekly mortality observations from Paris (2010 onwards)
- **Predictors:** temperature, chem1, chem2, particle size
- **Models compared:** Finite DLM, Polynomial DLM, ARDL, Koyck, `dynlm`, ETS, State-space
- **Best model:** `dynlm` — lowest MASE and most honest uncertainty quantification
- **Forecast uncertainty (avg CI width):** dynlm 62.91 deaths · ARDL 49.96 · Finite DLM 37.35 (underestimates)

---

## Task 2 — First Flowering Day (FFD) Forecasting

- **Data:** 81 Australian plant species (Hudson & Keatley 2021), annual 1984–2014 (31 years)
- **Predictors:** rainfall, temperature, radiation, relative humidity
- **Best model:** `dynlm(Rainfall)` — MASE = 0.163, R² = 0.99
- **Forecast result:** Flowering predicted ~26 days earlier (≈8.6% earlier) in 2015–2018 vs the 1984–2014 baseline of 306.4 days
- **Forecast CI width:** 121 days at h=1 (2015) → 242 days at h=4 (2018)

---

## Task 3 — Flowering Order Similarity (RBO) with Millennium Drought Intervention

- **Data:** Rank Biased Overlap (RBO) similarity of flowering order, annual 1984–2014; RBO range 0.6629–0.8424
- **Models compared:** DLM, ARDL, Koyck, Polynomial DLM, `dynlm` + step and ramp interventions for the Millennium Drought (1996–2009)
- **Best model:** `dynlm(Rainfall)` + drought step intervention — MASE = 0.2582
- **Forecast 2015–2017:** Mean RBO ≈ 0.704, below the historical average of 0.738, indicating incomplete post-drought recovery
- **CI width:** 0.167 (h=1) → 0.289 (h=3)

---

## Key Finding

Rainfall is the consistently dominant climate predictor across all three biological and human-health tasks. Climate variability measurably shapes both ecological phenology and human mortality outcomes in ways that lagged linear models can quantify.

---

## Tools

`R` · `dynlm` · `forecast` · `TSA` · `ggplot2` · `dplyr`

---

## Output

Full report (398 pages) with R code: [`Climate-Responsive Time Series_Forecasting_Minh-Phuc-LE.pdf`](./Climate-Responsive%20Time%20Series_Forecasting_Minh-Phuc-LE.pdf)
