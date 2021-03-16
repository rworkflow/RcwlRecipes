.libPaths('/Users/qi28068/homebrew/lib/R/4.0/site-library')
.libPaths('/Users/qi28068/homebrew/Cellar/r/4.0.4_2/lib/R/library')
suppressPackageStartupMessages(library(R.utils))
args <- commandArgs(trailingOnly = TRUE, asValues = TRUE)
Rsplit <-
function(files, columns, cnames = NULL, outfile, sep = "\t", isep = ",",
                   fixName = TRUE){
    files <- strsplit(files, split = isep)[[1]]
    columns <- strsplit(columns, split = isep)[[1]]
    expL <- lapply(files, function(x){
        exp1 <- read.table(x, sep = sep, header = TRUE, row.names = 1,
                           check.names = FALSE, colClasses = "character")
        if(fixName){
            rownames(exp1) <- sub("\\|.*", "", rownames(exp1))
        }
        exp1[, columns, drop = F]
    })
    Exp <- do.call(cbind, expL)
    if(!is.null(cnames)){
        cnames <- strsplit(cnames, split = isep)[[1]]
        colnames(Exp) <- cnames
    }
    write.table(Exp, file = outfile, quote = FALSE, sep = sep)
}
do.call(Rsplit, args)
