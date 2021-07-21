p1 <- InputParam(id = "ovcf", type = "string", prefix = "-o")
p2 <- InputParam(id = "vcf", type = "File",
                 secondaryFiles = ".tbi?")
p3 <- InputParam(id = "type", type = "string?", prefix = "-O")
p4 <- InputParam(id = "dup", type = "string?", prefix = "-d")
o1 <- OutputParam(id = "Fout", type = "File", glob = "$(inputs.ovcf)", secondaryFiles = ".tbi?")
req1 <- requireDocker("biocontainers/bcftools:v1.5_cv3")

bcftools_norm <- cwlProcess(cwlVersion = "v1.2",
                            baseCommand = c("bcftools", "norm"),
                            requirements = list(req1),
                            inputs = InputParamList(p1, p2, p3, p4),
                            outputs = OutputParamList(o1))
