## samtools merge bams
p1 <- InputParam(id = "bam", type = "File[]", position = 99L)
p2 <- InputParam(id = "mbam", type = "string", position = 1L)
o1 <- OutputParam(id = "mBam", type = "File", glob = "$(inputs.mbam)")
req1 <- requireDocker("quay.io/biocontainers/samtools:1.12--h9aed4be_1")
samtools_merge <- cwlProcess(baseCommand = c("samtools", "merge"),
                            requirements = list(req1),
                            inputs = InputParamList(p1, p2),
                            outputs = OutputParamList(o1))


samtools_merge <- addMeta(
    samtools_merge,
    label = "samtools_merge",
    doc = "Combine multiple alignment files into one, maintaining the integrity of the data and preserving all alignment information.",
    inputLabels = c("bam","mbam"),
    inputDocs = c("Input bam file","Name of the merged bam file"),
    outputLabels = c("mBam"),
    outputDocs = c("Merged bam file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/samtools/samtools",
        example = paste()
    )
)
