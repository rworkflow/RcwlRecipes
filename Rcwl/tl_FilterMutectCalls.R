## Filter Variants
p1 <- InputParam(id = "vcf", type = "File", prefix = "-V",
                 secondaryFiles = c(".idx", ".stats"))
p2 <- InputParam(id = "cont", type = "File", prefix = "--contamination-table")
p3 <- InputParam(id = "seg", type = "File", prefix = "--tumor-segmentation")
p4 <- InputParam(id = "lro", type = "File", prefix = "--ob-priors")
p5 <- InputParam(id = "fvcf", type = "string", prefix = "-O")
p6 <- InputParam(id = "ref", prefix = "-R", type = "File",
                 secondaryFiles = c(".fai", "$(self.nameroot).dict"))
o1 <- OutputParam(id = "fout", type = "File", glob = "$(inputs.fvcf)")
req1 <- list(class = "DockerRequirement",
             dockerPull = "broadinstitute/gatk:latest")

FilterMutectCalls <- cwlParam(baseCommand = c("gatk", "FilterMutectCalls"),
                              requirements = list(req1),
                              inputs = InputParamList(p1, p2, p3, p4, p5, p6),
                              outputs = OutputParamList(o1))
