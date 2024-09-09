DropletUtils <- function(dir.name, lower=100, df=20, ...) {    
    library(DropletUtils)
    dir.name <- file.path(dir.name, "Gene/raw")
    sce <- read10xCounts(dir.name, ...)
    br.out <- barcodeRanks(assay(sce), lower=lower, df=df)
    o <- order(br.out$rank)
    e.out <- emptyDrops(assay(sce))
    is.cell <- e.out$FDR <= 0.01
    pdf(file = "diagnostics.pdf")
    plot(br.out$rank, br.out$total, log="xy", xlab="Rank", ylab="Total",
         main = "Barcode Ranks")
    lines(br.out$rank[o], br.out$fitted[o], col="red")
    abline(h=metadata(br.out)$knee, col="dodgerblue", lty=2)
    abline(h=metadata(br.out)$inflection, col="forestgreen", lty=2)
    legend("bottomleft", lty=2, col=c("dodgerblue", "forestgreen"),
           legend=c("knee", "inflection"))
    plot(e.out$Total, -e.out$LogProb, col=ifelse(is.cell, "red", "black"),
         xlab="Total UMI count", ylab="-Log Probability",
         main = "Empty Droplets")
    dev.off()
    sce1 <- sce[, which(is.cell == "TRUE")]
    saveRDS(sce1, file = "sce_filtered.rds")
}

## write out the R function as `cwlProcess`. 
p1 <- InputParam(id = "dirname", type = "Directory", prefix = "dir.name=", separate = FALSE)
p2 <- InputParam(id = "lower", type = "int", prefix = "lower=", separate = FALSE, default = 100L)
p3 <- InputParam(id = "df", type = "int", prefix = "df=", separate = FALSE, default = 20L)
o1 <- OutputParam(id = "plots", type = "File", glob = "*.pdf")
o2 <- OutputParam(id = "outsce", type = "File", glob = "*.rds")
DropletUtils <- cwlProcess(baseCommand = DropletUtils,
                      inputs = InputParamList(p1, p2, p3),
                      outputs = OutputParamList(o1, o2))


DropletUtils <- addMeta(
    DropletUtils,
    label = "DropletUtils",
    doc = "Read raw 10x Genomics data from a specified directory, applies filtering to distinguish true cells from empty droplets using barcode ranking and the emptyDrops() function, and generates diagnostic plots.",
    inputLabels = c("dirname","lower","df"),
    inputDocs = c("Name of the input directory","A numeric scalar specifying the lower bound on the total UMI count, at or below which all barcodes are assumed to correspond to empty droplets","Degree of freadom"),
    outputLabels = c("plots","outsce"),
    outputDocs = c("Diagnostic Plots visualizing the barcode ranks and empty drops filtering process.","Filtered SCE Object containing only the droplets identified as true cells."),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/MarioniLab/DropletUtils",
        example = paste()
    )
)
