## https://sequenza-utils.readthedocs.io/en/latest/
p1 <- InputParam(id = "window", type = "int", prefix = "-w")
p2 <- InputParam(id = "ref", type = "File", prefix = "-f")
p3 <- InputParam(id = "out", type = "string", prefix = "-o")
o1 <- OutputParam(id = "wig", type = "File", glob = "$(inputs.out)")
r1 <- requireDocker("quay.io/biocontainers/sequenza-utils:3.0.0--py39h67e14b5_5")
gc_wiggle <- cwlProcess(baseCommand = c("sequenza-utils", "gc_wiggle"),
                        requirements = list(r1),
                        inputs = InputParamList(p1, p2, p3),
                        outputs = OutputParamList(o1))
