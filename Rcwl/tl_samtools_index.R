## Index bam
p1 <- InputParam(id = "bam", type = "File", position = 1)
o1 <- OutputParam(id = "idx", type = "File", glob = "$(inputs.bam.basename)",
                  secondaryFiles = list(".bai"))
req2 <- list(class = "DockerRequirement",
             dockerPull = "quay.io/biocontainers/samtools:1.12--h9aed4be_1")
req3 <- list(class = "InitialWorkDirRequirement",
             listing = list("$(inputs.bam)"))
samtools_index <- cwlProcess(baseCommand = c("samtools", "index"),
                           requirements = list(req2, req3),
                           inputs = InputParamList(p1),
                           outputs = OutputParamList(o1))
