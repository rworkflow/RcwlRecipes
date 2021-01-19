## samtoolsm view
p1 <- InputParam(id = "bam", type = "File", position = 3)
p2 <- InputParam(id = "bed", type = "File?", prefix = "-L", position = 1)
p3 <- InputParam(id = "obam", type = "string", prefix = "-o", position = 2)
p4 <- InputParam(id = "region", type = "string?", position = 4)
o1 <- OutputParam(id = "oBam", type = "File", glob = "$(inputs.obam)")
req1 <- requireDocker("biocontainers/samtools:1.11--h6270b1f_0")
samtools_view <- cwlParam(baseCommand = c("samtools", "view"),
                          requirements = list(req1),
                          inputs = InputParamList(p1, p2, p3, p4),
                          outputs = OutputParamList(o1))
