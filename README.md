# Netflix ELT Project — Data Cleaning & Analysis (SQL Server + Python)

This project demonstrates an **end-to-end ELT (Extract → Load → Transform)** workflow using the Netflix Titles dataset.  
Data was extracted and loaded via Python, then all **data cleaning and transformation was done in SQL Server** before analysis.

---

## 📌 Project Overview
- **Extract:** Downloaded the dataset from Kaggle.  
- **Load:** Inserted raw data into SQL Server using Python (pandas + SQLAlchemy).  
- **Transform:** Cleaned and standardized the dataset entirely in SQL Server.  
- **Analyze:** Ran SQL queries to explore and generate business insights.  

---

## 🛠️ Tech Stack
- **Python:** pandas, sqlalchemy, pyodbc  
- **SQL Server:** for cleaning and analysis  
- **Dataset:** [Netflix Movies and TV Shows](https://www.kaggle.com/shivamb/netflix-shows)  

---

## ⚙️ Steps Performed
1. **Extract & Load**
   - Downloaded `netflix_titles.csv` from Kaggle.
   - Loaded dataset into SQL Server table `netflix_raw` (all text columns defined as `NVARCHAR` to preserve multilingual data).

2. **Transform (Cleaning in SQL Server)**
   - Handled missing values in `director`, `cast`, `country`.  
   - Converted `date_added` into proper `DATE` format.  
   - Standardized `duration` into minutes (for Movies) and seasons (for TV Shows).  
   - Trimmed spaces, fixed inconsistent values.  
   - Split multi-valued columns (`listed_in`, `cast`, `country`) using `STRING_SPLIT` for analysis.  

3. **Analysis**
   - Movies vs TV Shows count.  
   - Content additions by year.  
   - Top genres on Netflix.  
   - Most frequent directors and actors.  
   - Country-wise content distribution.  

---

## 📊 Key Insights
- Netflix’s catalog grew rapidly after 2015.  
- Movies dominate the platform compared to TV Shows.  
- Dramas, International Movies, and Documentaries are among the top genres.  
- The US and India are leading countries producing Netflix content.  
- Certain directors and actors appear frequently in the catalog.  
