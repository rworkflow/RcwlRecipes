.libPaths('/home/hq/R/x86_64-pc-linux-gnu-library/4.0')
suppressPackageStartupMessages(library(R.utils))
suppressPackageStartupMessages(library(codetools))
args <- commandArgs(trailingOnly = TRUE, asValues = TRUE)
SomaticCallers <-
function(esnv, eindel){
    snv1 <- read.table(esnv, header = TRUE)
    indel1 <- read.table(eindel, header = TRUE)
    var1 <- rbind(snv1, indel1)
    var1[is.na(var1)] <- 0
    write.table(var1, file = "Ensemble.sVar.tsv",
                row.names = FALSE, sep = "\t", quote = FALSE)
}
do.call(SomaticCallers, args)
