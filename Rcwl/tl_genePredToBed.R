## genePred to bed
p1 <- InputParam(id = "genePred", type = "File", position = 1)
p2 <- InputParam(id = "Bed", type = "string", position = 2)
o1 <- OutputParam(id = "bed", type = "File", glob = "$(inputs.Bed)")
## req1 <- list(class = "DockerRequirement",
##              dockerPull = "hubentu/rcwl-rnaseq")
req1 <- requireDocker("quay.io/biocontainers/ucsc-genepredtobed:377--h0b8a92a_4")
genePredToBed <- cwlProcess(baseCommand = "genePredToBed",
                            requirements = list(req1),
                            inputs = InputParamList(p1, p2),
                            outputs = OutputParamList(o1))
