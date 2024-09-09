## gtf to genePred
p1 <- InputParam(id = "gtf", type = "File", position = 1)
p2 <- InputParam(id = "gPred", type = "string", position = 2)
o1 <- OutputParam(id = "genePred", type = "File", glob = "$(inputs.gPred)")
## req1 <- list(class = "DockerRequirement",
##              dockerPull = "hubentu/rcwl-rnaseq")
req1 <- requireDocker("quay.io/biocontainers/ucsc-gtftogenepred:377--h0b8a92a_4")
gtfToGenePred <- cwlProcess(baseCommand = "gtfToGenePred",
                            arguments = list("-genePredExt"),
                            requirements = list(req1),
                            inputs = InputParamList(p1, p2),
                            outputs = OutputParamList(o1))


gtfToGenePred <- addMeta(
    gtfToGenePred,
    label = "gtfToGenePred",
    doc = "convert a GTF file to a genePred",
    inputLabels = c("gtf","gPred"),
    inputDocs = c("Input gtf file","Name of output gPred file"),
    outputLabels = c("genePred"),
    outputDocs = c("Output gPred file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/ENCODE-DCC/kentUtils",
        example = paste()
    )
)
