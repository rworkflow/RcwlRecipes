## cnv_facets
p1 <- InputParam(id = "tbam", type = "File?", prefix = "-t", secondaryFiles = list(".bai?", "^.bai?"))
p2 <- InputParam(id = "nbam", type = "File?", prefix = "-n", secondaryFiles = list(".bai?", "^.bai?"))
p3 <- InputParam(id = "vcf", type = "File?", prefix = "-vcf", secondaryFiles = ".tbi")
p4 <- InputParam(id = "pileup", type = "File?", prefix = "-p")
p5 <- InputParam(id = "out", type = "string", prefix = "-o")
p6 <- InputParam(id = "build", type = "string?", prefix = "-g")
p7 <- InputParam(id = "targets", type = "File?", prefix = "-T")
p8 <- InputParam(id = "cval", type = "int[]?", prefix = "-cv")
p9 <- InputParam(id = "nprocs", type = "int?", prefix = "-N")
o1 <- OutputParam(id = "Out", type = "File[]", glob = "$(inputs.out)*")
req1 <- list(class = "DockerRequirement",
             dockerPull = "hubentu/facets:0.6.2")
cnv_facets <- cwlProcess(cwlVersion = "v1.2",
                         baseCommand = "cnv_facets.R",
                         requirements = list(req1),
                         inputs = InputParamList(p1, p2, p3, p4, p5, p6, p7, p8, p9),
                         outputs = OutputParamList(o1))
