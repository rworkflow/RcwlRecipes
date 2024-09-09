
p1 <- InputParam(id = "bam", type = "File")
o1 <- OutputParam(id = "pileup", type = "File", glob = "$(inputs.bam.nameroot).depth.txt")
req1 <- list(class = "DockerRequirement",
             dockerPull = "biocontainers/samtools:v1.7.0_cv3")
samtools_depth <- cwlProcess(baseCommand = c("samtools", "depth"),
                             requirements = list(req1),
                             inputs = InputParamList(p1),
                             outputs = OutputParamList(o1),
                             stdout = "$(inputs.bam.nameroot).depth.txt")


samtools_depth <- addMeta(
    samtools_depth,
    label = "samtools_depth",
    doc = "Tool to calculate the depth of coverage at each position in a BAM or CRAM file.",
    inputLabels = c("bam"),
    inputDocs = c("Input bam file"),
    outputLabels = c("pileup"),
    outputDocs = c("The primary output is a tab-delimited text file or standard output listing the coverage depth for each position in the reference genome."),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/samtools/samtools",
        example = paste()
    )
)
