# Minh Phuc Le: Data Analytics Portfolio

Data analyst who turns raw data into decisions with SQL and Power BI, backed by a strong statistics base in R and Python. Based in Melbourne, postgraduate student at RMIT University and open to Data Analyst roles.

Projects are grouped below: business intelligence first, then statistics, forecasting and machine learning, then business analysis and systems work.

---

## Business intelligence and automated reporting

| Project | Domain | Methods | Tools |
|---|---|---|---|
| [The Look Co.: E-commerce Analytics (SQL Server and Power BI)](https://github.com/MINHPHUCLELUKE/thelook-ecommerce-sql-powerbi) | E-commerce / Retail | T-SQL clean layer and star schema, data quality diagnostics, reconciliation checks, 74 DAX measures, like-for-like growth for a partial year, cohort retention, recency and frequency segmentation, web funnel, inventory aging; 4-page report | SQL Server, T-SQL, Power BI, DAX |
| [Crustline: Pizza Sales Analysis (Power BI)](https://github.com/MINHPHUCLELUKE/crustline-pizza-sales-powerbi) | Food / Retail | Power Query cleaning of a raw CSV, star schema with a snowflaked date table and a many-to-many ingredient bridge, 37 DAX measures, anomaly detection (2 standard deviations), price against volume correlation, order size and timing analysis; 6-page report | Power BI, Power Query, DAX |
| [CSIRO Data61: Automated Sector Productivity Reports](./csiro-data61-sector-productivity) | Labour Economics | Labour productivity decomposition into five drivers (capital deepening, frontier advancement, equipment diffusion, innovation diffusion, efficiency change), quantile regression frontier (τ = 0.90), rule-based written commentary | R, R Markdown |

---

## Statistics, forecasting and machine learning

| Project | Domain | Methods | Tools |
|---|---|---|---|
| [Term Deposit Subscription Prediction](./term-deposit-prediction)<br>[▶ View live](https://minhphucleluke.github.io/Analytics-Portfolio/term-deposit-prediction/term-deposit-notebook.html) | Banking / ML | Pre-call targeting model (call duration excluded): 7 models in scikit-learn pipelines, tuned on ROC AUC with CV; test AUC 0.76; calling the top 20% of scored customers reaches 36% of subscribers (lift 1.8) | Python, scikit-learn |
| [Global CO₂ Concentration Time Series Analysis and Forecasting](https://github.com/MINHPHUCLELUKE/time-series-forecasting-r/tree/main/co2)<br>[📄 Read report](https://github.com/MINHPHUCLELUKE/time-series-forecasting-r/blob/main/co2/global-co2-time-series-analysis.pdf) | Environment | Stationarity testing (ADF, KPSS, PP, DF-GLS), second-order and seasonal differencing, 8 SARIMA candidates; selected SARIMA(1,2,2)(0,1,1)[12]; 10-month forecast; its first month (430.4 ppm) matched NOAA's May 2025 reading of 430.5 ppm, and a follow-up refits the model and extends the forecast to check it against 17 months of later readings | R |
| [Bitcoin Index Time Series Analysis](https://github.com/MINHPHUCLELUKE/time-series-forecasting-r/tree/main/bitcoin)<br>[📄 Read report](https://github.com/MINHPHUCLELUKE/time-series-forecasting-r/blob/main/bitcoin/bitcoin-index-time-series-analysis.pdf) | Finance | Box-Cox transformation, ADF/KPSS/PP tests, ACF/PACF, EACF and BIC table, ML and CSS estimation; selected ARIMA(1,1,0) by AIC and BIC | R |
| [A Cautionary Tale: The $TRUMP Token Case Study](./storytelling-with-open-data)<br>[▶ View live](https://minhphucleluke.github.io/Analytics-Portfolio/storytelling-with-open-data/trump-token-dashboard.html) | Data Storytelling / Crypto | Interactive 3-page flexdashboard: price and volume timeline, volatility vs Bitcoin and Solana (3.7x Bitcoin), ownership concentration (top holder 80%), investment scenarios | R, flexdashboard, plotly |

---

## Business analysis and systems

| Project | Domain | Methods | Tools |
|---|---|---|---|
| [MedConnect AI: Healthcare Referral Prototype](./medconnect-ai-referral-prototype)<br>[▶ View live](https://minhphucleluke.github.io/Analytics-Portfolio/medconnect-ai-referral-prototype/medconnectai.html) | Healthcare | Clickable GP portal prototype with illustrative mock data; simulated AI referral matching; complete referral lifecycle; designed around Privacy Act, AHPRA, PRODA and My Health Record requirements | HTML, JavaScript |
| [Software & System Deconstruction using UML Models](./uml-booking-system-analysis) | Systems Analysis | Activity (4 swimlanes), use case, class, and state machine diagrams for Kis Hair Melbourne booking system; gap analysis and business case for payment authorisation to cut no-show losses; an updated use case diagram and an expanded use case for payment authorisation | UML, Visio |

---

## Skills

**Languages:** SQL (T-SQL) · DAX · Power Query (M) · Python · R

**BI and data modelling:** Star schema design · Data quality diagnostics · Reconciliation checks · Power BI report design · Time intelligence

**Time series:** ARIMA · SARIMA · GARCH · STL decomposition · Box–Cox transformation · Model selection (AIC/BIC, EACF)

**Machine learning:** Logistic Regression · KNN · Decision Tree · Random Forest · SVM · Neural Networks (MLP) · Gradient Boosting · Feature selection · Cross-validation · Gains/lift analysis

**Statistical methods:** Stationarity testing (ADF, KPSS, PP, DF-GLS) · Quantile regression · Labour productivity decomposition · Hypothesis testing

**Visualisation & Reporting:** Power BI · R Markdown · ggplot2 · HTML/JavaScript dashboards

**Tools:** SQL Server (SSMS) · Power BI Desktop · Git · RStudio · Jupyter Notebook

---

## Contact

- **Email:** minhphucle.luke@gmail.com
- **LinkedIn:** [minh-phuc-le-luke](https://www.linkedin.com/in/minh-phuc-le-luke/)
- **GitHub:** [MINHPHUCLELUKE](https://github.com/MINHPHUCLELUKE)
