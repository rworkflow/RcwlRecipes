p1 <- InputParam(id = "fast", type = "boolean?", prefix = "-f")
p2 <- InputParam(id = "out", type = "string", prefix = "-o")
p3 <- InputParam(id = "threads", type = "int?", prefix = "--threads")
p4 <- InputParam(id = "bam", type = "File", position = 99)
o1 <- OutputParam(id = "obam", type = "File", glob = "$(inputs.out)")
req1 <- requireDocker("quay.io/biocontainers/samtools:1.16.1--h6899075_1")
samtools_collate <- cwlProcess(baseCommand = c("samtools", "collate"),
                               requirements = list(req1),
                               inputs = InputParamList(p1, p2, p3, p4),
                               outputs = OutputParamList(o1))


samtools_collate <- addMeta(
    samtools_collate,
    label = "samtools_collate",
    doc = "provide a fast, memory-efficient way to sort or group reads by their name without requiring a large amount of disk space or RAM",
    inputLabels = c("fast","out","threads","bam"),
    inputDocs = c("fast (only primary alignments)","output file name (use prefix if not set)","Number of additional threads to use [0]","Input bam file"),
    outputLabels = c("obam"),
    outputDocs = c("Output of BAM or CRAM file with reads approximately sorted by name"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/samtools/samtools",
        example = paste()
    )
)
