## samtools sam to bam
p1 <- InputParam(id = "sam", type = "File")
o1 <- OutputParam(id = "bam", type = "File", glob = "$(inputs.sam.basename).bam")
req2 <- list(class = "DockerRequirement",
             dockerPull = "quay.io/biocontainers/samtools:1.16.1--h6899075_1")
sam2bam <- cwlProcess(baseCommand = c("samtools", "view"),
                    arguments = list("-b"),
                    requirements = list(req2),
                    inputs = InputParamList(p1),
                    outputs = OutputParamList(o1),
                    stdout = "$(inputs.sam.basename).bam")


sam2bam <- addMeta(
    sam2bam,
    label = "sam2bam",
    doc = "Convert Sam to bam file",
    inputLabels = c("sam"),
    inputDocs = c("Input sam file"),
    outputLabels = c("bam"),
    outputDocs = c("Bam file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/samtools/samtools",
        example = paste()
    )
)
