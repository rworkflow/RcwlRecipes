cwlVersion: v1.0
class: CommandLineTool
baseCommand: Rscript
requirements:
- class: InitialWorkDirRequirement
  listing:
  - entryname: Rsplit.R
    entry: |-
      .libPaths(c('/projects/rpci/songliu/qhu/miniconda3/envs/r-base/lib/R/library'))
      suppressPackageStartupMessages(library(R.utils))
      args <- commandArgs(trailingOnly = TRUE, asValues = TRUE)
      Rsplit <-
      function(files, columns, cnames = NULL, outfile, sep = "\t", isep = ",",
                         fixName = TRUE){
          files <- strsplit(files, split = isep)[[1]]
          columns <- strsplit(columns, split = isep)[[1]]
          expL <- lapply(files, function(x){
              exp1 <- read.table(x, sep = sep, header = TRUE, row.names = 1,
                                 check.names = FALSE, colClasses = "character")
              if(fixName){
                  rownames(exp1) <- sub("\\|.*", "", rownames(exp1))
              }
              exp1[, columns, drop = F]
          })
          Exp <- do.call(cbind, expL)
          if(!is.null(cnames)){
              cnames <- strsplit(cnames, split = isep)[[1]]
              colnames(Exp) <- cnames
          }
          write.table(Exp, file = outfile, quote = FALSE, sep = sep)
      }
      do.call(Rsplit, args)
    writable: false
arguments:
- Rsplit.R
inputs:
  files:
    type: File[]
    inputBinding:
      prefix: files=
      separate: false
      itemSeparator: ','
  columns:
    type: string
    inputBinding:
      prefix: columns=
      separate: false
  cnames:
    type: string?
    inputBinding:
      prefix: cnames=
      separate: false
  outfile:
    type: string
    inputBinding:
      prefix: outfile=
      separate: false
outputs:
  outFile:
    type: File
    outputBinding:
      glob: $(inputs.outfile)
