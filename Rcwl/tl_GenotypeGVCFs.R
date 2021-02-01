## GenotypeGVCFs
p1 <- InputParam(id = "variant", type = "File", prefix = "-V",
                 secondaryFiles = ".idx")
p2 <- InputParam(id = "ref", type = "File", prefix = "-R",
                 secondaryFiles = c(".fai", "$(self.nameroot).dict"))
p3 <- InputParam(id = "vout", type = "string", prefix = "-O")
o1 <- OutputParam(id = "vcf", type = "File", glob = "$(inputs.vout)",
                  secondaryFiles = ".idx")
req1 <- list(class = "DockerRequirement",
             dockerPull = "broadinstitute/gatk:latest")
GenotypeGVCFs <- cwlProcess(baseCommand = c("gatk", "GenotypeGVCFs"),
                          requirements = list(req1),
                          inputs = InputParamList(p1, p2, p3),
                          outputs = OutputParamList(o1))
