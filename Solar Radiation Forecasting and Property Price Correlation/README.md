# Solar Radiation Forecasting and Property Price Correlation

Two-part study combining multi-model solar radiation forecasting with a rigorous spurious correlation investigation using prewhitening techniques.

---

## Part 1 — Solar Radiation Forecasting

- **Data:** Monthly solar radiation + precipitation (data1.csv); future precipitation 2015–2016 as external regressor (data.x.csv)
- **Forecast horizon:** 2 years ahead (January 2015 – December 2016)
- **Models compared:** SARIMA · ARIMAX · Holt-Winters Additive · HW Multiplicative · HW Additive Damped · ETS(A,A,A) · ETS(A,Ad,A) · ETS(M,A,M) (8-model ensemble)

**Best model: Holt-Winters Multiplicative** (lowest MASE)
- Conservative forecast: mean 7.98 W/m² · 95% CI [2.6, 14.5 W/m²]
- 8-model ensemble mean: 14.15 W/m² · seasonal amplitude 19.62 W/m²
- Seasonal correlations >0.87 across all models; absolute disagreements up to 7.5 W/m² at peak periods

**Mathematical equivalences confirmed:**
- HW Additive Damped ≡ ETS(A,Ad,A)
- HW Additive ≡ ETS(A,A,A)

---

## Part 2 — Spurious Correlation: Melbourne Property Prices vs Victorian Population Change

- **Data:** 54 quarterly observations, Q3 2003 – Q4 2016
- **Raw Pearson correlation:** r = 0.697 (apparently strong positive relationship)
- **After prewhitening** (AR(4) filter on property prices + seasonal and first differencing): correlation drops to ~0.2
- **CCF analysis:** Cross-correlation drops from 0.7 to within ±0.2 after prewhitening at all lags

**Conclusion:** The correlation is entirely spurious — both series share a common upward trend, but there is no genuine economic relationship between Melbourne property prices and Victorian population change.

---

## Tools

`R` · `forecast` · `TSA` · `ggplot2` · `dplyr`

---

## Output

Full report with R code (87 pages): [`Solar Radiation Forecasting and Property Price Correlation_MinhPhucLE.pdf`](./Solar%20Radiation%20Forecasting%20and%20Property%20Price%20Correlation_MinhPhucLE.pdf)
