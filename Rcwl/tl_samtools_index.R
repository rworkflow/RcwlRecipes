## Index bam
p1 <- InputParam(id = "bam", type = "File", position = 1)
o1 <- OutputParam(id = "idx", type = "File", glob = "$(inputs.bam.basename)",
                  secondaryFiles = list(".bai"))
req2 <- list(class = "DockerRequirement",
             dockerPull = "quay.io/biocontainers/samtools:1.12--h9aed4be_1")
req3 <- list(class = "InitialWorkDirRequirement",
             listing = list("$(inputs.bam)"))
samtools_index <- cwlProcess(baseCommand = c("samtools", "index"),
                           requirements = list(req2, req3),
                           inputs = InputParamList(p1),
                           outputs = OutputParamList(o1))


samtools_index <- addMeta(
    samtools_index,
    label = "samtools_index",
    doc = "Create an index for BAM or CRAM files",
    inputLabels = c("bam"),
    inputDocs = c("Input bam file"),
    outputLabels = c("idx"),
    outputDocs = c("Output index file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/samtools/samtools",
        example = paste()
    )
)
