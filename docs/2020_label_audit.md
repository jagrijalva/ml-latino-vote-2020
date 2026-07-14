# CMPS 2020 — Label & Direction Audit

**Purpose.** Post-hoc reporting-layer audit per the Computational framework.
Same contract as the 2024 audit: feature importance already locked on
|SHAP|; labels + direction get resolved at the reporting step.

**Convention.** `high = conservative / pro-Trump` in the reported
beeswarm. When `reverse = TRUE`, the raw column (or 0/1 dummy) is
reversed before plotting so dark points push right = toward Trump.

**Source.** `docs/cmps2020_codebook.txt` +
`docs/cmps2020_questionnaire.txt`.

**Encoding reminder.** 2020 features are one-hot dummies produced by
`fastDummies::dummy_cols(remove_first_dummy = TRUE)`, so each feature
is a 0/1 column whose column name already carries the level text (e.g.,
`Q358_(5) Strongly oppose`). A dummy that means "endorsed the
conservative level" does not need reversing — its `1` already means
conservative. Reverse only dummies whose `1` means the liberal level.

---

## Structural notes (no bugs of the 2024 kind — flagged items are interpretive)

1. Exclusion-list scope. 2020's `exclude_partisan` includes
   `paste0("Q27R", 1:19)` and `paste0("Q28R", 1:19)` — the partisan
   contact / thermometer families that 2024 fails to exclude. Keep as is.

2. Q53 (Jan 6 framing: "protest that went too far" vs "coordinated
   insurrection") is currently **in `exclude_tautological`** in 2020.
   Parallel treatment to the fix recommended for 2024 (`q3r17`).

3. Q130/Q54/Q55/Q56/Q684 (Trump-performance / vote-fraud / Jan 6 belief
   items) are already in `exclude_tautological`. Good.

---

## Response-scale reference (2020)

- Q308r1–r7 — feeling thermometers, 0–100, higher = warmer.
- Q225r1–r14 — "support / threaten American society" battery, 1 = Strongly
  support … 5 = Strongly threaten.
- Q358 — BLM policy support, 1 = Strongly support … 5 = Strongly oppose.
- Q359r1, Q359r2 — racial-justice statements, 1 = Strongly agree … 5 =
  Strongly disagree.
- Q131r2 / r8 / r10 — policy items, 1 = Strongly support … 5 = Strongly
  oppose.
- Q504r1–r12 — "how much stress do these cause you", 1 = A great deal …
  4 = Not at all (check per item — scale direction is uniform in family).
- Q1r17, Q1r19 — priority endorsements, binary 0/1.
- Q485 — intersectional-bias framing, 3-level categorical (one-hot).
- Q543 — border wall spending, 1 = Support, 2 = Oppose.
- Q706_Q708r1 — policing reform, 1 = Strongly favor … 5 = Strongly oppose.

---

## Per-feature audit (top stable features, Tier 3)

Feature names below are the **dummy column names** produced after
one-hot encoding. The `(k)` embedded in the name is the raw level.

| Feature (dummy) | Codebook item | Level meaning | Proposed label | Natural direction (dummy=1) | Reverse dummy to get high=conservative |
|---|---|---|---|---|---|
| `Q308R1_<n>` | Q308_r1 — warmth, undocumented | n ∈ 0–100 bins | Warmth toward undocumented | ↑ warmth = liberal | **Reverse** (if treated as numeric post-hoc) |
| `Q308R7_<n>` | Q308_r7 — warmth, #BLM | n ∈ 0–100 bins | Warmth toward BLM | ↑ warmth = liberal | Reverse |
| `Q308R5_<n>` | Q308_r5 — warmth, climate activists | 0–100 | Warmth toward climate activists | ↑ = liberal | Reverse |
| `Q308R6_<n>` | Q308_r6 — warmth, #MeToo | 0–100 | Warmth toward #MeToo | ↑ = liberal | Reverse |
| `Q308R4_<n>` | Q308_r4 — warmth, welfare recipients | 0–100 | Warmth toward welfare recipients | ↑ = liberal | Reverse |
| `Q358_(5) Strongly oppose` | Q358 — BLM policy | dummy=1 means "Strongly oppose" | Strongly oppose BLM policy | ↑ (dummy=1) = conservative | **No reverse** |
| `Q358_(1) Strongly support` | Q358 — BLM policy | dummy=1 means "Strongly support" | Strongly support BLM policy | ↑ = liberal | Reverse |
| `Q358_(4) Somewhat oppose` | Q358 | "Somewhat oppose" | Somewhat oppose BLM policy | ↑ = conservative | No reverse |
| `Q359R1_(5) Strongly disagree` | Q359_r1 — racial-justice stmt 1 | dummy=1 = "Strongly disagree" | Reject racial-justice statement 1 | ↑ = conservative | No reverse |
| `Q359R1_(1) Strongly agree` | Q359_r1 | "Strongly agree" | Endorse racial-justice statement 1 | ↑ = liberal | Reverse |
| `Q359R2_(5) Strongly disagree` | Q359_r2 | "Strongly disagree" | Reject racial-justice statement 2 | ↑ = conservative | No reverse |
| `Q131R2_(5) Strongly oppose` | Q131_r2 — policy item 2 | "Strongly oppose" | Strongly oppose [Q131_r2 policy] | ↑ = conservative* | No reverse* |
| `Q131R8_(5) Strongly oppose` | Q131_r8 — policy item 8 | "Strongly oppose" | Strongly oppose [Q131_r8 policy] | ↑ = conservative* | No reverse* |
| `Q131R10_(5) Strongly oppose` | Q131_r10 — policy item 10 | "Strongly oppose" | Strongly oppose [Q131_r10 policy] | ↑ = conservative* | No reverse* |
| `Q543_(2) Oppose` | Q543 — border wall spending | dummy=1 = Oppose wall spending | Oppose border wall spending | ↑ = liberal | Reverse |
| `Q543_(1) Support` | Q543 | Support wall spending | Support border wall spending | ↑ = conservative | No reverse |
| `Q504R3_<lvl>` | Q504_r3 — stress, climate change | level | Stress about climate change | ↑ stress = liberal | Reverse |
| `Q504R4_<lvl>` | Q504_r4 — stress, police brutality | level | Stress about police brutality | ↑ stress = liberal | Reverse |
| `Q504R6_<lvl>` | Q504_r6 — stress, white supremacy | level | Stress about white supremacy | ↑ stress = liberal | Reverse |
| `Q1R17_1` | Q1_r17 — priority dummy | dummy=1 = endorses priority 17 | Priority: [Q1_r17 topic] | salience flag — not ideological | Keep as-is |
| `Q1R19_1` | Q1_r19 — priority dummy | dummy=1 = endorses priority 19 | Priority: [Q1_r19 topic] | salience flag | Keep as-is |
| `Q485_<lvl>` | Q485 — intersectional bias framing | categorical | Intersectional-bias framing | non-monotonic | Handle as one-hot; do not reverse numerically |
| `Q706_Q708R1_(5) Strongly oppose` | Q706/Q708_r1 — policing reform | "Strongly oppose" | Oppose policing reform item 1 | ↑ = conservative | No reverse |
| `Q225R14_(5) Strongly threaten` | Q225_r14 — white nationalists | "Strongly threaten society" | See white nationalists as societal threat | ↑ = liberal | Reverse |

\* For Q131 items the direction assignment depends on the policy
content of each subitem (r2, r8, r10). Fill those three in from the
questionnaire text in `docs/cmps2020_questionnaire.txt` before the
final reporting run — the skeleton above uses the safe default
("oppose = conservative") but a couple of Q131 subitems are
conservative-coded policies (e.g., immigration enforcement) where
"oppose" = liberal.

---

## Recommendations (post-hoc, within the framework)

**A. Ship labels.** Populate the `feature_labels` map in the reporting
QMD with the level text parsed from the dummy name; drop the cryptic
`QNNNr*_(k) Level` prefix from the printed label. The `label_feature()`
function in `CMPS_2020_IFA_analysis_final.qmd` already accepts the
map — this is purely filling it.

**B. Reverse only the dummies whose `1` encodes the liberal level.**
The lookup table (R file) lists these explicitly so the reporting QMD
can iterate.

**C. Fill Q131 subitem text** from `cmps2020_questionnaire.txt` before
press — three items sit on a conservative-vs-liberal policy ambiguity
that flips the direction.

**D. No model re-run needed for 2020.** The exclusion lists pass the
framework criteria as specified.
