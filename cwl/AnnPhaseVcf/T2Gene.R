suppressPackageStartupMessages(library(R.utils))
args <- commandArgs(trailingOnly = TRUE, asValues = TRUE)
T2Gene <-
function(kexp){
    e1 <- read.table(kexp, header = TRUE, check.names = FALSE,
                     stringsAsFactors = FALSE, sep = "\t")
    ids <- do.call(rbind, base::strsplit(e1$target_id, split = "\\|"))
    tx2gene  <- data.frame(ids[,1:2])
    gexp <- tximport::tximport(kexp, type = "kallisto", tx2gene = tx2gene, ignoreAfterBar=TRUE)
    gExp <- data.frame(gene = sub("\\..*", "", rownames(gexp$abundance)),
                       abundance = gexp$abundance)
    write.table(gExp, file = "abundance_gene.tsv", row.names = FALSE,
                col.names = TRUE, quote = FALSE, sep = "\t")
}
do.call(T2Gene, args)
