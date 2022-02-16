## STAR
## from NUC
## readFilesIn must be full path ##string
p1 <- InputParam(id = "prefix", type = "string", prefix = "--outFileNamePrefix")
p2 <- InputParam(id = "readFilesIn", type = "File[]", prefix = "--readFilesIn")
p3 <- InputParam(id = "genomeDir", type = "Directory", prefix = "--genomeDir")
p4 <- InputParam(id = "sjdbGTFfile", type = "File", prefix = "--sjdbGTFfile")
p5 <- InputParam(id = "runThreadN", type = "int", prefix = "--runThreadN", default = 1L)
o1 <- OutputParam(id = "outBAM", type = "File", glob = "*Aligned.out.bam")
o2 <- OutputParam(id = "outLog", type = "File", glob = "*Log.final.out")
o3 <- OutputParam(id = "outCount", type = "File", glob = "*ReadsPerGene.out.tab")
o4 <- OutputParam(id = "junction", type = "File", glob = "*Chimeric.out.junction")
req1 <- list(class = "DockerRequirement",
             dockerPull = "quay.io/biocontainers/star:2.7.9a--h9ee0642_0")
STAR_FFPE <- cwlProcess(baseCommand = "STAR",
                        requirements = list(req1),
                        arguments = list("--outSAMattrRGline", "-",
                                         "--alignIntronMax", "1000000",
                                         "--alignIntronMin", "20",
                                         "--alignMatesGapMax", "1000000",
                                         "--alignSJDBoverhangMin", "1",
                                         "--alignSJoverhangMin", "8",
                                         "--alignSoftClipAtReferenceEnds", "Yes",
                                         "--chimJunctionOverhangMin", "15",
                                         "--chimMainSegmentMultNmax", "1",
                                         "--chimOutType", "Junctions", "WithinBAM", "SoftClip",
                                         "--chimSegmentMin", "15",
                                         "--genomeLoad", "NoSharedMemory",
                                         "--limitSjdbInsertNsj", "1200000",
                                         "--outFilterIntronMotifs", "None",
                                         "--outFilterMatchNminOverLread", "0.33",
                                         "--outFilterMismatchNmax", "999",
                                         "--outFilterMismatchNoverLmax", "0.1",
                                         "--outFilterMultimapNmax", "20",
                                         "--outFilterScoreMinOverLread", "0.33",
                                         "--outFilterType", "BySJout",
                                         "--outSAMattributes", "NH", "HI", "AS", "nM", "NM", "ch",
                                         "--outSAMstrandField", "intronMotif",
                                         "--outSAMtype", "BAM", "Unsorted",
                                         "--outSAMunmapped", "Within",
                                         "--quantMode", "GeneCounts",
                                         "--readFilesCommand", "zcat",
                                         "--twopassMode", "Basic"),
                        inputs = InputParamList(p1, p2, p3, p4, p5),
                        outputs = OutputParamList(o1, o2, o3, o4))
