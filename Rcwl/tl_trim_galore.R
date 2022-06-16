p1 <- InputParam(id = "fq1", type = "File", position = 9)
p2 <- InputParam(id = "fq2", type = "File?", position = 10)
p3 <- InputParam(id = "a1", type = "string", prefix = "-a", default = "AGATCGGAAGAGC")
p4 <- InputParam(id = "a2", type = "string?", prefix = "-a2", default = "AAATCAAAAAAAC")
p5 <- InputParam(id = "paired", type = "boolean", prefix = "--paired", default = TRUE)
o1 <- OutputParam(id = "FQ1", type = "File", glob = "*_1.fq.gz")
o2 <- OutputParam(id = "FQ2", type = "File", glob = "*_2.fq.gz")
o3 <- OutputParam(id = "report", type = "File[]", glob = "*.txt")
req1 <- requireDocker("quay.io/biocontainers/trim-galore:0.6.7--hdfd78af_0")
trim_galore <- cwlProcess(baseCommand = "trim_galore",
                          arguments = list("-o", "./"),
                          requirements = list(req1),
                          inputs = InputParamList(p1, p2, p3, p4, p5),
                          outputs = OutputParamList(o1, o2, o3))
