## featureCounts
## Note: output to current directory
f1 <- InputParam(id = "gtf", type = "File", prefix = "-a")
f2 <- InputParam(id = "count", type = "string", prefix = "-o")
f3 <- InputParam(id = "bam", type = "File")
o1 <- OutputParam(id = "Count", type = "File", glob = "$(inputs.count)", secondaryFiles = ".summary")

req1 <- requireDocker("quay.io/biocontainers/subread:2.0.6--he4a0461_0")
featureCounts <- cwlProcess(baseCommand = "featureCounts",
                            arguments = list("-p", "--countReadPairs"),
                            requirements = list(req1),
                            inputs = InputParamList(f1, f2, f3),
                            outputs = OutputParamList(o1))

