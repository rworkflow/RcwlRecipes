## samtools sort bam
p1 <- InputParam(id = "bam", type = "File")
o1 <- OutputParam(id = "sbam", type = "File", glob = "$(inputs.bam.nameroot).sorted.bam")
req1 <- requireDocker("quay.io/biocontainers/samtools:1.12--h9aed4be_1")
samtools_sort <- cwlProcess(baseCommand = c("samtools", "sort"),
                            requirements = list(req1),
                            inputs = InputParamList(p1),
                            outputs = OutputParamList(o1),
                            stdout = "$(inputs.bam.nameroot).sorted.bam")
