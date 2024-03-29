p1 <- InputParam(id = "ovcf", type = "string", prefix = "-o")
p2 <- InputParam(id = "vcfs", type = "File[]?", secondaryFiles = "tbi?")
p3 <- InputParam(id = "type", type = "string?", prefix = "-O")
p4 <- InputParam(id = "overlap", type = "boolean?", prefix = "-a")
p5 <- InputParam(id = "vfile", type = "File?", prefix = "-f")
o1 <- OutputParam(id = "Fout", type = "File", glob = "$(inputs.ovcf)", secondaryFiles = ".tbi?")
req1 <- requireDocker("quay.io/biocontainers/bcftools:1.13--h3a49de5_0")

bcftools_concat <- cwlProcess(cwlVersion = "v1.2",
                              baseCommand = c("bcftools", "concat"),
                              requirements = list(req1),
                              inputs = InputParamList(p1, p2, p3, p4, p5),
                              outputs = OutputParamList(o1))
