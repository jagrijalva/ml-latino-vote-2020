# CMPS 2020 execution note

Final primary-release sample: 2082 Latino registered reported voters, including 568 Trump voters; unweighted share 27.2815% and weighted share 28.3309%.

Sample: MAIN_ETH_QUOTA=2, BASELINE=1, S6=1, Q12 in {1,2}, Q14 in {1,2,3,4,5}; Trump is Q14=1. Nonvoter support is excluded. The 138 otherwise eligible oversample voters are excluded by the explicitly resolved primary-sample choice.

Weight: WEIGHT, labelled primary sample only. Official methodology recommends within-racial-group raking to 2019 ACS adult age, gender, education, nativity and ancestry margins. Applied to the voter subset without trimming or class balancing; not separately calibrated to Latino voters.

Sources: local data/raw/39096-0001-Data.rda, docs/39096-Questionnaire.pdf, docs/39096-0001-Codebook-ICPSR.pdf under CMPS2020_SOURCE; official UCLA primary-sample methodology; inspected existing preparation and QMD files. Exact paths, roles, MD5 and SHA-256 hashes are in results/source-manifest.csv.

Model 2 removes Q2 candidate evaluations; Q15 congressional vote; Q47–56 election-fraud/January 6 reactions; candidate-specific protest responses in Q96/Q98; Q130 Trump/COVID; Q195–201, Q272, Q323–328 and Q340–341 candidate experiments; Q504R11/R12 candidate anxiety; Q509_Q511R3 Trump executive-order experience; Q575_Q581 candidate feelings; Q614/Q615 immigration-policy approval/expression; and Q684's 2020-election tradeoff. Exact source-column dispositions are in results/predictor-ledger.csv.

Model 3 additionally removes Q17–19 foreign-party history/follow-ups, Q21–28 party identification/strength/leaning/history/associations, Q1R17/R18 party antagonism, Q225R10/R11 party support/threat to one's vision of society, Q287R6/Q294/Q301/Q315 party-selected identity, Q316R7 shared party, Q334 partisan redistricting, Q560R4 party identity importance, and Q743–745 spouse partisanship. All Q301 allocation components are withheld because the 100-point total could recover party allocation. Q43 ideology remains. Named movements, caucuses and nonspecific campaign contact remain eligible under the direct-partisanship rule.

Selected frozen-grid settings (150 tuning trees; 300 final trees):



| Model|Seed   |Option     | Node| Inner_mtry| Final_mtry|
|-----:|:------|:----------|----:|----------:|----------:|
|     1|202001 |fraction20 |   20|       1147|       1174|
|     2|202001 |fraction20 |    5|       1019|       1038|
|     3|202001 |fraction20 |    5|        974|        992|
|     1|202002 |fraction20 |   20|       1146|       1169|
|     2|202002 |fraction20 |    5|       1018|       1034|
|     3|202002 |fraction40 |    5|       1947|       1976|
|     1|202003 |fraction40 |    5|       2296|       2348|
|     2|202003 |sqrt       |    5|         71|         72|
|     3|202003 |fraction20 |    5|        975|        992|

The 40% boundary was selected in 2 of nine fits. No grid expansion.

Weighted holdout performance, mean [minimum, maximum]:



|Model   |AUC                  |Brier                |Reference            |
|:-------|:--------------------|:--------------------|:--------------------|
|Model 1 |0.989 [0.987, 0.993] |0.037 [0.033, 0.040] |0.204 [0.200, 0.212] |
|Model 2 |0.967 [0.965, 0.968] |0.070 [0.064, 0.077] |0.204 [0.200, 0.212] |
|Model 3 |0.936 [0.922, 0.949] |0.092 [0.083, 0.102] |0.204 [0.200, 0.212] |

Model 1: congressional vote, Trump immigration-policy approval and Trump favorability rank 1–3 in every fit. Model 2: identification and histories lead on average, with substantial reshuffling of party-group associations. Model 3: border-security spending and BLM support rank 1 and 2 in every fit; dislike rankings, issue priorities and BLM warmth occupy 3–5; ideology ranks 6–7.

Signed patterns: border spending/wall support is consistently positive, opposition negative. Model 3 strong opposition to BLM averages +11.81 pp [10.30,13.86], while somewhat opposing is near zero and unstable (+0.58 [-1.01,1.85]); support and neutrality are negative. Very conservative ideology is a pronounced positive endpoint. Trump somewhat-unfavorable responses remain positive relative to the Model 1 reference; only very unfavorable is consistently negative. The dislike-ranking summaries condition the whole ranking, not isolated group effects.

NINE FROZEN-GRID FOREST FITS VALIDATED
Primary-release Latino registered reported voters; vote/support routing checked; WEIGHT used without trimming or balancing.
Nested source and encoded-item sets passed for all seeds; identified exclusions absent; ideology retained.
Training-only preprocessing and internal validation; all nine grid cells evaluated for each fit.
Maximum SHAP reconstruction error: 5.77316e-15
fraction40 selected in 2 of 9 fits; no grid expansion.
All-item rankings and top-50 profiles saved. Signed cells require at least 10 holdout observations.
Measurement review flags: Q315/Q603R2 wording discrepancies, published/local release counts, and remaining truncated labels.

Calibration slopes exceed one in all nine fits; Model 3 overpredicts mean Trump prevalence in every split. No correction was fitted to holdouts.

Unresolved measurement review: the local primary flag identifies 14,977 records versus 14,988 published; Latino quota N=3,942 (RACE=2 N=3,951) versus 4,006 published. No records were fabricated/reassigned. ICPSR flags Q315 and Q603R2 wording discrepancies; source codes remain flagged. Other unverified truncated labels retain codes. The detailed crosswalk and response-label expansions are aggregate audit outputs.

Reproduce with quarto render cmps2020_latino_trump_analysis.qmd --to pdf. The source QMD is self-contained and has no permanent model cache. Only aggregate results and the final report are retained; no individual political scores, predictions, SHAP arrays, respondent IDs or forests are exported.
