cwlVersion: v1.0
class: CommandLineTool
baseCommand: Rscript
requirements:
- class: InitialWorkDirRequirement
  listing:
  - entryname: cleanExp.R
    entry: |-
      .libPaths('/Users/qi31566/homebrew/lib/R/4.0/site-library')
      suppressPackageStartupMessages(library(R.utils))
      suppressPackageStartupMessages(library(codetools))
      args <- commandArgs(trailingOnly = TRUE, asValues = TRUE)
      cleanExp <-
      function(afile) {
          exp1 <- read.table(afile, header = TRUE, stringsAsFactors = FALSE)
          exp1[,1] <- sub("\\|ENSG.*", "", exp1[,1])
          write.table(exp1, file = "abundance_clean.tsv",
                      row.names = FALSE, quote = FALSE, sep = "\t")
      }
      do.call(cleanExp, args)
    writable: false
arguments:
- cleanExp.R
inputs:
  afile:
    type: File
    inputBinding:
      prefix: afile=
      separate: false
outputs:
  aout:
    type: File
    outputBinding:
      glob: abundance_clean.tsv
