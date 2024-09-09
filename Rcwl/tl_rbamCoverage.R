bamCov <- function(bam, bed, ct = "1000,10000"){
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

p1 <- InputParam(id = "bam", type = "File", secondaryFile = ".bai",
                 prefix = "bam=", separate = FALSE, position = 1)
p2 <- InputParam(id = "bed", type = "File",
                 prefix = "bed=", separate = FALSE, position = 2)
p3 <- InputParam(id = "ct", type = "string[]", prefix = "ct=",
                 separate = FALSE, itemSeparator = ",", position = 3)
o1 <- OutputParam(id = "cov", type = "File", glob = "*_cov.csv")
rbamCoverage <- cwlProcess(baseCommand = bamCov,
                           inputs = InputParamList(p1, p2, p3),
                           outputs = OutputParamList(o1))


rbamCoverage <- addMeta(
    rbamCoverage,
    label = "rbamCoverage",
    doc = "Reads a BAM file to calculate the mean coverage and the fraction of bases meeting specified thresholds over genomic regions from a BED file.",
    inputLabels = c("bam","bed","ct"),
    inputDocs = c("A BAM file containing aligned sequencing reads.","A BED file specifying genomic regions of interest where coverage should be calculated","A string specifying coverage thresholds separated by commas"),
    outputLabels = c("cov"),
    outputDocs = c("Output csv file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/deeptools/deepTools",
        example = paste()
    )
)
