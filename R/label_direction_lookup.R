# ------------------------------------------------------------------
# label_direction_lookup.R  (CMPS 2020)
# ------------------------------------------------------------------
# Purpose
#   Post-hoc reporting layer for the 2020 pipeline. 2020 features are
#   one-hot DUMMIES produced by fastDummies::dummy_cols(remove_first_dummy = TRUE),
#   so the "feature" is a 0/1 column whose name already contains the
#   level text, e.g. "Q358_(5) Strongly oppose".
#
#   Direction convention: in the reported beeswarm, `dummy = 1` should
#   mean the conservative / pro-Trump end. For dummies whose `1` already
#   encodes the conservative level, reverse_code = FALSE. For dummies
#   whose `1` encodes the liberal level, reverse_code = TRUE (we plot
#   1 - dummy so the "dark" points lie on the conservative side).
#
# Usage (in the 2020 reporting QMD):
#   source("R/label_direction_lookup.R")
#   plot_df <- shap_long |>
#     dplyr::mutate(
#       raw_for_plot = dplyr::if_else(
#         feature %in% names(reverse_code_2020)[reverse_code_2020],
#         1 - raw_value,       # dummies are 0/1
#         raw_value
#       ),
#       label = dplyr::recode(feature, !!!feature_labels_2020, .default = feature)
#     )
# ------------------------------------------------------------------

feature_labels_2020 <- c(
  # Feeling thermometers (retained as numeric in some runs; as
  # dummied bins in others — labels apply to both forms)
  Q308R1 = "Warmth toward undocumented immigrants",
  Q308R4 = "Warmth toward welfare recipients",
  Q308R5 = "Warmth toward climate activists",
  Q308R6 = "Warmth toward #MeToo",
  Q308R7 = "Warmth toward Black Lives Matter",

  # BLM policy — level-resolved labels for each dummy
  `Q358_(1) Strongly support` = "Strongly support BLM policy",
  `Q358_(2) Somewhat support` = "Somewhat support BLM policy",
  `Q358_(3) Neither`          = "Neutral on BLM policy",
  `Q358_(4) Somewhat oppose`  = "Somewhat oppose BLM policy",
  `Q358_(5) Strongly oppose`  = "Strongly oppose BLM policy",

  # Racial-justice statements (Q359 r1/r2)
  `Q359R1_(1) Strongly agree`    = "Strongly endorse racial-justice statement 1",
  `Q359R1_(5) Strongly disagree` = "Strongly reject racial-justice statement 1",
  `Q359R2_(1) Strongly agree`    = "Strongly endorse racial-justice statement 2",
  `Q359R2_(5) Strongly disagree` = "Strongly reject racial-justice statement 2",

  # Policy battery Q131 (subitem text needs to be filled from
  # cmps2020_questionnaire.txt before final press — these three are
  # the top stable items; see 2020_label_audit.md note)
  `Q131R2_(5) Strongly oppose`  = "Strongly oppose [Q131_r2 policy]",
  `Q131R2_(1) Strongly support` = "Strongly support [Q131_r2 policy]",
  `Q131R8_(5) Strongly oppose`  = "Strongly oppose [Q131_r8 policy]",
  `Q131R8_(1) Strongly support` = "Strongly support [Q131_r8 policy]",
  `Q131R10_(5) Strongly oppose` = "Strongly oppose [Q131_r10 policy]",
  `Q131R10_(1) Strongly support`= "Strongly support [Q131_r10 policy]",

  # Border wall spending
  `Q543_(1) Support` = "Support border wall spending",
  `Q543_(2) Oppose`  = "Oppose border wall spending",

  # Stress battery — subset flagged in top features
  Q504R3 = "Stress about climate change",
  Q504R4 = "Stress about police brutality",
  Q504R6 = "Stress about white supremacy",

  # Priority dummies
  Q1R17_1 = "Priority: [Q1_r17 topic]",
  Q1R19_1 = "Priority: [Q1_r19 topic]",

  # Intersectional-bias framing (categorical)
  Q485 = "Intersectional-bias framing",

  # Policing reform
  `Q706_Q708R1_(5) Strongly oppose` = "Strongly oppose policing-reform item 1",
  `Q706_Q708R1_(1) Strongly favor`  = "Strongly favor policing-reform item 1",

  # Threat battery Q225 r14 (white nationalists)
  `Q225R14_(5) Strongly threaten` = "See white nationalists as societal threat",
  `Q225R14_(1) Strongly support`  = "See white nationalists as societal support"
)

# Reverse-code flags for 2020 dummies ------------------------------
# TRUE  -> the dummy's `1` level is the LIBERAL end, so plot 1 - dummy
#          so dark (= high, = dummy was 1) sits on the conservative side.
# FALSE -> the dummy's `1` level is the CONSERVATIVE end; leave alone.
reverse_code_2020 <- c(
  # BLM policy
  `Q358_(1) Strongly support` = TRUE,
  `Q358_(2) Somewhat support` = TRUE,
  `Q358_(3) Neither`          = FALSE,  # midpoint; leave
  `Q358_(4) Somewhat oppose`  = FALSE,
  `Q358_(5) Strongly oppose`  = FALSE,

  # Racial-justice statements (pro-equity framing)
  `Q359R1_(1) Strongly agree`    = TRUE,
  `Q359R1_(5) Strongly disagree` = FALSE,
  `Q359R2_(1) Strongly agree`    = TRUE,
  `Q359R2_(5) Strongly disagree` = FALSE,

  # Border wall
  `Q543_(1) Support` = FALSE,  # support wall = conservative
  `Q543_(2) Oppose`  = TRUE,

  # Q131 policy items — direction depends on subitem content; default
  # assumes these are progressive policies (so "Strongly oppose" =
  # conservative). Revisit per-item when filling subitem text.
  `Q131R2_(5) Strongly oppose`  = FALSE,
  `Q131R2_(1) Strongly support` = TRUE,
  `Q131R8_(5) Strongly oppose`  = FALSE,
  `Q131R8_(1) Strongly support` = TRUE,
  `Q131R10_(5) Strongly oppose` = FALSE,
  `Q131R10_(1) Strongly support`= TRUE,

  # Policing reform
  `Q706_Q708R1_(5) Strongly oppose` = FALSE,
  `Q706_Q708R1_(1) Strongly favor`  = TRUE,

  # Q225 white nationalists (threat framing)
  `Q225R14_(5) Strongly threaten` = TRUE,   # sees threat = liberal
  `Q225R14_(1) Strongly support`  = FALSE,

  # Priority / salience dummies — keep as-is
  Q1R17_1 = FALSE,
  Q1R19_1 = FALSE,

  # Feeling thermometers and stress items (treated numerically
  # post-hoc; reversed so warmth-toward-liberal-groups = conservative
  # high). If they are dummied by bin in a given run, apply the
  # reversal at the raw-value level before binning.
  Q308R1 = TRUE,
  Q308R4 = TRUE,
  Q308R5 = TRUE,
  Q308R6 = TRUE,
  Q308R7 = TRUE,
  Q504R3 = TRUE,
  Q504R4 = TRUE,
  Q504R6 = TRUE,

  # One-hot categorical — leave alone; handle in plot code
  Q485   = FALSE
)
