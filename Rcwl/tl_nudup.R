p1 <- InputParam(id = "index", type = "File", prefix = "-f")
p2 <- InputParam(id = "paired", type = "boolean?", prefix = "-2")
p3 <- InputParam(id = "out", type = "string", prefix = "-o")
p4 <- InputParam(id = "sam", type = "File", position = 10)
o1 <- OutputParam(id = "mbam", type = "File", glob = "$(inputs.out).sorted.markdup.bam")
o2 <- OutputParam(id = "dbam", type = "File", glob = "$(inputs.out).sorted.dedup.bam")
o3 <- OutputParam(id = "report", type = "File", glob = "*log.txt")
req1 <- requireDocker("quay.io/biocontainers/nudup:2.3.3--py_2")
nudup <- cwlProcess(baseCommand = "nudup.py",
                    requirements = list(req1),
                    inputs = InputParamList(p1, p2, p3, p4),
                    outputs = OutputParamList(o1, o2, o3))
