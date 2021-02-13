cwlVersion: v1.0
class: CommandLineTool
baseCommand: Rscript
requirements:
- class: InitialWorkDirRequirement
  listing:
  - entryname: T2Gene.R
    entry: |-
      .libPaths('/Users/qi31566/homebrew/lib/R/4.0/site-library')
      suppressPackageStartupMessages(library(R.utils))
      suppressPackageStartupMessages(library(codetools))
      args <- commandArgs(trailingOnly = TRUE, asValues = TRUE)
      T2Gene <-
      function(kexp){
          e1 <- read.table(kexp, header = TRUE, check.names = FALSE,
                           stringsAsFactors = FALSE, sep = "\t")
          ids <- do.call(rbind, base::strsplit(e1$target_id, split = "\\|"))
          tx2gene  <- data.frame(ids[,1:2])
          gexp <- tximport::tximport(kexp, type = "kallisto", tx2gene = tx2gene, ignoreAfterBar=TRUE)
          gExp <- data.frame(gene = sub("\\..*", "", rownames(gexp$abundance)),
                             abundance = gexp$abundance)
          write.table(gExp, file = "abundance_gene.tsv", row.names = FALSE,
                      col.names = TRUE, quote = FALSE, sep = "\t")
      }
      do.call(T2Gene, args)
    writable: false
arguments:
- T2Gene.R
inputs:
  kexp:
    type: File
    inputBinding:
      prefix: kexp=
      separate: false
outputs:
  gout:
    type: File
    outputBinding:
      glob: abundance_gene.tsv
