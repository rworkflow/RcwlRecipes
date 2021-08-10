p1 <- InputParam(id = "ovcf", type = "string", prefix = "-o")
p2 <- InputParam(id = "vcf", type = "File",
                 secondaryFiles = ".tbi?")
p3 <- InputParam(id = "type", type = "string?", prefix = "-O")
p4 <- InputParam(id = "dup", type = "string?", prefix = "-d")
o1 <- OutputParam(id = "Fout", type = "File", glob = "$(inputs.ovcf)", secondaryFiles = ".tbi?")
req1 <- requireDocker("quay.io/biocontainers/bcftools:1.13--h3a49de5_0")

bcftools_norm <- cwlProcess(cwlVersion = "v1.2",
                            baseCommand = c("bcftools", "norm"),
                            requirements = list(req1),
                            inputs = InputParamList(p1, p2, p3, p4),
                            outputs = OutputParamList(o1))
