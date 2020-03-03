
p1 <- InputParam(id = "readFilesIn", type = "File[]", prefix = "--readFilesIn")
p2 <- InputParam(id = "genomeDir", type = "Directory", prefix = "--genomeDir")
p3 <- InputParam(id = "whiteList", type = "File", prefix = "--soloCBwhitelist")
p4 <- InputParam(id = "soloType", type = "string", prefix = "--soloType",
                 default = "CB_UMI_Simple")
p5 <- InputParam(id = "soloUMIlen", type = "string", prefix = "--soloUMIlen",
                 default = "12")
p6 <- InputParam(id = "runThreadN", type = "int", prefix = "--runThreadN", default = 1L)
p7 <- InputParam(id = "sOut", type = "string", prefix = "--soloOutFileNames",
                 default = "Solo_out")
o1 <- OutputParam(id = "outBam", type = "File", glob = "*.bam")
o2 <- OutputParam(id = "outLog", type = "File[]", glob = "*.out")
o3 <- OutputParam(id = "SJ", type = "File", glob = "*out.tab")
o4 <- OutputParam(id = "Solo", type = "Directory", glob = "$(inputs.sOut)Gene")

req1 <- list(class = "DockerRequirement",
             dockerPull = "quay.io/biocontainers/star:2.7.3a--0")
STARsolo <- cwlParam(baseCommand = "STAR",
                     requirements = list(req1),
                     arguments = list("--outSAMunmapped", "Within",
                                      "--readFilesCommand", "zcat",
                                      "--outSAMtype", "BAM", "SortedByCoordinate"),
                     inputs = InputParamList(p1, p2, p3, p4, p5, p6, p7),
                     outputs = OutputParamList(o1, o2, o3, o4))
