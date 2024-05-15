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

