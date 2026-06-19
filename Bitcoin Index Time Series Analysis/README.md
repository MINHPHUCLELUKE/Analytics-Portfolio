# Bitcoin Index Time Series Analysis

Time series analysis and multi-step-ahead forecasting of Bitcoin's monthly price index (Aug 2011 – Jan 2025, 162 observations). The project follows a full ARIMA pipeline: pre-processing, stationarity diagnostics, model identification via multiple tools, estimation, residual diagnostics, and forecast comparison.

---

## Data

- **File:** `assignment2Data2025.csv`
- **Period:** August 2011 – January 2025 (162 monthly observations)
- **Series:** Bitcoin price index (USD)
- **Summary stats:** Mean ≈ $19.78M · SD ≈ $27.96M · Min $3,987.5 · Max $128,015,000 · Skewness 1.66

---

## Methods

**Pre-processing**
- STL decomposition to separate trend, seasonal, and irregular components
- Box–Cox transformation (λ ≈ 0, i.e. log) to stabilise variance
- First-order differencing to achieve stationarity

**Stationarity diagnostics**
- Augmented Dickey-Fuller (ADF), KPSS, and Phillips-Perron (PP) tests at each stage

**Model identification**
- ACF / PACF plots on the differenced log-series
- Extended ACF (EACF) table
- BIC table via `armasubsets` to compare candidate orders

**Candidates evaluated:** ARIMA(0,1,1), ARIMA(0,1,2), ARIMA(1,1,0), ARIMA(1,1,1), ARIMA(1,1,2), ARIMA(1,1,4), ARIMA(2,1,1), ARIMA(2,1,2)

**Models retained after residual diagnostics and Ljung-Box tests:**
ARIMA(1,1,0) · ARIMA(0,1,1) · ARIMA(2,1,2)

**Best model: ARIMA(1,1,0)**
Lowest AIC/BIC; most parsimonious. All three retained models produced near-identical forecast accuracy: MASE ≈ 0.175–0.176.

---

## Key Finding

Bitcoin prices are strongly non-stationary with pronounced heteroscedasticity. Box–Cox log transformation and first-order differencing are both necessary before modelling. ARIMA(1,1,0) — a first-order autoregressive process on the differenced log-price — is selected as the preferred model on parsimony grounds.

---

## Tools

`R` · `tseries` · `forecast` · `TSA` · `lmtest` · `ggplot2` · `dplyr` · `zoo` · `psych` · `knitr` · `kableExtra`

---

## Output

Full report with R code appendix: [`Bitcoin Index Time Series Analysis_MinhPhucLE.pdf`](./Bitcoin%20Index%20Time%20Series%20Analysis_MinhPhucLE.pdf)
