## STAR
## Note: output to current dir
p1 <- InputParam(id = "prefix", type = "string", prefix = "--outFileNamePrefix")
p2 <- InputParam(id = "readFilesIn", type = "File[]", prefix = "--readFilesIn")
p3 <- InputParam(id = "genomeDir", type = "Directory", prefix = "--genomeDir")
p4 <- InputParam(id = "sjdbGTFfile", type = "File", prefix = "--sjdbGTFfile")
p5 <- InputParam(id = "runThreadN", type = "int", prefix = "--runThreadN", default = 1L)
p6 <- InputParam(id = "readFilesCommand", type = "string?", prefix = "--readFilesCommand")
p7 <- InputParam(id = "twopass", type = "string?", prefix = "--twopassMode")
p8 <- InputParam(id = "chimSegmentMin", type = "int?", prefix = "--chimSegmentMin")
p9 <- InputParam(id = "outFilterMismatchNmax", type = "int?", prefix = "--outFilterMismatchNmax")
p10 <- InputParam(id = "alignIntronMax", type = "int?", prefix = "--alignIntronMax")
p11 <- InputParam(id = "alignSJDBoverhangMin", type = "int?", prefix = "--alignSJDBoverhangMin")
o1 <- OutputParam(id = "outBAM", type = "File", glob = "*.bam")
o2 <- OutputParam(id = "outLog", type = "File", glob = "*Log.final.out")
o3 <- OutputParam(id = "outCount", type = "File", glob = "*ReadsPerGene.out.tab")

req1 <- list(class = "DockerRequirement",
             dockerPull = "quay.io/biocontainers/star:2.7.9a--h9ee0642_0")
STAR <- cwlProcess(baseCommand = "STAR",
                 requirements = list(req1),
                 arguments = list("--outSAMunmapped", "Within",
                                  "--outSAMstrandField", "intronMotif",
                                  "--outSAMtype", "BAM", "SortedByCoordinate",
                                  "--quantMode", "GeneCounts"),
                 inputs = InputParamList(p1, p2, p3, p4, p5,
                                         p6, p7, p8, p9, p10, p11),
                 outputs = OutputParamList(o1, o2, o3))
