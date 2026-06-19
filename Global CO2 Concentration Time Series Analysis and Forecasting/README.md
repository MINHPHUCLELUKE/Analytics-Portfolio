# Global CO₂ Concentration — Time Series Analysis and Forecasting

Analysis and forecasting of global atmospheric CO₂ concentration — one of the most closely watched environmental time series, characterised by a strong long-term upward trend and a pronounced annual seasonal cycle.

---

## Approach

- Data sourcing: Mauna Loa Observatory or equivalent global CO₂ measurement series
- Classical decomposition: isolating the long-run trend from the seasonal Keeling Curve pattern
- Stationarity testing and differencing
- ARIMA/SARIMA model selection (auto.arima or manual ACF/PACF analysis)
- Long-horizon forecasting with confidence intervals
- Discussion of implications: rate of increase, comparison against pre-industrial baselines

---

## Tools

`R` · `forecast` · `tseries` · `ggplot2`

---

## Output

Full analysis report: [`Global CO2 Concentration Time Series Analysis and Forecasting_MinhPhucLE.pdf`](./Global%20CO2%20Concentration%20Time%20Series%20Analysis%20and%20Forecasting_MinhPhucLE.pdf)
