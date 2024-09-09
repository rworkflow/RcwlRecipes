#' split and combine multiple files by column names
rsplit <- function(files, columns, cnames = NULL, outfile, sep = "\t", isep = ",",
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

p1 <- InputParam(id = "files", type = "File[]",
                 prefix = "files=", separate = F, itemSeparator = ",")
p2 <- InputParam(id = "columns", type = "string", prefix = "columns=", separate = F)
p3 <- InputParam(id = "cnames", type = "string?", prefix = "cnames=", separate = F)
p4 <- InputParam(id = "outfile", type = "string", prefix = "outfile=", separate = F)
o1 <- OutputParam(id = "outFile", type = "File", glob = "$(inputs.outfile)")

Rsplit <- cwlProcess(baseCommand = rsplit,
                   inputs = InputParamList(p1, p2, p3, p4),
                   outputs = OutputParamList(o1))


Rsplit <- addMeta(
    Rsplit,
    label = "Rsplit",
    doc = "Split and combine multiple files by column names",
    inputLabels = c("files","columns","cnames","outfile"),
    inputDocs = c("Input files","A string specifying the column names to extract from each input file","An optional parameter. A string containing custom column names to assign to the combined data","he name of the output file where the combined data will be saved."),
    outputLabels = c("outFile"),
    outputDocs = c("Combined output file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "NA",
        example = paste()
    )
)
