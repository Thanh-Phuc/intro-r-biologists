# Introduction to R for Biologists

A Quarto book edition of the *Introduction to R for Biologists* course by
**Maria Doyle, Jessica Chung and Vicky Perreau** (Melbourne Bioinformatics).

The text, code, exercises and figures are reproduced unchanged from the
original single-page R Markdown document; the chapters are its original
top-level sections.

- Original source: <https://github.com/mblue9/r-intro-biologists>
- Original rendering: <https://mbite.mdhs.unimelb.edu.au/r-intro-biologists/intro_r_biologists.html>
- Licence: [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/)

## Build

Requires R with `tidyverse` and Quarto.

```bash
quarto render        # output goes to docs/
quarto preview       # live preview
```

The data files used by the exercises live in `data/`, and the figures in
`images/`. `R/setup.R` is non-visible infrastructure: Quarto knits each chapter
in its own R session, so it rebuilds the objects created by earlier chapters.
The code shown in the chapters is untouched.
