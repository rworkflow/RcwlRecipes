p1 <- InputParam(id = "fq1", type = "string", prefix = "-1")
p2 <- InputParam(id = "fq2", type = "string?", prefix = "-2")
p3 <- InputParam(id = "fq0", type = "string?", prefix = "-0")
p4 <- InputParam(id = "bam", type = "File", position = 99)
p5 <- InputParam(id = "threads", type = "int?", prefix = "--threads")
o1 <- OutputParam(id = "FQ1", type = "File", glob = "$(inputs.fq1)")
o2 <- OutputParam(id = "FQ2", type = "File?", glob = "$(inputs.fq2)")
o3 <- OutputParam(id = "FQ0", type = "File?", glob = "$(inputs.fq0)")
req1 <- requireDocker("quay.io/biocontainers/samtools:1.16.1--h6899075_1")
samtools_fastq <- cwlProcess(baseCommand = c("samtools", "fastq"),
                             requirements = list(req1),
                             inputs = InputParamList(p1, p2, p3, p4, p5),
                             outputs = OutputParamList(o1, o2, o3))
