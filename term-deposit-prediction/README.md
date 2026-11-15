# Term Deposit Subscription Prediction

Which bank customers should a call centre phone about a term deposit? Seven classification models are trained on Portuguese bank marketing data (11,162 customers) to rank customers by their chance of subscribing, using only information known **before** the call.

Based on a university group project (three members), rebuilt and extended by Minh Phuc Le.

**[View the notebook (live)](https://minhphucleluke.github.io/Analytics-Portfolio/term-deposit-prediction/term-deposit-notebook.html)** · [Notebook source (`.ipynb`)](./term_deposit_prediction.ipynb)

---

## Key results (held-out test set, 2,233 customers)

- **Best model:** Random Forest, test ROC AUC **0.76**, accuracy **0.71**.
- **Who to call:** ranking customers by the model and calling the top 20% reaches **36% of all subscribers** with an 86% hit rate, against a 47% base rate (lift 1.8). Calling the top half reaches 71%.
- **What drives it:** month of contact, outcome of the previous campaign, housing loan, age and marital status.
- **Model choice:** Random Forest beats Logistic Regression by a small but real margin (AUC +0.013 over 10 × 5-fold CV, corrected resampled t-test p < 0.001). Gradient boosting performs about the same as Random Forest.
- **Why call duration is excluded:** it is the strongest predictor in the data, but it is only known after the call ends. Adding it to the same pipeline would lift test AUC from 0.76 to 0.91 and accuracy from 0.71 to 0.83, a score the bank could never use to choose whom to call.

---

## Method

- **Cleaning:** drop `contact`, `day`, `pdays`; merge `poutcome = other` into `failure`; all 11,162 rows kept.
- **Split:** 80/20 stratified, seed 42. The test set is used once, at the end.
- **Pipeline:** one-hot encoding + standard scaling → `SelectKBest` (k tuned) → classifier, all fit on training folds only.
- **Models:** Logistic Regression, KNN, Decision Tree, Random Forest, SVM, Neural Network (scikit-learn MLP), Gradient Boosting.
- **Tuning:** grid search with 5-fold stratified cross-validation, optimising ROC AUC.
- **Evaluation:** CV AUC, test AUC, accuracy, precision, recall, F1; ROC curves; cumulative gains; permutation importance; Nadeau and Bengio corrected resampled t-test for model comparison.

## Limitations

- This Kaggle version of the data is balanced (47% subscribed). The original UCI campaign data has about 11%, so real-world hit rates would be lower, though the ranking and lift logic still apply.
- There is no cost data. With a cost per call and a value per deposit, the gains table gives the number of customers worth calling.

---

## Run it yourself

```bash
pip install -r requirements.txt
jupyter nbconvert --to notebook --execute term_deposit_prediction.ipynb   # about 10 minutes on a laptop
```

## Data

`data/bank.csv`: Bank Marketing dataset as published on Kaggle, derived from the UCI Machine Learning Repository version (Moro, Cortez and Rita, 2014), which is licensed CC BY 4.0. 11,162 rows, 17 columns, target `deposit`.

## Files

| File | Description |
|---|---|
| `term_deposit_prediction.ipynb` | Notebook (source) |
| `term-deposit-notebook.html` | Rendered notebook |
| `data/bank.csv` | Dataset |
| `requirements.txt` | Python packages |

## Tools

`Python` · `scikit-learn` · `pandas` · `numpy` · `scipy` · `matplotlib` · `seaborn` · `Jupyter`
