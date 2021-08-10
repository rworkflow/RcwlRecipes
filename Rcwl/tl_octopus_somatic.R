# https://github.com/luntergroup/octopus
p1 <- InputParam(id = "bams", type = "File[]", prefix = "-I", secondaryFiles = list(".bai?", "^.bai?"))
p2 <- InputParam(id = "ref", type = "File", prefix = "-R", secondaryFiles = ".fai")
p3 <- InputParam(id = "normal", type = "string", prefix = "-N")
p4 <- InputParam(id = "ovcf", type = "string", prefix = "-o")
p5 <- InputParam(id = "region", type = "File?", prefix = "-t")
p6 <- InputParam(id = "error", type = "string?", prefix = "--sequence-error-model")
p7 <- InputParam(id = "threads", type = "int?", prefix = "--threads")
p8 <- InputParam(id = "expFreq", type = "float?", prefix = "--min-expected-somatic-frequency")
p9 <- InputParam(id = "creFreq", type = "float?", prefix = "--min-credible-somatic-frequency")
p10 <- InputParam(id = "annotation", type = "string[]?", prefix = "--annotations")
o1 <- OutputParam(id = "oVcf", type = "File", glob = "$(inputs.ovcf)")
req1 <- requireDocker("dancooke/octopus")
octopus_somatic <- cwlProcess(cwlVersion = "v1.2",
                              baseCommand = "octopus",
                              requirements = list(req1),
                              arguments = list("--forest",
                                               "/opt/octopus/resources/forests/germline.v0.7.4.forest",
                                               "--somatic-forest",
                                               "/opt/octopus/resources/forests/somatic.v0.7.4.forest"),
                              inputs = InputParamList(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10),
                              outputs = OutputParamList(o1))
