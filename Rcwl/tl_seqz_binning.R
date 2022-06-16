p1 <- InputParam(id = "seqz", type = "File", prefix = "--seqz")
p2 <- InputParam(id = "window", type = "int", prefix = "-w")
p3 <- InputParam(id = "out", type = "string", prefix = "-o")
o1 <- OutputParam(id = "seqzs", type = "File", glob = "$(inputs.out)")
r1 <- requireDocker("quay.io/biocontainers/sequenza-utils:3.0.0--py39h67e14b5_5")
seqz_binning <- cwlProcess(baseCommand = c("sequenza-utils", "seqz_binning"),
                           requirements = list(r1),
                           inputs = InputParamList(p1, p2, p3),
                           outputs = OutputParamList(o1))
