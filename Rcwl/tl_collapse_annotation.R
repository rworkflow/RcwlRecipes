## https://github.com/broadinstitute/gtex-pipeline/tree/master/gene_model
p1 <- InputParam(id = "gtf", type = "File", position = 1)
p2 <- InputParam(id = "out", type = "string", position = 2)
p3 <- InputParam(id = "blacklist", type = "File?", prefix = "--transcript_blacklist")
o1 <- OutputParam(id = "gtfout", type = "File", glob="$(inputs.out)")
req1 <- requireDocker("hubentu/collapse_annotation")
collapse_annotation <- cwlProcess(baseCommand = c("python",
                                                  "/opt/collapse_annotation.py"),
                                  requirements = list(req1),
                                  inputs = InputParamList(p1, p2, p3),
                                  outputs = OutputParamList(o1))
