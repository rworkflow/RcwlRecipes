## samtools merge bams
p1 <- InputParam(id = "bam", type = "File[]", position = 99L)
p2 <- InputParam(id = "mbam", type = "string", position = 1L)
o1 <- OutputParam(id = "mBam", type = "File", glob = "$(inputs.mbam)")
req1 <- requireDocker("quay.io/biocontainers/samtools:1.12--h9aed4be_1")
samtools_merge <- cwlProcess(baseCommand = c("samtools", "merge"),
                            requirements = list(req1),
                            inputs = InputParamList(p1, p2),
                            outputs = OutputParamList(o1))
