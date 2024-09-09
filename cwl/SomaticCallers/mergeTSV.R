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
