## gtf to genePred
p1 <- InputParam(id = "gtf", type = "File", position = 1)
p2 <- InputParam(id = "gPred", type = "string", position = 2)
o1 <- OutputParam(id = "genePred", type = "File", glob = "$(inputs.gPred)")
## req1 <- list(class = "DockerRequirement",
##              dockerPull = "hubentu/rcwl-rnaseq")
req1 <- requireDocker("quay.io/biocontainers/ucsc-gtftogenepred:377--h0b8a92a_4")
gtfToGenePred <- cwlProcess(baseCommand = "gtfToGenePred",
                            arguments = list("-genePredExt"),
                            requirements = list(req1),
                            inputs = InputParamList(p1, p2),
                            outputs = OutputParamList(o1))
