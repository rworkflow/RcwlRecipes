## https://github.com/mskilab-org/fragCounter
p1 <- InputParam(id = "bam", type = "File", prefix = "-b", secondaryFiles = list(".bai?", "^.bai?"))
p2 <- InputParam(id = "gcmap", type = "Directory", prefix = "-d")
p3 <- InputParam(id = "window", type = "int", prefix = "-w")
p4 <- InputParam(id = "mapq", type = "int?", prefix = "-q")
o1 <- OutputParam(id = "bw", type = "File", glob = "cov.corrected.bw")
o2 <- OutputParam(id = "rds", type = "File", glob = "cov.rds")
req1 <- requireDocker("hubentu/jabba")
fragCounter <- cwlProcess(cwlVersion = "v1.2",
                          baseCommand = "frag",
                          requirements = list(req1),
                          inputs = InputParamList(p1, p2, p3, p4),
                          outputs = OutputParamList(o1, o2))
