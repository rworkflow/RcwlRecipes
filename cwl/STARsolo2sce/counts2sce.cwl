cwlVersion: v1.0
class: CommandLineTool
baseCommand: Rscript
requirements:
- class: InitialWorkDirRequirement
  listing:
  - entryname: counts2sce.R
    entry: "suppressPackageStartupMessages(library(R.utils))\nargs <- commandArgs(trailingOnly
      = TRUE, asValues = TRUE)\ncounts2sce <-\nfunction(dir.name, ...) {    \n    library(DropletUtils)\n
      \   dir.name <- file.path(dir.name, \"Gene/filtered\")\n    sce <- read10xCounts(dir.name,
      ...)\n    saveRDS(sce, file = \"counts_sce.rds\")\n}\ndo.call(counts2sce, args)"
    writable: false
arguments:
- counts2sce.R
inputs:
  dirname:
    type: Directory
    inputBinding:
      prefix: dir.name=
      separate: false
outputs:
  outsce:
    type: File
    outputBinding:
      glob: '*.rds'
