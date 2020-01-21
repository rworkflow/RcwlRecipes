suppressPackageStartupMessages(library(R.utils))
suppressPackageStartupMessages(library(codetools))
args <- commandArgs(trailingOnly = TRUE, asValues = TRUE)
Funa975624ec2b6 <-
function(afile) {
    exp1 <- read.table(afile, header = TRUE, stringsAsFactors = FALSE)
    exp1[,1] <- sub("\\|ENSG.*", "", exp1[,1])
    write.table(exp1, file = "abundance_clean.tsv",
                row.names = FALSE, quote = FALSE, sep = "\t")
}
do.call(Funa975624ec2b6, args)
