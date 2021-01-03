p1 <- InputParam(id = "ovcf", type = "string", prefix = "-o")
p2 <- InputParam(id = "vcfs", type = "File[]", secondaryFiles = ".tbi")
p3 <- InputParam(id = "type", type = "string", prefix = "-O", default = "z")
o1 <- OutputParam(id = "Fout", type = "File", glob = "$(inputs.ovcf)")
req1 <- requireDocker("biocontainers/bcftools:v1.5_cv3")

bcftools_concat <- cwlParam(baseCommand = c("bcftools", "concat"),
                            requirements = list(req1),
                            arguments = list("-a"),
                            inputs = InputParamList(p1, p2),
                            outputs = OutputParamList(o1))
