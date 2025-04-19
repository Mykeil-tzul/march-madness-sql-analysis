# march-madness-sql-analysis
March Madness Analysis of the last 20 years of NCAA Tournament basketball.

# March Madness SQL Analysis

**Author:** Mykeil Tzul  
**Date:** April 2025

---

## 🚀 Project Overview
A ten‑query exploration of NCAA Tournament history (2016–2025) using Snowflake and the Kaggle “March Machine Learning Mania 2025” dataset. Each query answers a distinct question about team performance, upsets, seeds, and more.

---

## 📂 Repository Structure
march-madness-sql-analysis/ ├── queries/ – Ten .sql files, one per analytical question │ ├── 01_seed_final_four_appearances.sql │ ├── 02_most_championship_wins.sql │ ├── 03_avg_margin_of_victory.sql │ ├── 04_underdog_upsets.sql │ ├── 05_top5_common_scores.sql │ ├── 06_elite_eight_by_conference.sql │ ├── 07_teams_most_often_upset.sql │ ├── 08_coach_multiple_schools.sql │ ├── 09_top10_win_pct.sql │ └── 10_consecutive_appearances.sql ├── results/ – (Optional) CSV exports or screenshots of query outputs ├── .gitignore – Local files to ignore └── README.md – This documentation

yaml
Copy

---

## 🗄️ Data Source
- **Tables Used:**  
  - `MNCAATourneyCompactResults`  
  - `MNCAATourneyDetailedResults`  
  - `MNCAATourneySeeds`  
  - `MTeams`  
  - `MTeamCoaches`  
  - `MTeamConferences`  
  - `Conferences`  
- **Platform:** Snowflake (free trial)  
- **Loading Data:** Loaded from the Kaggle “March Machine Learning Mania 2025” CSVs into Snowflake tables.

---

## 🔍 Query List

| File                                       | Question                                                                 |
|-------------------------------------------|---------------------------------------------------------------------------|
| **01_seed_final_four_appearances.sql**    | Which seeds most often make the Final Four (last 10 seasons)?             |
| **02_most_championship_wins.sql**         | Which teams have won the most championships (last 10 seasons)?           |
| **03_avg_margin_of_victory.sql**          | Which teams had the highest average margin of victory (≥5 wins)?         |
| **04_underdog_upsets.sql**                | Which seed‑9+ teams pulled off the most upsets (≥2 upsets)?              |
| **05_top5_common_scores.sql**             | What are the top 5 most common total game scores, and sample games?     |
| **06_elite_eight_by_conference.sql**      | Which conferences have the most Elite Eight appearances (last 20 seasons)? |
| **07_teams_most_often_upset.sql**         | Which teams most often lose to lower‑seeded opponents?                   |
| **08_coach_multiple_schools.sql**         | Which coaches led multiple schools to the Sweet 16 or beyond?            |
| **09_top10_win_pct.sql**                  | Which schools have the top 10 tournament win percentages (≥5 games)?     |
| **10_consecutive_appearances.sql**        | Which teams boast the longest streaks of consecutive appearances?        |

---

## ⚙️ How to Run

1. **Clone** the repo:
   ```bash
   git clone https://github.com/Mykeil-tzul/march-madness-sql-analysis.git
   cd march-madness-sql-analysis
