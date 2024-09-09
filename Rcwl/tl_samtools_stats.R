## samtools stats
p1 <- InputParam(id = "bam", type = "File")
o1 <- OutputParam(id = "stats", type = "File", glob = "$(inputs.bam.nameroot).stats.txt")
req2 <- list(class = "DockerRequirement",
             dockerPull = "biocontainers/samtools:v1.7.0_cv3")
samtools_stats <- cwlProcess(baseCommand = c("samtools", "stats"),
                           requirements = list(req2),
                           inputs = InputParamList(p1),
                           outputs = OutputParamList(o1),
                           stdout = "$(inputs.bam.nameroot).stats.txt")


samtools_stats <- addMeta(
    samtools_stats,
    label = "samtools_stats",
    doc = "Provide a detailed statistical summary of the alignment data contained in BAM, SAM, or CRAM files",
    inputLabels = c("bam"),
    inputDocs = c("Input bam file"),
    outputLabels = c("stats"),
    outputDocs = c("Statistical summary"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/samtools/samtools",
        example = paste()
    )
)
