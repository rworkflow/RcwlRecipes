## BaseRecalibrator
p1 <- InputParam(id = "bam", type = "File", prefix = "-I")
p2 <- InputParam(id = "ref", prefix = "-R", type = "File", secondaryFiles = c(
                                                               ".fai",
                                                               "$(self.nameroot).dict"))
p3 <- InputParam(id = "knowSites", type = InputArrayParam(items = "File",
                                                          prefix = "--known-sites"),
                 secondaryFiles = "$(self.nameext == '.gz' ? self.basename+'.tbi' : self.basename+'.idx')")
p4 <- InputParam(id = "recal", type = "string", prefix = "-O")
o1 <- OutputParam(id = "rtable", type = "File",
                  glob = "$(inputs.recal)")
req1 <- list(class = "DockerRequirement",
             dockerPull = "broadinstitute/gatk:latest")
req2 <- requireJS()
BaseRecalibrator <- cwlProcess(cwlVersion = "v1.0",
                               baseCommand = c("gatk", "BaseRecalibrator"),
                               requirements = list(req1, req2),
                               inputs = InputParamList(p1, p2, p3, p4),
                               outputs = OutputParamList(o1))
