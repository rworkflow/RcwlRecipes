p1 <- InputParam(id = "fai", type = "File?", prefix = "-f")
p2 <- InputParam(id = "header", type = "File?", prefix = "-h")
p3 <- InputParam(id = "samples", type = "File?", prefix = "-s")
p4 <- InputParam(id = "vcf", type = "File")
p5 <- InputParam(id = "output", type = "string", prefix = "-o")
o1 <- OutputParam(id = "outvcf", type = "File", glob = "$(inputs.output)")
req1 <- requireDocker("quay.io/biocontainers/bcftools:1.13--h3a49de5_0")
bcftools_reheader <- cwlProcess(baseCommand = c("bcftools", "reheader"),
                                requirements = list(req1),
                                inputs = InputParamList(p1, p2, p3, p4, p5),
                                outputs = OutputParamList(o1))
