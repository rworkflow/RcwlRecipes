## HaplotypeCaller
p1 <- InputParam(id = "bam", type = "File", prefix = "-I",
                 secondaryFiles = ".bai")
p2 <- InputParam(id = "interval", type = "File", prefix = "-L")
p3 <- InputParam(id = "ref", type = "File", prefix = "-R",
                 secondaryFiles = c(".fai", "$(self.nameroot).dict"))
p4 <- InputParam(id = "gout", type = "string", prefix = "-O")
p5 <- InputParam(id = "emit", type = "string", prefix = "-ERC", default = "GVCF")
p6 <- InputParam(id = "downsampling", type = "int", prefix = "--max-reads-per-alignment-start",
                 default = 50L)
o1 <- OutputParam(id = "gvcf", type = "File", glob = "$(inputs.gout)",
                  secondaryFiles = ".idx")
req1 <- list(class = "DockerRequirement",
             dockerPull = "broadinstitute/gatk:latest")
HaplotypeCaller <- cwlProcess(baseCommand = c("gatk", "HaplotypeCaller"),
                            requirements = list(req1),
                            inputs = InputParamList(p1, p2, p3, p4, p5, p6),
                            outputs = OutputParamList(o1))
