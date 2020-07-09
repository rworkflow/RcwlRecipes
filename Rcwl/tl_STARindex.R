p1 <- InputParam(id = "genomeDir", type = "string", prefix = "--genomeDir",
                 default = "STARindex")
p2 <- InputParam(id = "genomeFastaFiles", type = "File", prefix = "--genomeFastaFiles")
p3 <- InputParam(id = "sjdbGTFfile", type = "File", prefix = "--sjdbGTFfile")
p4 <- InputParam(id = "runThreadN", type = "int", prefix = "--runThreadN", default = 4L)

o1 <- OutputParam(id = "outIndex", type = "Directory", glob = "$(inputs.genomeDir)")

STARindex <- cwlParam(baseCommand = "STAR",
                      requirements = list(requireDocker("quay.io/biocontainers/star:2.7.5a--0")),
                      arguments = list("--runMode", "genomeGenerate"),
                      inputs = InputParamList(p1, p2, p3, p4),
                      outputs = OutputParamList(o1))
