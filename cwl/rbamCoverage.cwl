cwlVersion: v1.0
class: CommandLineTool
baseCommand: Rscript
requirements:
- class: InitialWorkDirRequirement
  listing:
  - entryname: rbamCoverage.R
    entry: ".libPaths(c('/projects/rpci/songliu/qhu/miniconda3/envs/r-base/lib/R/library'))\nsuppressPackageStartupMessages(library(R.utils))\nargs
      <- commandArgs(trailingOnly = TRUE, asValues = TRUE)\nrbamCoverage <-\nfunction(bam,
      bed, ct = \"1000,10000\"){\n    library(GenomicAlignments)\n    bed <- read.table(bed)\n
      \   gr <- GRanges(bed[,1], IRanges(bed[,2]+1, bed[,3]))\n    gr <- reduce(gr)\n
      \   cov <- c()\n    for(i in 1:length(gr)){\n        a1 <- readGAlignments(bam,
      param = ScanBamParam(which=gr[i]))\n        if(length(a1)>0){\n            cr
      <- coverage(ranges(a1))\n            if(length(cr) < end(gr[i])){\n                cr
      <- c(cr, rep(0, end(gr[i]) - length(cr)))\n            }\n            cov1 <-
      cr[start(gr[i]):end(gr[i])]\n            cov <- c(cov, cov1)\n        }\n    }\n
      \   cov <- unlist(RleList(cov))\n    \n    ct <- as.integer(unlist(strsplit(ct,
      split = \",\")))\n    cts <- sapply(ct, function(x)mean(cov>=x))\n    csum <-
      c(mean(cov), cts)\n    csum <- rbind(csum)\n    colnames(csum) <- c(\"mean\",
      paste0(\">=\", ct))\n    write.csv(csum, paste0(sub(\".bam\", \"\", basename(bam)),
      \"_cov.csv\"), row.names=FALSE)\n}\ndo.call(rbamCoverage, args)"
    writable: false
arguments:
- rbamCoverage.R
inputs:
  bam:
    type: File
    secondaryFiles: .bai
    inputBinding:
      position: 1
      prefix: bam=
      separate: false
  bed:
    type: File
    inputBinding:
      position: 2
      prefix: bed=
      separate: false
  ct:
    type: string[]
    inputBinding:
      position: 3
      prefix: ct=
      separate: false
      itemSeparator: ','
outputs:
  cov:
    type: File
    outputBinding:
      glob: '*_cov.csv'
