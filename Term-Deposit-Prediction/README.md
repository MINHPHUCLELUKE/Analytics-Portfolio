# Term Deposit Subscription Prediction

MATH2319 Phase 2 group project (Group 28). Six classification models are trained and compared on a stratified sample of Portuguese bank marketing data to predict whether a customer will subscribe to a term deposit after an outbound call campaign.

**Team:** Alfred Chan (s3990477) · Minh Phuc Le (s3916144) · Anh Le Thuy Nhat (s3927359)

---

## Dataset

- **Source:** Bank Marketing Dataset (Kaggle)
- **Original size:** 11,162 records · 17 features
- **Working sample:** 5,000 records (random seed = 42, stratified)
- **Target variable:** `deposit` — binary (yes / no)
- **Features removed:** `contact`, `day`, `pdays` (uninformative or structurally missing)
- **Final feature count:** 15 predictors after cleaning

---

## Phase 1 Key Findings (EDA)

Customers more likely to subscribe: tertiary education · single marital status · no existing loans. Call duration is the single strongest predictor; previous campaign outcome is a significant secondary signal.

---

## Phase 2 — Modelling

**Data preparation**
- One-hot encoding for categorical variables
- StandardScaler normalisation
- 80:20 stratified train-test split
- Feature selection: SelectKBest with ANOVA F-statistics (`f_classif`), top 10 features retained

**Models trained and compared**
- Logistic Regression
- K-Nearest Neighbors (KNN)
- Decision Tree
- Random Forest
- Support Vector Machine (SVM)
- Neural Network (Keras / TensorFlow)

**Evaluation**
- Accuracy and AUC on held-out test set
- 5-fold cross-validation
- Paired t-tests for pairwise statistical significance between models

---

## Tools

`Python` · `scikit-learn` · `TensorFlow` / `Keras` · `pandas` · `numpy` · `matplotlib` · `seaborn`

---

## Output

Full Jupyter notebook export: [`Predicting-Term-Deposit-Subscription.html`](./Predicting-Term-Deposit-Subscription.html)
