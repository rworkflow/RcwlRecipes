p1 <- InputParam(id = "ovcf", type = "string", prefix = "-o")
p2 <- InputParam(id = "vcf", type = "File")
p3 <- InputParam(id = "type", type = "string?", prefix = "-O")
o1 <- OutputParam(id = "Fout", type = "File", glob = "$(inputs.ovcf)")
req1 <- requireDocker("biocontainers/bcftools:v1.5_cv3")

bcftools_sort <- cwlProcess(cwlVersion = "v1.0",
                            baseCommand = c("bcftools", "sort"),
                            requirements = list(req1),
                            inputs = InputParamList(p1, p2, p3),
                            outputs = OutputParamList(o1))
