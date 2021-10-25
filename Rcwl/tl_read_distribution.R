## read distribution
p1 <- InputParam(id = "bam", type = "File", prefix = "-i", secondaryFiles = ".bai")
p2 <- InputParam(id = "bed", type = "File", prefix = "-r")
o1 <- OutputParam(id = "distOut", type = "File", glob = "$(inputs.bam.nameroot).distribution.txt")
## req1 <- list(class = "DockerRequirement",
##              dockerPull = "hubentu/rcwl-rnaseq")
req1 <- requireDocker("quay.io/biocontainers/rseqc:4.0.0--py38h4a8c8d9_1")
read_distribution <- cwlProcess(baseCommand = c("read_distribution.py"),
                              requirements = list(req1),
                              inputs = InputParamList(p1, p2),
                              outputs = OutputParamList(o1),
                              stdout = "$(inputs.bam.nameroot).distribution.txt")
