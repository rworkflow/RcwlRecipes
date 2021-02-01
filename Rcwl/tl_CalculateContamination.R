## CalculateContamination
p1 <- InputParam(id = "ttable", type = "File", prefix = "-I")
p2 <- InputParam(id = "ntable", type = "File", prefix = "-matched")
p3 <- InputParam(id = "cont", type = "string", prefix = "-O")
p4 <- InputParam(id = "seg", type = "string", prefix = "-segments")
o1 <- OutputParam(id = "Cout", type = "File", glob = "$(inputs.cont)")
o2 <- OutputParam(id = "Seg", type = "File", glob = "$(inputs.seg)")
req1 <- requireDocker("broadinstitute/gatk:latest")
CalculateContamination <- cwlProcess(baseCommand = c("gatk", "CalculateContamination"),
                                   requirements = list(req1),
                                   inputs = InputParamList(p1, p2, p3, p4),
                                   outputs = OutputParamList(o1, o2))
