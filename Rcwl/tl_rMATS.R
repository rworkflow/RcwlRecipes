# https://github.com/Xinglab/rmats-turbo
p1 <- InputParam(id = "bam1", type = "File[]", position = -1)
p2 <- InputParam(id = "bam2", type = "File[]", position = -1)
p3 <- InputParam(id = "type", type = "string", prefix = "-t", default = "paired")
p4 <- InputParam(id = "readLength", type = "int", prefix = "--readLength")
p5 <- InputParam(id = "gtf", type = "File", prefix = "--gtf")
p6 <- InputParam(id = "threads", type = "int?", prefix = "--nthread", default = 1L)
p7 <- InputParam(id = "tstat", type = "int?", prefix = "--tstat")
p8 <- InputParam(id = "tmp", type = "string", prefix = "--tmp", default = "tmp")
p9 <- InputParam(id = "libType", type = "string?", prefix = "--libType")
p10 <- InputParam(id = "varReadLength", type = "boolean?", prefix = "--variable-read-length")
p11 <- InputParam(id = "anchorLength", type = "int?", prefix = "--anchorLength")
p12 <- InputParam(id = "tophatAnchor", type = "int?", prefix = "--tophatAnchor")
p13 <- InputParam(id = "cstat", type = "float?", prefix = "--cstat")
p14 <- InputParam(id = "task", type = "string?", prefix = "--task")
p15 <- InputParam(id = "statoff", type = "boolean?", prefix = "--statoff")
p16 <- InputParam(id = "pairedStats", type = "boolean?", prefix = "--paired-stats")
p17 <- InputParam(id = "novelSS", type = "boolean?", prefix = "--novelSS")
p18 <- InputParam(id = "mil", type = "int?", prefix = "--mil")
p19 <- InputParam(id = "mel", type = "int?", prefix = "--mel")
p20 <- InputParam(id = "allowClipping", type = "boolean?", prefix = "--allow-clipping")
p21 <- InputParam(id = "fixedEvent", type = "Directory?", prefix = "--fixed-event-set")

o1 <- OutputParam(id = "res", type = "File[]", glob = "*.txt")
o2 <- OutputParam(id = "tmp", type = "Directory", glob = "$(inputs.tmp)")
req1 <- requireDocker("xinglab/rmats")
req2 <- requireJS()
req3 <- requireManifest("bam1", sep = ",")
req4 <- requireManifest("bam2", sep = ",")
req5 <- requireInitialWorkDir(listing = list(req3$listing[[1]],
                                             req4$listing[[1]]))
rMATS_bam <- cwlProcess(baseCommand = "",
                      requirements = list(req1, req2, req5),
                      arguments = list("--b1", "bam1", "--b2", "bam2", "--od", "."),
                      inputs = InputParamList(p1, p2, p3, p4, p5, p6, p7, p8, p9,
                                              p10, p11, p12, p13, p14, p15, p16,
                                              p17, p18, p19, p20, p21),
                      outputs = OutputParamList(o1, o2))
