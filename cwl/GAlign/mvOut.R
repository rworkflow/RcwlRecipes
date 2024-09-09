suppressPackageStartupMessages(library(R.utils))
args <- commandArgs(trailingOnly = TRUE, asValues = TRUE)
mvOut <-
function(logFile){
    log1 <- readLines(logFile)
    startn <- grep('Final Outputs:', log1)+1
    endn <- grep('}$', log1)
    endn <- endn[endn > startn][1]
    logOut <- jsonlite::fromJSON(log1[startn:endn])
    logOut <- logOut[lengths(logOut)>0]
    dir.create('output', showWarnings = FALSE)
    lapply(logOut, function(x)file.rename(x, file.path('output', basename(x))))
}
do.call(mvOut, args)
