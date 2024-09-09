## https://github.com/mskilab-org/fragCounter
p1 <- InputParam(id = "bam", type = "File", prefix = "-b", secondaryFiles = list(".bai?", "^.bai?"))
p2 <- InputParam(id = "gcmap", type = "Directory", prefix = "-d")
p3 <- InputParam(id = "window", type = "int", prefix = "-w")
p4 <- InputParam(id = "mapq", type = "int?", prefix = "-q")
p5 <- InputParam(id = "paired", type = "string", prefix = "-p", default="TRUE")
o1 <- OutputParam(id = "bw", type = "File", glob = "cov.corrected.bw")
o2 <- OutputParam(id = "rds", type = "File", glob = "cov.rds")
req1 <- requireDocker("hubentu/jabba:fix")
fragCounter <- cwlProcess(cwlVersion = "v1.2",
                          baseCommand = "frag",
                          requirements = list(req1),
                          inputs = InputParamList(p1, p2, p3, p4, p5),
                          outputs = OutputParamList(o1, o2))


fragCounter <- addMeta(
    fragCounter,
    label = "fragCounter",
    doc = "fragCounter corrects Whole genome or targeted sequencing data for GC and mappability bias.",
    inputLabels = c("bam","gcmap","window","mapq","paired"),
    inputDocs = c("Path to .bam file","Mappability / GC content dir","Window / bin size","Minimal map quality","Is paired"),
    outputLabels = c("bw","rds"),
    outputDocs = c("corrected bw file","output RDS file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/mskilab-org/fragCounter",
        example = paste()
    )
)
