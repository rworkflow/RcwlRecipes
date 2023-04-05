p1 <- InputParam(id = "fast", type = "boolean?", prefix = "-f")
p2 <- InputParam(id = "out", type = "string", prefix = "-o")
p3 <- InputParam(id = "threads", type = "int?", prefix = "--threads")
p4 <- InputParam(id = "bam", type = "File", position = 99)
o1 <- OutputParam(id = "obam", type = "File", glob = "$(inputs.out)")
req1 <- requireDocker("quay.io/biocontainers/samtools:1.16.1--h6899075_1")
samtools_collate <- cwlProcess(baseCommand = c("samtools", "collate"),
                               requirements = list(req1),
                               inputs = InputParamList(p1, p2, p3, p4),
                               outputs = OutputParamList(o1))
