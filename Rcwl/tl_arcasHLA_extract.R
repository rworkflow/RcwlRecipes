p1 <- InputParam(id = "bam", type = "File", position = 1L, secondaryFiles = ".bai")
p2 <- InputParam(id = "threads", type = "int", prefix = "-t", default=4L)
o1 <- OutputParam(id = "fqs", type = "File[]", glob = "*.fq.gz")
req1 <- requireDocker("hubentu/arcas-hla")
arcasHLA_extract <- cwlProcess(baseCommand = c("arcasHLA", "extract"),
                               arguments = list("-o", ".", "-v"),
                               requirements = list(req1),
                               inputs = InputParamList(p1, p2),
                               outputs = OutputParamList(o1))
