cwlVersion: v1.0
class: CommandLineTool
baseCommand: Rscript
requirements:
- class: InitialWorkDirRequirement
  listing:
  - entryname: DropletUtils.R
    entry: "suppressPackageStartupMessages(library(R.utils))\nargs <- commandArgs(trailingOnly
      = TRUE, asValues = TRUE)\nargs[[\"lower\"]] <- as.integer(args[[\"lower\"]])\nargs[[\"df\"]]
      <- as.integer(args[[\"df\"]])\nDropletUtils <-\nfunction(dir.name, lower=100,
      df=20, ...) {    \n    library(DropletUtils)\n    dir.name <- file.path(dir.name,
      \"Gene/raw\")\n    sce <- read10xCounts(dir.name, ...)\n    br.out <- barcodeRanks(assay(sce),
      lower=lower, df=df)\n    o <- order(br.out$rank)\n    e.out <- emptyDrops(assay(sce))\n
      \   is.cell <- e.out$FDR <= 0.01\n    pdf(file = \"diagnostics.pdf\")\n    plot(br.out$rank,
      br.out$total, log=\"xy\", xlab=\"Rank\", ylab=\"Total\",\n         main = \"Barcode
      Ranks\")\n    lines(br.out$rank[o], br.out$fitted[o], col=\"red\")\n    abline(h=metadata(br.out)$knee,
      col=\"dodgerblue\", lty=2)\n    abline(h=metadata(br.out)$inflection, col=\"forestgreen\",
      lty=2)\n    legend(\"bottomleft\", lty=2, col=c(\"dodgerblue\", \"forestgreen\"),\n
      \          legend=c(\"knee\", \"inflection\"))\n    plot(e.out$Total, -e.out$LogProb,
      col=ifelse(is.cell, \"red\", \"black\"),\n         xlab=\"Total UMI count\",
      ylab=\"-Log Probability\",\n         main = \"Empty Droplets\")\n    dev.off()\n
      \   sce1 <- sce[, which(is.cell == \"TRUE\")]\n    saveRDS(sce1, file = \"sce_filtered.rds\")\n}\ndo.call(DropletUtils,
      args)"
    writable: false
arguments:
- DropletUtils.R
inputs:
  dirname:
    type: Directory
    inputBinding:
      prefix: dir.name=
      separate: false
  lower:
    type: int
    inputBinding:
      prefix: lower=
      separate: false
    default: 100
  df:
    type: int
    inputBinding:
      prefix: df=
      separate: false
    default: 20
outputs:
  plots:
    type: File
    outputBinding:
      glob: '*.pdf'
  outsce:
    type: File
    outputBinding:
      glob: '*.rds'
