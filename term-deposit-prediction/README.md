# Term Deposit Subscription Prediction

Which bank customers should a call centre phone about a term deposit? Seven classification models are trained on Portuguese bank marketing data (11,162 customers) to rank customers by their chance of subscribing **before** they are called.

This started as a university group project (three members, shared here by Minh Phuc Le). I later revised it to fix target leakage and other evaluation problems in the original. Both versions are kept so the change is visible.

**[View the revised notebook (live)](https://minhphucleluke.github.io/Analytics-Portfolio/term-deposit-prediction/term-deposit-revised.html)** · [Notebook source (`.ipynb`)](./term_deposit_revised.ipynb) · [Original coursework version (live)](https://minhphucleluke.github.io/Analytics-Portfolio/term-deposit-prediction/term-deposit-notebook.html)

---

## Key results (held-out test set, 2,233 customers)

| | Original coursework | Revised (pre-call) |
|---|---|---|
| Uses call duration | Yes | **No** |
| Data | 5,000-row sample | All 11,162 rows |
| Best model | Random Forest / Logistic Regression | Random Forest |
| Accuracy | 0.79 | **0.71** |
| ROC AUC | 0.87 (CV) | **0.76** (test), 0.76 (CV) |

- **The original score was inflated by leakage.** Adding call duration back into the same pipeline lifts test AUC from 0.76 to 0.91 and accuracy from 0.71 to 0.83. But call duration is only known after the call ends, so a model that uses it cannot choose whom to call.
- **The honest model is still useful.** Ranking customers by the pre-call model and calling the top 20% reaches **36% of all subscribers** with an 86% hit rate, against a 47% base rate (lift 1.8). Calling the top half reaches 71%.
- **What drives it:** month of contact, outcome of the previous campaign, housing loan, age and marital status.
- **Model choice:** Random Forest beats Logistic Regression by a small but real margin (AUC +0.013 over 10 × 5-fold CV, corrected resampled t-test p < 0.001). Gradient boosting performs about the same as Random Forest.

---

## What changed from the original, and why

| Problem in the original | Why it matters | Fix |
|---|---|---|
| `duration` (and features built from it) used as predictors | Leakage: duration is known only after the call, and it largely reflects the outcome | Removed; a "with duration" run is kept only to measure the gap |
| `SelectKBest` fit on all rows before the train/test split | The test set influenced feature choice | Encoding, scaling, feature selection and model are one scikit-learn `Pipeline`, fit on training folds only |
| Neural network tuned on test-set accuracy | Optimistic test score | All tuning by 5-fold CV on the training set; test set used once |
| Grid search optimised accuracy | Accuracy at a 0.5 cut-off is not how calls are allocated | Tuned on ROC AUC; added a gains (lift) table |
| 5,000-row sample | Discards over half the data | Full 11,162 rows |
| Plain paired t-test on 5 folds | Overconfident, folds share training data | Nadeau and Bengio corrected resampled t-test on 10 × 5-fold CV |

---

## Method (revised notebook)

- **Cleaning (as in Phase 1):** drop `contact`, `day`, `pdays`; merge `poutcome = other` into `failure`.
- **Split:** 80/20 stratified, seed 42.
- **Pipeline:** one-hot encoding + standard scaling → `SelectKBest` (k tuned) → classifier.
- **Models:** Logistic Regression, KNN, Decision Tree, Random Forest, SVM, Neural Network (scikit-learn MLP, replacing the original Keras model), Gradient Boosting.
- **Evaluation:** CV AUC, test AUC, accuracy, precision, recall, F1; ROC curves; cumulative gains; permutation importance.

## Limitations

- This Kaggle version of the data is balanced (47% subscribed). The original UCI campaign data has about 11%, so real-world hit rates would be lower, though the ranking and lift logic still apply.
- There is no cost data. With a cost per call and a value per deposit, the gains table gives the number of customers worth calling.

---

## Run it yourself

```bash
pip install -r requirements.txt
jupyter nbconvert --to notebook --execute term_deposit_revised.ipynb   # about 10 minutes on a laptop
```

## Data

`data/bank.csv`: Bank Marketing dataset as published on Kaggle, derived from the UCI Machine Learning Repository version (Moro, Cortez and Rita, 2014), which is licensed CC BY 4.0. 11,162 rows, 17 columns, target `deposit`.

## Files

| File | Description |
|---|---|
| `term_deposit_revised.ipynb` | Revised, leak-free notebook (source) |
| `term-deposit-revised.html` | Rendered revised notebook |
| `term-deposit-notebook.html` | Original coursework notebook (kept for comparison) |
| `data/bank.csv` | Dataset |
| `requirements.txt` | Python packages |

## Tools

`Python` · `scikit-learn` · `pandas` · `numpy` · `scipy` · `matplotlib` · `seaborn` · `Jupyter`
