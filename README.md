# Data Science & Machine Learning Portfolio  

Welcome to my Data Science & Machine Learning portfolio! This repository showcases diverse projects, database expertise, machine learning models, and data visualization skills. Each project is hyperlinked for easy navigation.

---

## 🛠 Databases  

### **SQL**  
- **[📌 SQL Queries – Northwind Database ](https://github.com/DarianRodriguez/Portfolio/tree/main/SQL)**  
  **Description:** This repository showcases **advanced SQL queries** using the **Northwind database**, a sample dataset representing a **retail business** selling products worldwide. The queries cover various operations, including filtering, aggregations, ranking, and window functions.  

  **Tools:** PostgreSQL, SQL  

---

## 🧠 Machine Learning & Deep Learning 

### **Time Series Analysis & Forecasting**  
- **[📅 Stock Price Prediction](https://github.com/DarianRodriguez/Stock-Market)**  
    **Description:** This project analyzes Microsoft stock (April 2023), predicting the next day's closing price using **LSTM**, with **naïve forecasting as a baseline**. The dataset includes historical prices, technical indicators, and economic factors. Data is collected via APIs, stored in **MongoDB**, and managed through a **CRUD-based API**. Preprocessing includes outlier detection, missing value imputation, and PCA for dimensionality reduction. Results indicate that predicting with only the closing price outperforms models incorporating auxiliary data.  

    **Tools & Models:** Python, TensorFlow, LSTM, MongoDB, Node.js, PCA, Scikit-Learn


### **Regression**  
- **[🚗 Used Car Price Prediction](https://github.com/DarianRodriguez/Used-Car-Prices)**  
  **Description:** This project aims to predict **used car prices** using machine learning techniques, optimizing model performance through **Bayesian hyperparameter search** and **K-Fold cross-validation**. Extensive **feature engineering** was applied, including **handling high-cardinality categorical variables, creating new features (e.g., `is_luxury`), and transforming skewed data**. The model performs well for mid-range cars but struggles with **luxury vehicles**, which are often underpredicted due to their unique pricing patterns. 

  **Tools & Models:** Python, Scikit-learn, Optuna, Bayesian Search CV, Linear Regression, ElasticNet, Random Forest, HistGradientBoostingRegressor  

### **Classification** 

-  **[📝 Cassava Leaf Disease Classification](https://github.com/DarianRodriguez/Cassava-Leaf-Disease-Classification)**  
    **Description:** Cassava, a vital crop, is highly susceptible to viral diseases, affecting yield and food security. This project automates **cassava leaf disease classification** using **EfficientNetB3 with transfer learning**, where only the last five layers are updated. We compare **U-Net segmentation** for background removal against direct classification and explore **class imbalance handling** with **focal loss and class weights**. The best performance (F1-score: 85%) was achieved without segmentation, using categorical cross-entropy loss.  

    **Tools & Models:** Python, TensorFlow, EfficientNetB3, U-Net, Keras

- **[🩺 Medical Image Classification: PathMNIST & PneumoniaMNIST](https://github.com/DarianRodriguez/Medical-Image-Classification)**  
    **Description:** This project focuses on two medical image classification tasks: **PathMNIST** for classifying nine types of colon pathology tissues, and **PneumoniaMNIST** for pneumonia detection in chest X-rays. In the **pneumonia detection task**, models like **SVM**, **Decision Trees**, and **Random Forest** were tested on 2D images. For **PathMNIST**, which includes 3D images, we applied **Multilayer Perceptron (MLP)** and **Convolutional Neural Networks (CNN)** with various architectures. Model selection and hyperparameter tuning were performed based on metrics such as **F1-score**, **recall**, **precision**, and **ROC curves**. Results showed SVM excelled in pneumonia detection, while CNN outperformed in tissue classification.

    **Tools & Models:** Python, Scikit-learn, TensorFlow, CNN, SVM, MLP, Random Forest, Decision Trees


---

## 🗣️ Natural Language Processing (NLP)  


- **[📝 NegVerse: Generating Diverse Negations from Affirmative Sentences](https://github.com/DarianRodriguez/NegVerse)**  
  **Description:** LLMs struggle with reasoning under negation due to limited training data. **NegVerse** addresses this by generating diverse negation types (verbal, non-verbal, affixal) using **syntactic masking, prompt tuning, and filtering mechanisms**. We introduce new rules for identifying negation points, leveraging a **frozen baseline LLM** to generate negated sentences. A filtering step ensures quality, diversity, and syntactic preservation, outperforming existing methods.

  **Tools & Models:*** Python, Pytorch, spacy, LLama-2, GPT-2, Spacy, NLTK, Transformers
  
  [Read the paper](https://arxiv.org/abs/2411.00056)  

- **[💊 Adverse Drug Events (ADEs) Detection](https://github.com/DarianRodriguez/ADE_Project)**  
    **Description:** automates adverse drug event (ADE) detection using NER and relation extraction (RE). It combines in-domain transformers (BioBERT, PubMedBERT) for drug mention recognition and general-domain models (BERT) for broader language understanding. A drug-aware embedding is created to enhance adverse effect recognition, improving relation extraction. PubMedBERT achieved the highest F1 score in detecting ADEs.  

    **Tools & Models:** Python, BioBERT, PubMedBERT, BERT, PyTorch

---

## 📊 Data Visualization  
Projects focused on creating clear, insightful visualizations for decision-making and analysis.  

- **[🔍 Telco Customer Churn Analysis](https://github.com/DarianRodriguez/Portfolio/tree/main/EDAS)**  
  **Description:** Performed an extensive exploratory data analysis (EDA) on a telecom customer churn dataset to identify patterns related to service usage and customer retention. The analysis focuses on key features such as tenure, contract type, payment methods, and monthly/total charges, examining how these influence customer churn. Visualizations, correlation analysis, and insights into the relationship between different services and churn rate were explored to uncover actionable insights for improving customer retention strategies.  

  **Dataset:** [Telco Customer Churn Dataset - Kaggle](https://www.kaggle.com/datasets/blastchar/telco-customer-churn/data)  
  **Tools:** Python, Pandas, Matplotlib, Seaborn, Jupyter Notebook.


- **[📊 Power BI Sales and Performance Dashboard](https://github.com/DarianRodriguez/Portfolio/tree/main/PowerBI)**  
  **Description:** Designed an interactive Power BI dashboard for a global manufacturing company specializing in cycling equipment and accessories. The dashboard tracks key performance indicators (KPIs) including sales, revenue, profit, and returns. It enables users to compare regional performance, analyze product-level trends, and identify high-value customers. The project includes building a relational data model, creating calculated columns and measures with DAX and designing a user-friendly interface to visualize insights.  
  
  **Tools:** Power BI Desktop, DAX, SQL, Data Modeling

## 📌 End-to-End Projects  

- **[ Student Performance Prediction](https://github.com/DarianRodriguez/mlproject)**  
**Description:** This project analyzes **student performance** based on demographic and socioeconomic factors such as **gender, ethnicity, parental education, lunch type, and test preparation course**. The goal is to predict **math scores** using various regression models and understand the impact of different features on student outcomes. The model was deployed using **Flask API**, containerized with **Docker**, and integrated with **GitHub Actions for CI/CD** before deployment on **AWS EC2** via **ECR**.

  **Tools & Models:** Python, Scikit-learn, Flask, Docker, GitHub Actions, AWS EC2, ECR, Random Forest, Decision Tree, Gradient Boosting, Linear Regression, XGBoost, CatBoost, AdaBoost  
