## merge BAMs
p1 <- InputParam(id = "ibam", type = InputArrayParam(items = "File",
                                                    prefix = "I=",
                                                    separate = FALSE))
p2 <- InputParam(id = "obam", type = "string", prefix = "O=", separate = FALSE)
o1 <- OutputParam(id = "oBam", type = "File", glob = "$(inputs.obam)")
req1 <- list(class = "DockerRequirement",
             dockerPull = "quay.io/biocontainers/picard:2.21.1--0")
mergeBam <- cwlProcess(baseCommand = c("picard",
                                     "MergeSamFiles"),
                     requirements = list(req1),
                     inputs = InputParamList(p1, p2),
                     outputs = OutputParamList(o1))


mergeBam <- addMeta(
    mergeBam,
    label = "mergeBam",
    doc = "Merges multiple SAM and/or BAM files into a single file.",
    inputLabels = c("ibam","obam"),
    inputDocs = c("SAM or BAM input file Default value: null. This option must be specified at least 1 times.","SAM or BAM file to write merged result to Required."),
    outputLabels = c("oBam"),
    outputDocs = c("Merged bam file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/broadinstitute/picard",
        example = paste()
    )
)
