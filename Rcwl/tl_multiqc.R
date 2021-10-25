## mutliqc
p1 <- InputParam(id = "dir", type = "Directory")
o1 <- OutputParam(id = "qc", type = "File", glob = "*.html")
o2 <- OutputParam(id = "qcDat", type = "Directory", glob = "multiqc_data")
req1 <- requireDocker("quay.io/biocontainers/multiqc:1.11--pyhdfd78af_0")

multiqc <- cwlProcess(baseCommand = "multiqc",
                    requirements = list(req1),
                    inputs = InputParamList(p1),
                    outputs = OutputParamList(o1, o2))
