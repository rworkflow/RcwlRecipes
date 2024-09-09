suppressPackageStartupMessages(library(R.utils))
args <- commandArgs(trailingOnly = TRUE, asValues = TRUE)
counts2sce <-
function(dir.name, ...) {    
    library(DropletUtils)
    dir.name <- file.path(dir.name, "Gene/filtered")
    sce <- read10xCounts(dir.name, ...)
    saveRDS(sce, file = "counts_sce.rds")
}
do.call(counts2sce, args)
