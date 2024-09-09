## samtools sort bam
p1 <- InputParam(id = "bam", type = "File")
o1 <- OutputParam(id = "sbam", type = "File", glob = "$(inputs.bam.nameroot).sorted.bam")
req2 <- list(class = "DockerRequirement",
             dockerPull = "biocontainers/samtools:v1.7.0_cv3")
sortBam <- cwlProcess(baseCommand = c("samtools", "sort"),
                    requirements = list(req2),
                    inputs = InputParamList(p1),
                    outputs = OutputParamList(o1),
                    stdout = "$(inputs.bam.nameroot).sorted.bam")


sortBam <- addMeta(
    sortBam,
    label = "sortBam",
    doc = "Sort alignments by leftmost coordinates, by read name when -n or -N are used, by tag contents with -t, or a minimiser-based collation order with -M.",
    inputLabels = c("bam"),
    inputDocs = c("Input bam file"),
    outputLabels = c("sbam"),
    outputDocs = c("Soerted bam file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/samtools/samtools",
        example = paste()
    )
)
