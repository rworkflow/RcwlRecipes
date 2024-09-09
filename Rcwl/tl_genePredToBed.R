## genePred to bed
p1 <- InputParam(id = "genePred", type = "File", position = 1)
p2 <- InputParam(id = "Bed", type = "string", position = 2)
o1 <- OutputParam(id = "bed", type = "File", glob = "$(inputs.Bed)")
## req1 <- list(class = "DockerRequirement",
##              dockerPull = "hubentu/rcwl-rnaseq")
req1 <- requireDocker("quay.io/biocontainers/ucsc-genepredtobed:377--h0b8a92a_4")
genePredToBed <- cwlProcess(baseCommand = "genePredToBed",
                            requirements = list(req1),
                            inputs = InputParamList(p1, p2),
                            outputs = OutputParamList(o1))


genePredToBed <- addMeta(
    genePredToBed,
    label = "genePredToBed",
    doc = "Convert from genePred to bed format.",
    inputLabels = c("genePred","Bed"),
    inputDocs = c("Input genePred file","Name of output bed file"),
    outputLabels = c("bed"),
    outputDocs = c("Bed file output"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/ENCODE-DCC/kentUtils",
        example = paste()
    )
)
