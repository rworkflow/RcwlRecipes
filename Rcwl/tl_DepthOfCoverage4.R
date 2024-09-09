
p1 <- InputParam(id = "bam", type = "File",
                 prefix = "-I", secondaryFiles = list(".bai?", "^.bai?"))
p2 <- InputParam(id = "prefix", type = "string", prefix = "-O")
p3 <- InputParam(id = "region", type = "File", prefix = "-L")
p4 <- InputParam(id = "ref", type = "File",
                 prefix = "-R", secondaryFiles = c(".fai", "^.dict"))
p5 <- InputParam(id = "ct", type = InputArrayParam(items = "int",
                                                   prefix = "--summary-coverage-threshold"),
                 default = list(1L, 10L, 20L, 30L))
o1 <- OutputParam(id = "out", type = "File", glob = "$(inputs.prefix).sample_summary")

req1 <- list(class = "DockerRequirement",
             dockerPull = "broadinstitute/gatk:latest")
DepthOfCoverage4 <- cwlProcess(cwlVersion = "v1.2",
                               baseCommand = c("gatk", "DepthOfCoverage"),
                               requirements = list(req1),
                               inputs = InputParamList(p1, p2, p3, p4, p5),
                               outputs = OutputParamList(o1))


DepthOfCoverage4 <- addMeta(
    DepthOfCoverage4,
    label = "DepthOfCoverage4",
    doc = "This tool processes a set of bam files to determine coverage at different levels of partitioning and aggregation Using Lates gatk4",
    inputLabels = c("bam","prefix","region","ref","ct"),
    inputDocs = c("BAM/SAM/CRAM file containing reads This argument must be specified at least once.Required.","Base file location to which to write coverage summary information, must be a path to a file Required.","One or more genomic intervals over which to operate This argument must be specified at least once. Required.","Reference sequence file Required.","Coverage threshold (in percent) for summarizing statistics This argument may be specified 0 or more times. Default value: [15]."),
    outputLabels = c("out"),
    outputDocs = c("Tables pertaining to different coverage summaries."),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/broadinstitute/gatk",
        example = paste()
    )
)
