# CMPS 2020 — current analysis

Status: **Verify**. This is the latest completed local analysis, ready for substantive review. This organization pass does not certify final analytical approval.

## Start here

- Read [the analysis PDF](cmps2020_latino_trump_analysis.pdf).
- Open `ml-latino-vote-2020.Rproj` in RStudio, then [the analysis QMD](cmps2020_latino_trump_analysis.qmd) for the executable source.
- Read [the execution note](cmps2020_execution_note.md) for decisions, checks, and limitations.
- Use [results/](results/) for saved aggregate tables, figures, sample definitions, and audits.

## Quality check

[September 21 saved-run checks](results/quality-check-2026-09-21.md) passed. This is the latest completed local run found; substantive approval remains pending.

## Working organization

Current work and work in progress stay visible. Superseded analyses, earlier preparation outputs, and prior documentation belong in `archive/`. Do not use archived results as current findings.

`data/` contains local source data. `docs/` contains the questionnaires and codebooks used by this analysis. Existing source manifests record provenance and checksums. Data and archives are excluded from Git.

## Reproduction

The QMD currently defaults to this repository's existing absolute local path. To run elsewhere, set `CMPS2020_SOURCE` to that repository's absolute path. Run from this project directory. Rendering may refit models and overwrite generated outputs; use the saved PDF for reading and review.

```sh
quarto render cmps2020_latino_trump_analysis.qmd --to pdf
```

## Organization record

On September 21, 2026, the current saved QMD, PDF, and results were preserved byte-for-byte. Superseded entry points were archived. No analysis was rerun and no commit or push was made during organization.

Project context: [Why Groups Diverge](https://app.notion.com/p/36b9c1366fe381369be2c77852f78db7).
