# Minh Phuc LE: Data Analytics Portfolio

Data analyst who turns raw data into decisions with SQL and Power BI, backed by a strong statistics base in R and Python. Based in Melbourne, postgraduate student at RMIT University and open to Data Analyst roles.

Projects are grouped below: business intelligence first, then statistics, forecasting and machine learning, then business analysis and systems work.

---

## Business intelligence and automated reporting

| Project | Domain | Methods | Tools |
|---|---|---|---|
| [The Look Co.: E-commerce Analytics (SQL Server and Power BI)](https://github.com/MINHPHUCLELUKE/thelook-ecommerce-sql-powerbi) | E-commerce / Retail | T-SQL clean layer and star schema, data quality diagnostics, reconciliation checks, 74 DAX measures, like-for-like growth for a partial year, cohort retention, RFM segmentation, web funnel, inventory aging; 4-page report | SQL Server, T-SQL, Power BI, DAX |
| [Crustline: Pizza Sales Analysis (Power BI)](https://github.com/MINHPHUCLELUKE/crustline-pizza-sales-powerbi) | Food / Retail | Power Query cleaning of a raw CSV, star schema with a many-to-many ingredient bridge, 37 DAX measures, anomaly detection (2 standard deviations), price against volume correlation, order size and timing analysis; 6-page report | Power BI, Power Query, DAX |
| [CSIRO Data61: Automated Sector Productivity Reports](./csiro-data61-sector-productivity) | Labour Economics | LP decomposition (capital deepening, frontier advancement, diffusion, efficiency), quantile regression (τ=0.90), 34 threshold classifiers | R, R Markdown |

---

## Statistics, forecasting and machine learning

| Project | Domain | Methods | Tools |
|---|---|---|---|
| [Term Deposit Subscription Prediction](./term-deposit-prediction)<br>[▶ View live](https://minhphucleluke.github.io/Analytics-Portfolio/term-deposit-prediction/term-deposit-notebook.html) | Banking / ML | Pre-call targeting model (call duration excluded): 7 models in scikit-learn pipelines, tuned on ROC AUC with CV; test AUC 0.76; calling the top 20% of scored customers reaches 36% of subscribers (lift 1.8) | Python, scikit-learn |
| [Global CO₂ Concentration Time Series Analysis and Forecasting](https://github.com/MINHPHUCLELUKE/time-series-forecasting-r/tree/main/co2)<br>[📄 Read report](https://github.com/MINHPHUCLELUKE/time-series-forecasting-r/blob/main/co2/global-co2-time-series-analysis.pdf) | Environment | Stationarity testing (ADF, KPSS, PP, DF-GLS), second-order and seasonal differencing, 8 SARIMA candidates; selected SARIMA(1,2,2)(0,1,1)[12]; 10-month forecast of 430 ppm, confirmed by NOAA | R |
| [Bitcoin Index Time Series Analysis](https://github.com/MINHPHUCLELUKE/time-series-forecasting-r/tree/main/bitcoin)<br>[📄 Read report](https://github.com/MINHPHUCLELUKE/time-series-forecasting-r/blob/main/bitcoin/bitcoin-index-time-series-analysis.pdf) | Finance | Box-Cox transformation, ADF/KPSS/PP tests, ACF/PACF, EACF and BIC table, ML and CSS estimation; selected ARIMA(1,1,0) by AIC and BIC | R |
| [Storytelling with Open Data](./storytelling-with-open-data) | Data Visualisation | Narrative-first EDA, visualisation design for non-technical audience, published on RPubs | R, R Markdown |

---

## Business analysis and systems

| Project | Domain | Methods | Tools |
|---|---|---|---|
| [MedConnect AI: Healthcare Referral Prototype](./medconnect-ai-referral-prototype)<br>[▶ View live](https://minhphucleluke.github.io/Analytics-Portfolio/medconnect-ai-referral-prototype/medconnectai.html) | Healthcare | Clickable GP portal prototype with illustrative mock data; simulated AI referral matching; complete referral lifecycle; designed around Privacy Act, AHPRA, PRODA and My Health Record requirements | HTML, JavaScript |
| [Software & System Deconstruction using UML Models](./uml-booking-system-analysis) | Systems Analysis | Activity (4 swimlanes), use case, class, and state machine diagrams for Kis Hair Melbourne booking system; cancellation fee gap analysis | UML |

---

## Skills

**Languages:** SQL (T-SQL) · DAX · Power Query (M) · Python · R

**BI and data modelling:** Star schema design · Data quality diagnostics · Reconciliation checks · Power BI report design · Time intelligence

**Time series:** ARIMA · SARIMA · GARCH · STL decomposition · Box–Cox transformation · Model selection (AIC/BIC, EACF)

**Machine learning:** Logistic Regression · KNN · Decision Tree · Random Forest · SVM · Neural Networks (MLP) · Gradient Boosting · Feature selection · Cross-validation · Gains/lift analysis

**Statistical methods:** Stationarity testing (ADF, KPSS, PP, DF-GLS) · Quantile regression · Labour productivity decomposition · Hypothesis testing

**Visualisation & Reporting:** Power BI · R Markdown · ggplot2 · HTML/JavaScript dashboards · RPubs

**Tools:** SQL Server (SSMS) · Power BI Desktop · Git · RStudio · Jupyter Notebook

---

## Contact

- **Email:** minhphucle.luke@gmail.com
- **LinkedIn:** [minh-phuc-le-luke](https://www.linkedin.com/in/minh-phuc-le-luke/)
- **GitHub:** [MINHPHUCLELUKE](https://github.com/MINHPHUCLELUKE)
