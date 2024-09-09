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


counts2sce <- addMeta(
    counts2sce,
    label = "counts2sce",
    doc = "reads in 10x Genomics single-cell RNA-seq data, processes it into a SingleCellExperiment (SCE) object,",
    inputLabels = c("dirname"),
    inputDocs = c("directory containing the output files from a 10x Genomics pipeline"),
    outputLabels = c("outsce"),
    outputDocs = c("SCE object outputted"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "NA",
        example = paste()
    )
)
