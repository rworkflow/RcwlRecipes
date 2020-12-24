.libPaths('/home/hq/R/x86_64-pc-linux-gnu-library/4.0')
suppressPackageStartupMessages(library(R.utils))
suppressPackageStartupMessages(library(codetools))
args <- commandArgs(trailingOnly = TRUE, asValues = TRUE)
vcfExpression <-
function(afile) {
    exp1 <- read.table(afile, header = TRUE, stringsAsFactors = FALSE)
    exp1[,1] <- sub("\\|ENSG.*", "", exp1[,1])
    write.table(exp1, file = "abundance_clean.tsv",
                row.names = FALSE, quote = FALSE, sep = "\t")
}
do.call(vcfExpression, args)
