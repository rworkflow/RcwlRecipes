suppressPackageStartupMessages(library(R.utils))
args <- commandArgs(trailingOnly = TRUE, asValues = TRUE)
cleanExp <-
function(afile) {
    exp1 <- read.table(afile, header = TRUE, stringsAsFactors = FALSE)
    exp1[,1] <- sub("\\|ENSG.*", "", exp1[,1])
    write.table(exp1, file = "abundance_clean.tsv",
                row.names = FALSE, quote = FALSE, sep = "\t")
}
do.call(cleanExp, args)
