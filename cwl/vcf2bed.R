.libPaths('/home/qhu/miniconda3/envs/r-base/lib/R/library')
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
