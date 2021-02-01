
p1 <- InputParam(id = "bam", type = "File")
o1 <- OutputParam(id = "pileup", type = "File", glob = "$(inputs.bam.nameroot).depth.txt")
req1 <- list(class = "DockerRequirement",
             dockerPull = "biocontainers/samtools:v1.7.0_cv3")
samtools_depth <- cwlProcess(baseCommand = c("samtools", "depth"),
                             requirements = list(req1),
                             inputs = InputParamList(p1),
                             outputs = OutputParamList(o1),
                             stdout = "$(inputs.bam.nameroot).depth.txt")
