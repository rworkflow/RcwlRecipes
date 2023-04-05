p1 <- InputParam(id = "bam", type = "File", prefix = "-b")
p2 <- InputParam(id = "gtf", type = "File", prefix = "-g")
p3 <- InputParam(id = "paired", type = "boolean?", prefix = "-p", default = TRUE)
p4 <- InputParam(id = "all", type = "boolean?", prefix = "-a", default = TRUE)
o1 <- OutputParam(id = "out", type = "File[]", glob = "*.out")
o2 <- OutputParam(id = "ent", type = "File[]?", glob = "*.ent")
o3 <- OutputParam(id = "uni", type = "File[]?", glob = "*.uni")
req1 <- requireDocker(searchContainer("tpmcalculator")$container[1])
TPMCalculator <- cwlProcess(baseCommand = "TPMCalculator",
                            requirements = list(req1),
                            inputs = InputParamList(p1, p2, p3, p4),
                            outputs = OutputParamList(o1, o2, o3))
