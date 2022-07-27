p1 <- InputParam(id = "bed", type = "File", prefix = "-r")
p2 <- InputParam(id = "bam", type = "File", prefix = "-i", secondaryFiles = ".bai")
p3 <- InputParam(id = "size", type = "int?", prefix = "-s")
o1 <- OutputParam(id = "sout", type = "File", glob = "$(inputs.bam.nameroot).strand.txt")
req1 <- requireDocker("quay.io/biocontainers/rseqc:4.0.0--py38h4a8c8d9_1")
infer_experiment <- cwlProcess(baseCommand = "infer_experiment.py",
                               requirements = list(req1),
                               inputs = InputParamList(p1, p2, p3),
                               outputs = OutputParamList(o1),
                               stdout = "$(inputs.bam.nameroot).strand.txt")
