p1 <- InputParam(id = "ref", type = "File", prefix = "-f",
                 secondaryFiles = ".fai", position = 1)
p2 <- InputParam(id = "bam", type = "File", position = 2)
p3 <- InputParam(id = "ibam", type = "string", position = -1)
o1 <- OutputParam(id = "obam", type = "File", glob = "$(inputs.ibam)")
req1 <- requireDocker("quay.io/biocontainers/lofreq:2.1.5--py37h916d2e8_4")
lofreq_indelqual <- cwlProcess(baseCommand = c("lofreq", "indelqual"),
                               requirements = list(req1),
                               arguments = list("--dindel", "--verbose"),
                               inputs = InputParamList(p1, p2, p3),
                               outputs = OutputParamList(o1),
                               stdout = "$(inputs.ibam)")
