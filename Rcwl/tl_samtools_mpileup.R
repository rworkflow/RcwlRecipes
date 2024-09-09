
p1 <- InputParam(id = "bam", type = "File")
p2 <- InputParam(id = "ref", type = "File",
                 secondaryFiles = ".fai", prefix = "-f")
p3 <- InputParam(id = "region", type = "File?", prefix = "-l")
o1 <- OutputParam(id = "pileup", type = "File", glob = "$(inputs.bam.nameroot).pileup")
req1 <- list(class = "DockerRequirement",
             dockerPull = "biocontainers/samtools:v1.7.0_cv3")
samtools_mpileup <- cwlProcess(baseCommand = c("samtools", "mpileup"),
                             requirements = list(req1),
                             inputs = InputParamList(p1, p2, p3),
                             outputs = OutputParamList(o1),
                             stdout = "$(inputs.bam.nameroot).pileup")


samtools_mpileup <- addMeta(
    samtools_mpileup,
    label = "samtools_mpileup",
    doc = "Create a pileup format output that provides detailed information on the bases aligned to each reference position across multiple samples.",
    inputLabels = c("bam","ref","region"),
    inputDocs = c("Input bam file","faidx indexed reference sequence file","skip unlisted positions (chr pos) or regions (BED)"),
    outputLabels = c("pileup"),
    outputDocs = c("Pileup output"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/samtools/samtools",
        example = paste()
    )
)
