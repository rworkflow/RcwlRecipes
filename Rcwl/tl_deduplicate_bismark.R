p1 <- InputParam(id = "bam", type = "File", position = 99)
p2 <- InputParam(id = "format", type = "boolean?", prefix = "--bam")
p3 <- InputParam(id = "paired", type = "boolean?", prefix = "--paired")
p4 <- InputParam(id = "outdir", type = "string?", prefix = "--output_dir")
o1 <- OutputParam(id = "dbam", type = "File", glob = "*.deduplicated.bam")
req1 <- requireDocker("quay.io/biocontainers/bismark:0.23.1--hdfd78af_0")
deduplicate_bismark <- cwlProcess(baseCommand = "deduplicate_bismark",
                                  requirements = list(req1),
                                  inputs = InputParamList(p1, p2, p3, p4),
                                  outputs = OutputParamList(o1))
