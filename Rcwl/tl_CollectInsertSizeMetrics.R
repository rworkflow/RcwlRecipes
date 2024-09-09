p1 <- InputParam(id = "bam", type = "File", prefix = "I=", separate = FALSE)
p2 <- InputParam(id = "metrics", type = "string", prefix = "O=", separate = FALSE)
p3 <- InputParam(id = "hist", type = "string", prefix = "H=", separate = FALSE)
o1 <- OutputParam(id = "Metrics", type = "File", glob = "$(inputs.metrics)")
o2 <- OutputParam(id = "Hist", type = "File", glob = "$(inputs.hist)")
req1 <- requireDocker("quay.io/biocontainers/picard:2.21.1--0")
CollectInsertSizeMetrics <- cwlProcess(baseCommand = c("picard", "CollectInsertSizeMetrics"),
                                     requirements = list(req1),
                                     inputs = InputParamList(p1, p2, p3),
                                     outputs = OutputParamList(o1, o2))


CollectInsertSizeMetrics <- addMeta(
    CollectInsertSizeMetrics,
    label = "CollectInsertSizeMetrics",
    doc = "This tool provides useful metrics for validating library construction including the insert size distribution and read orientation of paired-end libraries.",
    inputLabels = c("bam","metrics","hist"),
    inputDocs = c("Input SAM or BAM file. Required.","File to write the output to. Required.","File to write insert size Histogram chart to. Required."),
    outputLabels = c("Metrics","Hist"),
    outputDocs = c("Summary statistics about the insert size distribution across the sequencing data.","histogram that visually represents the distribution of insert sizes in the dataset."),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/broadinstitute/picard",
        example = paste()
    )
)
