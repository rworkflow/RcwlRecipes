## Ref: https://github.com/alexdobin/STAR/blob/master/docs/STARsolo.md

p1 <- InputParam(id = "readFilesIn_cdna", type = "File[]", prefix = "--readFilesIn",
                 position = 1, itemSeparator = ",")
p2 <- InputParam(id = "readFilesIn_cb", type = "File[]", position = 2, itemSeparator = ",")
p3 <- InputParam(id = "genomeDir", type = "Directory", prefix = "--genomeDir")
p4 <- InputParam(id = "whiteList", type = "File", prefix = "--soloCBwhitelist")
p5 <- InputParam(id = "soloType", type = "string", prefix = "--soloType",
                 default = "CB_UMI_Simple")
p6 <- InputParam(id = "soloUMIlen", type = "string", prefix = "--soloUMIlen",
                 default = "12")
p7 <- InputParam(id = "runThreadN", type = "int", prefix = "--runThreadN", default = 1L)

o1 <- OutputParam(id = "outBam", type = "File", glob = "*.bam")
o2 <- OutputParam(id = "outLog", type = "File[]", glob = "Log*")
o3 <- OutputParam(id = "SJ", type = "File", glob = "SJ.out.tab")
o4 <- OutputParam(id = "Solo", type = "Directory", glob = "Solo.out")

STARsolo <- cwlParam(baseCommand = "STAR",
                     requirements = list(requireDocker("quay.io/biocontainers/star:2.7.5a--0")),
                     arguments = list("--outSAMunmapped", "Within",
                                      "--readFilesCommand", "zcat",
                                      "--outSAMtype", "BAM", "SortedByCoordinate",
                                      "--soloUMIfiltering", "MultiGeneUMI",
                                      "--soloCBmatchWLtype", "1MM_multi_pseudocounts"),
                     inputs = InputParamList(p1, p2, p3, p4, p5, p6, p7),
                     outputs = OutputParamList(o1, o2, o3, o4))

