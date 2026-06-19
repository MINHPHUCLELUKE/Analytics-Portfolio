# Solar Radiation Forecasting and Property Price Correlation

Two-part study: (1) forecasting solar radiation output using time series methods, and (2) investigating whether solar radiation levels correlate with residential property prices — a proxy for liveability, solar panel feasibility, or energy cost effects on housing demand.

---

## Approach

**Part 1 — Solar Radiation Forecasting**
- Decomposition of solar radiation series (trend, seasonality, irregular)
- ARIMA/SARIMA model fitting for multi-step-ahead forecasts
- Forecast accuracy assessment

**Part 2 — Property Price Correlation**
- Alignment of solar radiation and property price datasets by region and time period
- Correlation and regression analysis: controlling for confounders (location, property type, economic conditions)
- Interpretation: does solar exposure explain variation in property prices beyond standard hedonic factors?

---

## Tools

`R` · `forecast` · `ggplot2` · `lm` / regression packages

---

## Output

Full analysis report: [`Solar Radiation Forecasting and Property Price Correlation_MinhPhucLE.pdf`](./Solar%20Radiation%20Forecasting%20and%20Property%20Price%20Correlation_MinhPhucLE.pdf)
