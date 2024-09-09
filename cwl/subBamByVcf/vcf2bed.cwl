cwlVersion: v1.0
class: CommandLineTool
baseCommand: Rscript
requirements:
- class: InitialWorkDirRequirement
  listing:
  - entryname: vcf2bed.R
    entry: |-
      suppressPackageStartupMessages(library(R.utils))
      args <- commandArgs(trailingOnly = TRUE, asValues = TRUE)
      args[["window"]] <- as.integer(args[["window"]])
      vcf2bed <-
      function(vcf, out, window = 200){
          reg <- read.table(vcf, comment = "#", sep = "\t")
          bed <- cbind(reg[,1], reg[,2]-window, reg[,2]+window)
          bed <- unique(bed)
          write.table(bed, out, row.names = FALSE, col.names = FALSE, quote = FALSE, sep = "\t")
      }
      do.call(vcf2bed, args)
    writable: false
- class: DockerRequirement
  dockerPull: hubentu/r-utils
arguments:
- vcf2bed.R
inputs:
  vcf:
    type: File
    inputBinding:
      prefix: vcf=
      separate: false
  out:
    type: string
    inputBinding:
      prefix: out=
      separate: false
  window:
    type: int
    inputBinding:
      prefix: window=
      separate: false
    default: 200
outputs:
  bed:
    type: File
    outputBinding:
      glob: $(inputs.out)
