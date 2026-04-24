# ml-latino-vote-2020

Inferential Feature Analysis of Latino Trump support using the 2020 Collaborative Multiracial Post-Election Survey (CMPS).

**DV:** Binary indicator of Latino vote for Donald Trump.

**Method:** Random Forest (`ranger`) + SHAP values (`treeshap` / `shapviz`), four-tier progressive exclusion framework, 100-iteration bootstrap for rank stability.

## Key files

- `CMPS_2020_IFA_analysis.qmd` — end-to-end analysis pipeline. Runs data cleaning, imputation, RF models (Tiers 1–4), SHAP decomposition, and bootstrap. Saves the fitted objects to `ifa_results.rds` at the project root and renders `CMPS_2020_IFA_analysis.pdf`.
- `CMPS_2020_IFA_analysis.pdf` — rendered output with manuscript-ready figures and tables.
- `ml-2020-project.Rproj` — RStudio project file.
- `docs/` — CMPS 2020 codebook, questionnaire, and working codebook notes.

## Folder structure

```
CMPS_2020_IFA_analysis.qmd   # analysis + reporting pipeline
CMPS_2020_IFA_analysis.pdf   # rendered output
docs/                        # codebook, questionnaire, feature notes
data/                        # raw + processed CMPS data (gitignored)
scratch/                     # working drafts, audits, superseded files (gitignored)
ifa_results.rds              # cached model objects (gitignored, regenerated on render)
```

## Reproducing

1. Obtain the 2020 CMPS raw data from ICPSR and place it under `data/raw/`.
2. Open `ml-2020-project.Rproj` in RStudio.
3. Render `CMPS_2020_IFA_analysis.qmd`. First render fits all models and caches them to `ifa_results.rds`; later renders reuse the cache.

## What is gitignored

- `data/` — license-restricted ICPSR raw data and derived files
- `scratch/` — working drafts and audits (not needed for reproduction)
- `*.rds` — model caches (regenerated on render)
- Quarto render artifacts (`*_files/`, `.quarto/`, `*.tex`, `*.html`, etc.)

## Related repositories

- [`ml-latino-vote-2016`](https://github.com/jagrijalva/ml-latino-vote-2016) — parallel analysis on the 2016 CMPS.
- [`ml-latino-vote-2024`](https://github.com/jagrijalva/ml-latino-vote-2024) — parallel analysis on the 2024 CMPS.

## License

MIT — see [`LICENSE`](LICENSE).
