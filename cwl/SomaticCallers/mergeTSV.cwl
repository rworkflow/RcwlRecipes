cwlVersion: v1.0
class: CommandLineTool
baseCommand: Rscript
requirements:
- class: InitialWorkDirRequirement
  listing:
  - entryname: mergeTSV.R
    entry: |-
      suppressPackageStartupMessages(library(R.utils))
      args <- commandArgs(trailingOnly = TRUE, asValues = TRUE)
      mergeTSV <-
      function(esnv, eindel){
          snv1 <- read.table(esnv, header = TRUE)
          indel1 <- read.table(eindel, header = TRUE)
          var1 <- rbind(snv1, indel1)
          var1[is.na(var1)] <- 0
          write.table(var1, file = "Ensemble.sVar.tsv",
                      row.names = FALSE, sep = "\t", quote = FALSE)
      }
      do.call(mergeTSV, args)
    writable: false
arguments:
- mergeTSV.R
inputs:
  esnv:
    type: File
    inputBinding:
      prefix: esnv=
      separate: false
  eindel:
    type: File
    inputBinding:
      prefix: eindel=
      separate: false
outputs:
  tsv:
    type: File
    outputBinding:
      glob: Ensemble.sVar.tsv
