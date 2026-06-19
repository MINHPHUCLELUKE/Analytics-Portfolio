# Term Deposit Subscription Prediction

Predicting whether a bank customer will subscribe to a term deposit following a direct marketing campaign. This is a binary classification problem using a real-world Portuguese bank marketing dataset.

---

## Problem

Banks run expensive outbound call campaigns to sell term deposits. Not every customer is worth calling — this model identifies who is likely to subscribe, so campaign resources target the right customers.

---

## Approach

- Exploratory data analysis: class imbalance, feature distributions, correlation with subscription outcome
- Feature engineering: encoding categorical variables (job, marital status, education, contact type, month), handling unknown values
- Model training and comparison: Logistic Regression, Decision Tree, Random Forest, and/or Gradient Boosting
- Evaluation: ROC-AUC, precision-recall, confusion matrix — prioritising recall on the positive class given campaign cost structure

---

## Tools

`R` or `Python` · `caret` / `scikit-learn` · `ggplot2` / `matplotlib`

---

## Output

Full analysis report: [`Predicting Term Deposit Subscription.html`](./Predicting%20Term%20Deposit%20Subscription.html)

---

## Dataset

[UCI Bank Marketing Dataset](https://archive.ics.uci.edu/ml/datasets/Bank+Marketing) — 45,000+ records, 20 features including demographic, campaign, and economic context variables.
