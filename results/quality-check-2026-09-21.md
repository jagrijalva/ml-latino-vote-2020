# Saved-run quality check — September 21, 2026

Status: latest completed local run found; technical consistency checks passed. Substantive review remains open.

## Run identity

- Wave: 2020.
- PDF creation timestamp: `D:20260919182418-04'00'`.
- PDF pages: 13.
- Sample: 2082 respondents; 568 Trump voters.
- QMD SHA-256: `ef2d5d1903cfaf778988e22a8e6447a7a22f4496c2494c58728daf498ab38795`.
- PDF SHA-256: `26754a3eb74e74e7f1dfcb7930d67f3ac86c9618b04cb077c6d3e4f6f023be41`.

## Checks completed

- Compared current deliverables with available historical/local versions in Desktop, Downloads, and the local ChatGPT project folders. No later completed run of this wave analysis was found. Separate September 15 gender reports are distinct analyses.
- Verified present raw-data and source-document checksums against the saved source manifest.
- Parsed every R code chunk without executing the analysis.
- Confirmed nine unique model/split fits and 81 tuning evaluations, with nine candidates per fit.
- Verified the selected settings attain the minimum saved validation Brier score within each grid.
- Verified each fit's training plus holdout counts equal the reported sample.
- Recomputed mean AUC/Brier from saved fit tables and checked against the PDF.
- Confirmed zero recorded exclusion violations and SHAP reconstruction errors below 1e-6.
- Confirmed all saved signed-response cells contain at least ten holdout observations.
- Rendered and visually inspected all PDF pages. The existing measurement and calibration limitations remain documented in the report.

## Scope and limits

This checks the identity, recency, saved-output consistency, and readability of the existing run. It does not rerun model fitting, independently re-audit every measurement decision, certify survey-design inference, or establish final publication readiness. Historical source manifests retain the original paths from execution; relocated historical references are provenance records, not current dependencies. Current raw-data and documentation paths exist.

The saved QMD, PDF, and analytical CSV outputs were not modified during this check. No newer run was generated. The existing source-root environment variable remains necessary when reproducing on another computer.

The current QMD and PDF hashes exactly match the prior render-validation record.
