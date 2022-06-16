p1 <- InputParam(id = "normal", type = "File", prefix = "-n", secondaryFiles = ".bai")
p2 <- InputParam(id = "tumor", type = "File", prefix = "-t", secondaryFiles = ".bai")
p3 <- InputParam(id = "ref", type = "File", prefix = "--fasta", secondaryFiles = ".fai")
p4 <- InputParam(id = "gc", type = "File", prefix = "-gc")
p5 <- InputParam(id = "out", type = "string", prefix = "-o")
o1 <- OutputParam(id = "seqz", type = "File", glob = "$(inputs.out)")
r1 <- requireDocker("quay.io/biocontainers/sequenza-utils:3.0.0--py39h67e14b5_5")
bam2seqz <- cwlProcess(baseCommand = c("sequenza-utils", "bam2seqz"),
                       requirements = list(r1),
                       inputs = InputParamList(p1, p2, p3, p4, p5),
                       outputs = OutputParamList(o1))
