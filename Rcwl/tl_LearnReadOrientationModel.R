## gatk LearnReadOrientationModel -I f1r2.tar.gz -O read-orientation-model.tar.gz
p1 <- InputParam(id = "f1r2", type = "File", prefix = "-I")
p2 <- InputParam(id = "romodel", type = "string", prefix = "-O",
                 default = "read-orientation-model.tar.gz")
o1 <- OutputParam(id = "rofile", type = "File", glob = "$(inputs.romodel)")
req1 <- requireDocker("broadinstitute/gatk:latest")
LearnReadOrientationModel <- cwlProcess(baseCommand = c("gatk", "LearnReadOrientationModel"),
                                      requirements = list(req1),
                                      inputs = InputParamList(p1, p2),
                                      outputs = OutputParamList(o1))
