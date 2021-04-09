p1 <- InputParam(id = "exclude", type = "string?", prefix = "-e")
p2 <- InputParam(id = "format", type = "string?", prefix = "-f")
p3 <- InputParam(id = "header", type = "boolean?", prefix = "-H")
p4 <- InputParam(id = "include", type = "string?", prefix = "-i")
p5 <- InputParam(id = "listSample", type = "boolean?", prefix = "-l")
p6 <- InputParam(id = "region", type = "string?", prefix = "-r")
p7 <- InputParam(id = "regionFile", type = "File?", prefix = "-R")
p8 <- InputParam(id = "sample", type = "string?", prefix = "-s")
p9 <- InputParam(id = "sampleFile", type = "File?", prefix = "-S")
p10 <- InputParam(id = "target", type = "string?", prefix = "-t")
p11 <- InputParam(id = "targetFile", type = "File?", prefix = "-T")
p12 <- InputParam(id = "uTags", type = "boolean?", prefix = "-u")
p13 <- InputParam(id = "vcfList", type = "File?", prefix = "-v")
p14 <- InputParam(id = "vcf", type = "File?", position = 20L)
p15 <- InputParam(id = "out", type = "string", position = -1L)
o1 <- OutputParam(id = "qout", type = "File", glob = "$(inputs.out)")
req1 <- requireDocker("quay.io/biocontainers/bcftools:1.3.1--h5bf99c6_7")
bcftools_query <- cwlProcess(baseCommand = c("bcftools", "query"),
                             requirements = list(req1),
                             inputs = InputParamList(p1, p2, p3, p4, p5, p6, p7, p8,
                                                     p9, p10, p11, p12, p13, p14, p15),
                             outputs = OutputParamList(o1),
                             stdout = "$(inputs.out)")
