## ucsc toolkit
p1 <- InputParam(id = "bw", type = "File", position = 1)
p2 <- InputParam(id = "wig", type = "string", position = 2)
o1 <- OutputParam(id = "wigOut", type = "File", glob = "$(inputs.wig)")
req1 <- list(class = "DockerRequirement",
             dockerPull = "biowardrobe2/ucscuserapps:v358_2")
bigWigToWig <- cwlProcess(baseCommand = "bigWigToWig",
                        requirements = list(req1),
                        inputs = InputParamList(p1, p2),
                        outputs = OutputParamList(o1))



bigWigToWig <- addMeta(
    bigWigToWig,
    label = "bigWigToWig",
    doc = "Convert bigWig to wig.",
    inputLabels = c("bw","wig"),
    inputDocs = c("Input bigwig file","Name of the output wig file"),
    outputLabels = c("wigOut"),
    outputDocs = c("Output wig file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/ENCODE-DCC/kentUtils",
        example = paste()
    )
)
