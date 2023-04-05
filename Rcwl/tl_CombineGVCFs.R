## CombineGVCFs
p1 <- InputParam(id = "vcfs",
                 type = InputArrayParam(items = "File", prefix = "--variant"),
                 secondaryFiles = ".tbi")
p2 <- InputParam(id = "Ref", type = "File", prefix = "-R",
                 secondaryFiles = c(".fai", "$(self.nameroot).dict"))
p3 <- InputParam(id = "ovcf", type = "string", prefix = "-O")
o1 <- OutputParam(id = "vcf", type = "File", glob = "$(inputs.ovcf)",
                  secondaryFiles = ".idx")
req1 <- list(class = "DockerRequirement",
             dockerPull = "broadinstitute/gatk:latest")
CombineGVCFs <- cwlProcess(baseCommand = c("gatk", "CombineGVCFs"),
                         requirements = list(req1),
                         inputs = InputParamList(p1, p2, p3),
                         outputs = OutputParamList(o1))
