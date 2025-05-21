# 🏀 March Madness SQL Analysis

**Author:** Mykeil Tzul  
**Date:** April 2025

A deep-dive SQL analysis of NCAA Tournament trends from 2016–2025, powered by Snowflake and the Kaggle "March Machine Learning Mania" dataset. From seed performance to Cinderella upsets, this project answers 10 real-world basketball questions using clean, efficient SQL.

---

## 🚀 Project Overview

This project uses structured SQL queries to explore March Madness data across 10 seasons. Built with real Snowflake queries, it's a great example of:

- 🧠 Data modeling with raw CSVs
- 🔍 Analytical SQL across multiple joins
- 📈 Insight-driven storytelling from sports data

---

## 🔍 Query Topics

| File                                       | Question                                                                 |
|-------------------------------------------|---------------------------------------------------------------------------|
| **01_seed_final_four_appearances.sql**    | Which seeds most often make the Final Four (last 10 seasons)?             |
| **02_most_championship_wins.sql**         | Which teams have won the most championships (last 10 seasons)?            |
| **03_avg_margin_of_victory.sql**          | Which teams had the highest average margin of victory (≥5 wins)?          |
| **04_underdog_upsets.sql**                | Which seed-9+ teams pulled off the most upsets (≥2 upsets)?               |
| **05_top5_common_scores.sql**             | What are the top 5 most common total game scores and sample games?        |
| **06_elite_eight_by_conference.sql**      | Which conferences have the most Elite Eight appearances (last 20 years)?  |
| **07_teams_most_often_upset.sql**         | Which teams most often lose to lower-seeded opponents?                    |
| **08_coach_multiple_schools.sql**         | Which coaches led multiple schools to the Sweet 16 or beyond?             |
| **09_top10_win_pct.sql**                  | Which schools have the top 10 tourney win percentages (≥5 games)?         |
| **10_consecutive_appearances.sql**        | Which teams boast the longest streaks of consecutive appearances?         |

---

## 🧠 Challenges Faced

- **Data Loading into Snowflake:** I had to clean and standardize raw Kaggle CSVs before loading them as normalized Snowflake tables.

- **SQL Query Structuring:** Some questions required advanced joins, grouping logic, and window functions — valuable practice for real-world SQL.

- **Upset Logic Definition:** Determining an "upset" wasn't straightforward. I defined it by comparing seed numbers and game winners and filtered intelligently for meaningful results.

---

## 📂 Project Structure

march-madness-sql-analysis/
├── queries/ # All 10 SQL queries
│ ├── 01_seed_final_four_appearances.sql
│ ├── ...
│ └── 10_consecutive_appearances.sql
├── results/ # Optional CSV exports or screenshots
├── README.md # This documentation
└── .gitignore # Git exclusions


---

## 🗄️ Data Source

- **Platform:** Snowflake (Free Trial)  
- **Source:** [Kaggle - March Machine Learning Mania 2025](https://www.kaggle.com/competitions/march-machine-learning-mania-2025/data)  
- **Tables Used:**
  - `MNCAATourneyCompactResults`
  - `MNCAATourneySeeds`
  - `MTeams`
  - `MTeamCoaches`
  - `MTeamConferences`
  - `Conferences`

---

## ⚙️ How to Run

1. Clone this repo:
   ```bash
   git clone https://github.com/Mykeil-tzul/march-madness-sql-analysis.git
   cd march-madness-sql-analysis
