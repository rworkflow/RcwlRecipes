p1 <- InputParam(id = "ovcf", type = "string", prefix = "-o")
p2 <- InputParam(id = "vcf", type = "File", secondaryFiles = ".tbi?")
p3 <- InputParam(id = "type", type = "string?", prefix = "-O")
o1 <- OutputParam(id = "Fout", type = "File", glob = "$(inputs.ovcf)", secondaryFiles = ".tbi?")
req1 <- requireDocker("quay.io/biocontainers/bcftools:1.13--h3a49de5_0")

bcftools_sort <- cwlProcess(cwlVersion = "v1.2",
                            baseCommand = c("bcftools", "sort"),
                            requirements = list(req1),
                            inputs = InputParamList(p1, p2, p3),
                            outputs = OutputParamList(o1))
