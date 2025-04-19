/*
 Query 05: Top 5 Most Common Game Scores
 Description: Finds the five most common total scores (combined points) in tournament history,
              shows how often each occurred, and lists sample games.
*/

WITH game_scores AS (
  -- Total score and game details for every tournament game
  SELECT
    (r.wscore + r.lscore)    AS total_score,
    r.season,
    r.wscore                 AS winning_score,
    r.lscore                 AS losing_score,
    r.wteamid,
    r.lteamid
  FROM mncaatourneycompactresults AS r
),

score_freq AS (
  -- Count frequency of each total score
  SELECT
    total_score,
    COUNT(*) AS occurrences
  FROM game_scores
  GROUP BY total_score
),

top_scores AS (
  -- Top 5 most frequent total scores
  SELECT
    total_score,
    occurrences
  FROM score_freq
  ORDER BY occurrences DESC
  LIMIT 5
)

SELECT
  ts.total_score,
  ts.occurrences,
  LISTAGG(
    gs.winning_score || '-' || gs.losing_score
    || ' (' || wt.teamname
    || ' vs ' || lt.teamname
    || ' ' || gs.season || ')',
    '; '
  ) WITHIN GROUP (ORDER BY gs.season DESC) AS sample_games
FROM top_scores ts
JOIN game_scores gs
  ON ts.total_score = gs.total_score
LEFT JOIN mteams wt
  ON gs.wteamid = wt.teamid
LEFT JOIN mteams lt
  ON gs.lteamid = lt.teamid
GROUP BY
  ts.total_score,
  ts.occurrences
ORDER BY
  ts.occurrences DESC;
