# Global CO₂ Concentration — Time Series Analysis and Forecasting

Full SARIMA modelling pipeline applied to the Mauna Loa Observatory CO₂ record — analysing a decade of atmospheric data, selecting among ARIMA, SARIMA, and GARCH model families, and forecasting when CO₂ will cross the 430 ppm threshold.

---

## Data

- **Source:** Mauna Loa Observatory (NOAA)
- **Period:** April 2015 onwards (~10 years of monthly observations, ~120 obs)
- **Summary stats:** Mean 413.534 ppm · SD 7.671 · Min 397.82 · Max 429.64 · Range 31.82 ppm over 10 years

---

## Methods

**Pre-processing and diagnostics**
- STL decomposition to separate long-run trend from annual seasonal cycle
- Stationarity tests: ADF, KPSS, Phillips-Perron (PP), DF-GLS
- Lag scatter plots at lags 1, 6, 12, 24 to visualise serial dependence

**Model identification**
- ACF / PACF plots on the differenced series
- Extended ACF (EACF) table
- BIC-based model comparison

**Model families evaluated**
- Non-seasonal ARIMA
- Seasonal ARIMA (SARIMA)
- GARCH volatility models

**Best model: SARIMA(1,2,2)(0,1,1)[12]**
Two orders of differencing (one non-seasonal, one seasonal) required to achieve stationarity.

---

## Key Finding

CO₂ exhibits a strong, consistent upward trend overlaid with a regular seasonal cycle (driven by Northern Hemisphere vegetation). SARIMA is necessary — non-seasonal ARIMA is insufficient. GARCH models are not needed (residual volatility is homoscedastic). The selected SARIMA(1,2,2)(0,1,1)[12] model forecasts CO₂ reaching 430 ppm within 10 months of the study end.

---

## Tools

`R` · `tseries` · `forecast` · `TSA` · `rugarch` · `seasonal` · `x13binary` · `urca` · `lmtest` · `ggplot2` · `dplyr` · `zoo` · `readr` · `knitr` · `kableExtra`

---

## Output

Full report with R code appendix (68 pages): [`Global CO2 Concentration Time Series Analysis and Forecasting_MinhPhucLE.pdf`](./Global%20CO2%20Concentration%20Time%20Series%20Analysis%20and%20Forecasting_MinhPhucLE.pdf)
