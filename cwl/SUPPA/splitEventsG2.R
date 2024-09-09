suppressPackageStartupMessages(library(R.utils))
args <- commandArgs(trailingOnly = TRUE, asValues = TRUE)
splitEventsG2 <-
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
do.call(splitEventsG2, args)
