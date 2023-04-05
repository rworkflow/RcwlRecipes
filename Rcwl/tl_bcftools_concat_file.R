p1 <- InputParam(id = "ovcf", type = "string", prefix = "-o")
p2 <- InputParam(id = "gvcfs", type = "File[]", position = -1)
p3 <- InputParam(id = "type", type = "string?", prefix = "-O")
p4 <- InputParam(id = "overlap", type = "boolean?", prefix = "-a")
o1 <- OutputParam(id = "Fout", type = "File", glob = "$(inputs.ovcf)", secondaryFiles = ".tbi?")
req1 <- requireDocker("quay.io/biocontainers/bcftools:1.13--h3a49de5_0")
req2 <- requireManifest("gvcfs", sep = "\t")

bcftools_concat_file <- cwlProcess(cwlVersion = "v1.2",
                                   baseCommand = c("bcftools", "concat"),
                                   requirements = list(req1, req2),
                                   arguments = list("-f", "gvcfs"),
                                   inputs = InputParamList(p1, p2, p3, p4),
                                   outputs = OutputParamList(o1))
