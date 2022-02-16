## samtools sort bam
p1 <- InputParam(id = "bam", type = "File")
p2 <- InputParam(id = "obam", type = "string", prefix = "-o")
o1 <- OutputParam(id = "sbam", type = "File", glob = "$(inputs.obam)")
req1 <- requireDocker("quay.io/biocontainers/samtools:1.12--h9aed4be_1")
samtools_sort <- cwlProcess(baseCommand = c("samtools", "sort"),
                            requirements = list(req1),
                            inputs = InputParamList(p1, p2),
                            outputs = OutputParamList(o1))
