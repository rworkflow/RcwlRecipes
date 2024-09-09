## samtools sort bam
p1 <- InputParam(id = "bam", type = "File")
p2 <- InputParam(id = "obam", type = "string", prefix = "-o")
o1 <- OutputParam(id = "sbam", type = "File", glob = "$(inputs.obam)")
req1 <- requireDocker("quay.io/biocontainers/samtools:1.12--h9aed4be_1")
samtools_sort <- cwlProcess(baseCommand = c("samtools", "sort"),
                            requirements = list(req1),
                            inputs = InputParamList(p1, p2),
                            outputs = OutputParamList(o1))


samtools_sort <- addMeta(
    samtools_sort,
    label = "samtools_sort",
    doc = "Rearrange the reads in a BAM, SAM, or CRAM file so that they are sorted either by their mapping coordinates (chromosome and position) or by their read names",
    inputLabels = c("bam","obam"),
    inputDocs = c("Input bam file","Name of the sorted bam file"),
    outputLabels = c("sbam"),
    outputDocs = c("Sorted bam file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/samtools/samtools",
        example = paste()
    )
)
