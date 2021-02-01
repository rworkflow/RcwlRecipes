# https://github.com/Xinglab/rmats-turbo
p1 <- InputParam(id = "fq1", type = "string", position = -1)
p2 <- InputParam(id = "fq2", type = "string", position = -1)
p3 <- InputParam(id = "type", type = "string", prefix = "-t", default = "paired")
p4 <- InputParam(id = "readLength", type = "int", prefix = "--readLength")
p5 <- InputParam(id = "gtf", type = "File", prefix = "--gtf")
p6 <- InputParam(id = "threads", type = "int?", prefix = "--nthread", default = 1L)
p7 <- InputParam(id = "tstat", type = "int?", prefix = "--tstat")
p8 <- InputParam(id = "tmp", type = "string", prefix = "--tmp", default = "tmp")
p9 <- InputParam(id = "bindex", type = "Directory", prefix = "--bi")
o1 <- OutputParam(id = "res", type = "File[]", glob = "*.txt")
req1 <- requireDocker("xinglab/rmats")
req2 <- requireJS()
req3 <- requireManifest("fq1", sep = ",")
req4 <- requireManifest("fq2", sep = ",")
req5 <- requireInitialWorkDir(listing = list(req3$listing[[1]],
                                             req4$listing[[1]]))
rMATS_fq <- cwlProcess(baseCommand = "",
                     requirements = list(req1, req2, req5),
                     arguments = list("--s1", "fq1", "--s2", "fq2", "--od", "."),
                     inputs = InputParamList(p1, p2, p3, p4, p5, p6, p7, p8, p9),
                     outputs = OutputParamList(o1))
