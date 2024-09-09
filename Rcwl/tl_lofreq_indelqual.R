p1 <- InputParam(id = "ref", type = "File", prefix = "-f",
                 secondaryFiles = ".fai", position = 1)
p2 <- InputParam(id = "bam", type = "File", position = 2)
p3 <- InputParam(id = "ibam", type = "string", position = -1)
o1 <- OutputParam(id = "obam", type = "File", glob = "$(inputs.ibam)")
req1 <- requireDocker("quay.io/biocontainers/lofreq:2.1.5--py37h916d2e8_4")
lofreq_indelqual <- cwlProcess(baseCommand = c("lofreq", "indelqual"),
                               requirements = list(req1),
                               arguments = list("--dindel", "--verbose"),
                               inputs = InputParamList(p1, p2, p3),
                               outputs = OutputParamList(o1),
                               stdout = "$(inputs.ibam)")


lofreq_indelqual <- addMeta(
    lofreq_indelqual,
    label = "lofreq_indelqual",
    doc = "Insert indel qualities into BAM file",
    inputLabels = c("ref","bam","ibam"),
    inputDocs = c("Reference sequence used for mapping (Only required for --dindel)","Input bam file","indexed bam file"),
    outputLabels = c("obam"),
    outputDocs = c("Output bam file with indel qual"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/CSB5/lofreq",
        example = paste()
    )
)
