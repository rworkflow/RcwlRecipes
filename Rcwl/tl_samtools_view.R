## samtoolsm view
p1 <- InputParam(id = "bam", type = "File", position = 3)
p2 <- InputParam(id = "bed", type = "File?", prefix = "-L", position = 1)
p3 <- InputParam(id = "obam", type = "string", prefix = "-o", position = 2)
p4 <- InputParam(id = "region", type = "string?", position = 4)
p5 <- InputParam(id = "outb", type = "boolean?", prefix = "-b")
o1 <- OutputParam(id = "oBam", type = "File", glob = "$(inputs.obam)")
req1 <- requireDocker("quay.io/biocontainers/samtools:1.12--h9aed4be_1")
samtools_view <- cwlProcess(baseCommand = c("samtools", "view"),
                          requirements = list(req1),
                          inputs = InputParamList(p1, p2, p3, p4, p5),
                          outputs = OutputParamList(o1))
