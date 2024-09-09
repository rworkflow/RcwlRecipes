## RSeQC bam_stat
p1 <- InputParam(id = "bam", type = "File", prefix = "-i")
o1 <- OutputParam(id = "statOut", type = "File", glob = "$(inputs.bam.nameroot).bamStat.txt")

req1 <- requireDocker("quay.io/biocontainers/rseqc:4.0.0--py38h4a8c8d9_1")
read_distribution <- cwlProcess(baseCommand = c("bam_stat.py"),
                              requirements = list(req1),
                              inputs = InputParamList(p1),
                              outputs = OutputParamList(o1),
                              stdout = "$(inputs.bam.nameroot).bamStat.txt")
