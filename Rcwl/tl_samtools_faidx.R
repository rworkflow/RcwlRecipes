## bam faidx
p1 <- InputParam(id = "fa", type = "File", secondaryFiles = ".fai")
p2 <- InputParam(id = "region", type = "string", position = 1)
o1 <- OutputParam(id = "fout", type = "File", glob = "$(inputs.fa.nameroot)_$(inputs.region).fa")
req2 <- list(class = "DockerRequirement",
             dockerPull = "quay.io/biocontainers/samtools:1.15--h1170115_1")
samtools_faidx <- cwlProcess(baseCommand = c("samtools", "faidx"),
                             requirements = list(req2),
                             inputs = InputParamList(p1, p2),
                             outputs = OutputParamList(o1),
                             stdout = "$(inputs.fa.nameroot)_$(inputs.region).fa")


samtools_faidx <- addMeta(
    samtools_faidx,
    label = "samtools_faidx",
    doc = "Used to index a FASTA file",
    inputLabels = c("fa","region"),
    inputDocs = c("Input fasta file","File of regions. Format is chr:from-to. One per line."),
    outputLabels = c("fout"),
    outputDocs = c("Indexed file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/samtools/samtools",
        example = paste()
    )
)
