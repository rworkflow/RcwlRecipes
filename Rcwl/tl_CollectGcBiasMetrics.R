
p1 <- InputParam(id = "bam", type = "File", prefix = "I=", separate = FALSE)
p2 <- InputParam(id = "ref", type = "File", prefix = "R=",
                 separate = FALSE, secondaryFiles = ".fai")
p3 <- InputParam(id = "gc", type = "string", prefix = "O=", separate = FALSE)
p4 <- InputParam(id = "chart", type = "string", prefix = "CHART=", separate = FALSE)
p5 <- InputParam(id = "summary", type = "string", prefix = "S=", separate = FALSE)
o1 <- OutputParam(id = "GC", type = "File", glob = "$(inputs.gc)")
o2 <- OutputParam(id = "Chart", type = "File", glob = "$(inputs.chart)")
o3 <- OutputParam(id = "Summary", type = "File", glob = "$(inputs.summary)")
req1 <- requireDocker("quay.io/biocontainers/picard:2.26.4--hdfd78af_0")
CollectGcBiasMetrics <- cwlProcess(baseCommand = c("picard", "CollectGcBiasMetrics"),
                                   requirements = list(req1),
                                   inputs = InputParamList(p1, p2, p3, p4, p5),
                                   outputs = OutputParamList(o1, o2, o3))


CollectGcBiasMetrics <- addMeta(
    CollectGcBiasMetrics,
    label = "CollectGcBiasMetrics",
    doc = "This tool collects information about the relative proportions of guanine (G) and cytosine (C) nucleotides in a sample.",
    inputLabels = c("bam","ref","gc","chart","summary"),
    inputDocs = c("Input SAM/BAM/CRAM file. Required.","Reference sequence file. Default value: null.","The file to write the output to. Required.","The PDF file to render the chart to. Required.","The text file to write summary metrics to. Required."),
    outputLabels = c("GC","Chart","Summary"),
    outputDocs = c("Detailed information on the GC bias observed at various GC content levels","PDF file containing visualizations of the GC bias metrics","Summary statistics and metrics of GC bias in the sequencing data."),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/broadinstitute/picard",
        example = paste()
    )
)
