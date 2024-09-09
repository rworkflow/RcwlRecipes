## glob outputs
## rscripts <- "args <- commandArgs(TRUE)
## logFile <- args[1]
## log1 <- readLines(logFile)
## startn <- grep('Final Outputs:', log1)+1
## endn <- grep('}$', log1)
## endn <- endn[endn > startn][1]
## logOut <- jsonlite::fromJSON(log1[startn:endn])
## logOut <- logOut[lengths(logOut)>0]
## dir.create('output', showWarnings = FALSE)
## lapply(logOut, function(x)file.rename(x, file.path('output', basename(x))))"
## rscripts <- gsub("\n", "; ", rscripts)

## p1 <- InputParam(id = "logFile", type = "File")
## o1 <- OutputParam(id = "OutDir", type = "Directory", glob = "output")
## mvOut <- cwlProcess(baseCommand = c("Rscript", "-e", rscripts),
##                   inputs = InputParamList(p1),
##                   outputs = OutputParamList(o1))
## #' @importFrom jsonlite fromJSON
mvout <- function(logFile){
    log1 <- readLines(logFile)
    startn <- grep('Final Outputs:', log1)+1
    endn <- grep('}$', log1)
    endn <- endn[endn > startn][1]
    logOut <- jsonlite::fromJSON(log1[startn:endn])
    logOut <- logOut[lengths(logOut)>0]
    dir.create('output', showWarnings = FALSE)
    lapply(logOut, function(x)file.rename(x, file.path('output', basename(x))))
}

p1 <- InputParam(id = "logFile", type = "File", prefix = "logFile=", separate = F)
o1 <- OutputParam(id = "OutDir", type = "Directory", glob = "output")
mvOut <- cwlProcess(baseCommand = mvout,
                  id = "mvOut",
                  inputs = InputParamList(p1),
                  outputs = OutputParamList(o1))


mvOut <- addMeta(
    mvOut,
    label = "mvOut",
    doc = "Consolidates all output files into a single directory, making it easier to manage and access them.",
    inputLabels = c("logFile"),
    inputDocs = c("Input log file"),
    outputLabels = c("OutDir","OutDir"),
    outputDocs = c("Output folder to move","Moved output directory"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "NA",
        example = paste()
    )
)
