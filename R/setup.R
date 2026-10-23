# Shared, non-visible session setup.
#
# Quarto renders each book chapter in its own R process, so the objects built
# in the earlier chapters (counts, sampleinfo, seqdata, allinfo, ...) are not
# available in later ones. This script reconstructs the pipeline with exactly
# the same operations the chapters demonstrate, so each chapter can be knitted
# independently. The code that students read and run stays in the chapters,
# unchanged.

suppressPackageStartupMessages(library(tidyverse))

options(width = 80)

counts <- readr::read_csv(
  "data/GSE60450_GeneLevel_Normalized(CPM.and.TMM)_data.csv",
  show_col_types = FALSE
)
sampleinfo <- readr::read_csv(
  "data/GSE60450_filtered_metadata.csv",
  show_col_types = FALSE
)

colnames(sampleinfo)[1] <- "sample_id"
colnames(counts)[1] <- "gene_id"

seqdata <- pivot_longer(
  counts,
  cols = starts_with("GSM"),
  names_to = "Sample",
  values_to = "Count"
)

allinfo <- full_join(seqdata, sampleinfo, by = join_by(Sample == sample_id))

allinfo <- mutate(allinfo, Group = case_when(
  str_detect(characteristics, "basal.*virgin") ~ "bvirg",
  str_detect(characteristics, "basal.*preg") ~ "bpreg",
  str_detect(characteristics, "basal.*lact") ~ "blact",
  str_detect(characteristics, "luminal.*virgin") ~ "lvirg",
  str_detect(characteristics, "luminal.*preg") ~ "lpreg",
  str_detect(characteristics, "luminal.*lact") ~ "llact"
))

mygenes <- c("Csn1s2a", "Csn1s1", "Csn2", "Glycam1", "COX1", "Trf", "Wap", "Eef1a1")
mygenes_counts <- filter(allinfo, gene_symbol %in% mygenes)

mycolours <- c("turquoise", "plum", "tomato", "violet", "steelblue", "chocolate")
group_order <- c("bvirg", "bpreg", "blact", "lvirg", "lpreg", "llact")
mygenes_counts <- mutate(mygenes_counts, Group_f = factor(Group, levels = group_order))
