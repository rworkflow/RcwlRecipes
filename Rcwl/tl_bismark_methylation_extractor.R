p1 <- InputParam(id = "paired", type = "boolean?", prefix = "-p")
p2 <- InputParam(id = "single", type = "boolean?", prefix = "-s")
p3 <- InputParam(id = "bedGraph", type = "boolean?", prefix = "--bedGraph", default = TRUE)
p4 <- InputParam(id = "gzip", type = "boolean?", prefix = "--gzip", default = TRUE)
p5 <- InputParam(id = "core", type = "int", prefix = "--multicore", default = 4)
p6 <- InputParam(id = "bam", type = "File", position = 10)
o1 <- OutputParam(id = "cov", type = "File", glob = "*.cov*")
o2 <- OutputParam(id = "Bed", type = "File?", glob = "*.bedGraph*")
o3 <- OutputParam(id = "report", type = "File[]", glob = "*.txt")
req1 <- requireDocker("quay.io/biocontainers/bismark:0.23.1--hdfd78af_0")
bismark_methylation_extractor <- cwlProcess(baseCommand = "bismark_methylation_extractor",
                                            requirements = list(req1),
                                            inputs = InputParamList(p1, p2, p3, p4, p5, p6),
                                            outputs = OutputParamList(o1, o2, o3))
