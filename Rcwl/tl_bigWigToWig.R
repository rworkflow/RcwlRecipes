## ucsc toolkit
p1 <- InputParam(id = "bw", type = "File", position = 1)
p2 <- InputParam(id = "wig", type = "string", position = 2)
o1 <- OutputParam(id = "wigOut", type = "File", glob = "$(inputs.wig)")
req1 <- list(class = "DockerRequirement",
             dockerPull = "biowardrobe2/ucscuserapps:v358_2")
bigWigToWig <- cwlParam(baseCommand = "bigWigToWig",
                        requirements = list(req1),
                        inputs = InputParamList(p1, p2),
                        outputs = OutputParamList(o1))

