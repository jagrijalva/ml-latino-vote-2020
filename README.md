# ml-latino-vote-2020

Inferential Feature Analysis of Latino Trump support using the 2020 Collaborative Multiracial Post-Election Survey (CMPS).

**DV:** Binary indicator of Latino vote for Donald Trump.

**Method:** Random Forest (`ranger`) + SHAP values (`treeshap` / `shapviz`), four-tier progressive exclusion framework, bootstrap rank-stability analysis.

## Key files

- `analysis.qmd` — end-to-end analysis pipeline. Runs data cleaning, imputation, RF models (Tiers 1–4), SHAP decomposition, and bootstrap. Saves fitted objects to `data/derived/ifa_results_2020.rds` and renders `analysis.pdf`.
- `analysis.pdf` — rendered output with manuscript-ready figures and tables.
- `R/label_direction_lookup.R` — wave-owned label and direction conventions for the reporting layer. Sourced verbatim by the pooled paper's `pooled_labels.R`; kept separate from `analysis.qmd` because feature importance is locked on |SHAP| before labels and direction are resolved.
- `ml-latino-vote-2020.Rproj` — RStudio project file.
- `docs/` — CMPS 2020 codebook, questionnaire, and the label/direction audit.

## Folder structure

```
analysis.qmd        # analysis + reporting pipeline
analysis.pdf        # rendered output
R/                  # label_direction_lookup.R (pooled-paper dependency)
docs/               # codebook, questionnaire, label audit
data/
  raw/              # ICPSR raw data (gitignored; download required)
  derived/          # ifa_results_2020.rds (gitignored; regenerated on render)
```

## Reproducing

1. Obtain the 2020 CMPS raw data from ICPSR (study 39096) and place `39096-0001-Data.rda` under `data/raw/`.
2. Open `ml-latino-vote-2020.Rproj` in RStudio.
3. Render `analysis.qmd`. This fits all models and writes `data/derived/ifa_results_2020.rds`.

## Pooled-paper contract

The pooled 2016/2020/2024 paper consumes `data/derived/ifa_results_2020.rds` and sources `R/label_direction_lookup.R`. Both paths are fixed.

## What is gitignored

- `data/` — license-restricted ICPSR raw data and regenerated derived objects
- `*.rds` — model bundles (regenerated on render)
- `scratch/` — temporary working space
- Quarto render artifacts (`*_files/`, `.quarto/`, `*.tex`, `*.html`, etc.)

## Related repositories

- [`ml-latino-vote-2016`](https://github.com/jagrijalva/ml-latino-vote-2016) — parallel analysis on the 2016 CMPS.
- [`ml-latino-vote-2024`](https://github.com/jagrijalva/ml-latino-vote-2024) — parallel analysis on the 2024 CMPS.

## License

MIT — see [`LICENSE`](LICENSE).
