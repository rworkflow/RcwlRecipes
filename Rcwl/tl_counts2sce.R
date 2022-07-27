counts2sce <- function(dir.name, ...) {    
    library(DropletUtils)
    dir.name <- file.path(dir.name, "Gene/filtered")
    sce <- read10xCounts(dir.name, ...)
    saveRDS(sce, file = "counts_sce.rds")
}

## write out the R function as `cwlProcess`. 
p1 <- InputParam(id = "dirname", type = "Directory", prefix = "dir.name=", separate = FALSE)
o1 <- OutputParam(id = "outsce", type = "File", glob = "*.rds")
counts2sce <- cwlProcess(baseCommand = counts2sce,
                         inputs = InputParamList(p1),
                         outputs = OutputParamList(o1))
