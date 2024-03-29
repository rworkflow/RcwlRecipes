## bam flagstat
p1 <- InputParam(id = "bam", type = "File")
o1 <- OutputParam(id = "flagstat", type = "File", glob = "$(inputs.bam.nameroot).flagstat.txt")
req2 <- list(class = "DockerRequirement",
             dockerPull = "quay.io/biocontainers/samtools:1.15--h1170115_1")
samtools_flagstat <- cwlProcess(baseCommand = c("samtools", "flagstat"),
                              requirements = list(req2),
                              inputs = InputParamList(p1),
                              outputs = OutputParamList(o1),
                              stdout = "$(inputs.bam.nameroot).flagstat.txt")
