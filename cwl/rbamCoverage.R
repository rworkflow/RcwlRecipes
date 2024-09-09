.libPaths(c('/projects/rpci/songliu/qhu/miniconda3/envs/r-base/lib/R/library'))
suppressPackageStartupMessages(library(R.utils))
args <- commandArgs(trailingOnly = TRUE, asValues = TRUE)
rbamCoverage <-
function(bam, bed, ct = "1000,10000"){
    library(GenomicAlignments)
    bed <- read.table(bed)
    gr <- GRanges(bed[,1], IRanges(bed[,2]+1, bed[,3]))
    gr <- reduce(gr)
    cov <- c()
    for(i in 1:length(gr)){
        a1 <- readGAlignments(bam, param = ScanBamParam(which=gr[i]))
        if(length(a1)>0){
            cr <- coverage(ranges(a1))
            if(length(cr) < end(gr[i])){
                cr <- c(cr, rep(0, end(gr[i]) - length(cr)))
            }
            cov1 <- cr[start(gr[i]):end(gr[i])]
            cov <- c(cov, cov1)
        }
    }
    cov <- unlist(RleList(cov))
    
    ct <- as.integer(unlist(strsplit(ct, split = ",")))
    cts <- sapply(ct, function(x)mean(cov>=x))
    csum <- c(mean(cov), cts)
    csum <- rbind(csum)
    colnames(csum) <- c("mean", paste0(">=", ct))
    write.csv(csum, paste0(sub(".bam", "", basename(bam)), "_cov.csv"), row.names=FALSE)
}
do.call(rbamCoverage, args)
