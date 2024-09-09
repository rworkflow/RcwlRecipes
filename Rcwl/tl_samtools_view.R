## samtoolsm view
p1 <- InputParam(id = "bam", type = "File", position = 99, secondaryFiles = ".bai?")
p2 <- InputParam(id = "bed", type = "File?", prefix = "-L", position = 1)
p3 <- InputParam(id = "obam", type = "string", prefix = "-o", position = 2)
p4 <- InputParam(id = "region", type = "string?", position = 100)
p5 <- InputParam(id = "outb", type = "boolean?", prefix = "-b")
p6 <- InputParam(id = "exFlag", type = "int?", prefix = "-F")
## p6 <- InputParam(id = "exFlag", type = InputArrayParam(items = "string", prefix = "-F"))
p7 <- InputParam(id = "reqFlag", type = "int?", prefix = "-f")
## p7 <- InputParam(id = "reqFlag", type = InputArrayParam(items = "string", prefix = "-f"))
p8 <- InputParam(id = "qname", type = "File?", prefix = "-N")
p9 <- InputParam(id = "threads", type = "int?", prefix = "--threads")
p10 <- InputParam(id = "mapq", type = "int?", prefix = "-q")
o1 <- OutputParam(id = "oBam", type = "File", glob = "$(inputs.obam)")
req1 <- requireDocker("quay.io/biocontainers/samtools:1.16.1--h6899075_1")
samtools_view <- cwlProcess(cwlVersion="v1.2",
                            baseCommand = c("samtools", "view"),
                            requirements = list(req1),
                            inputs = InputParamList(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10),
                            outputs = OutputParamList(o1))



samtools_view <- addMeta(
    samtools_view,
    label = "samtools_view",
    doc = "Enable flexible data manipulation for alignment files",
    inputLabels = c("bam","bed","obam","region","outb","exFlag","reqFlag","qname","threads","mapq"),
    inputDocs = c("Input bam file","Only output alignments overlapping the input BED FILE [null].","Output to FILE [stdout].","Region specifications after the input filename to restrict output to only those alignments","Output in the BAM format.","Do not output alignments with any bits set in FLAG present in the FLAG field. FLAG can be specified in hex by beginning with `0x' (i.e. /^0x[0-9A-F]+/), in octal by beginning with `0' (i.e. /^0[0-7]+/), as a decimal number not beginning with '0' or as a comma-separated list of flag names.","Only output alignments with all bits set in FLAG present in the FLAG field. FLAG can be specified in hex by beginning with `0x' (i.e. /^0x[0-9A-F]+/), in octal by beginning with `0' (i.e. /^0[0-7]+/), as a decimal number not beginning with '0' or as a comma-separated list of flag names.","Output only alignments with read names listed in FILE. If FILE starts with ^ then the operation is negated and only outputs alignment with read groups not listed in FILE. It is not permissible to mix both the filter-in and filter-out style syntax in the same command.","Number of BAM compression threads to use in addition to main thread [0].","Skip alignments with MAPQ smaller than INT [0]."),
    outputLabels = c("oBam"),
    outputDocs = c("Output bam file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/samtools/samtools",
        example = paste()
    )
)
