p1 <- InputParam(id = "fqs", type = "File[]", position = 1L)
p2 <- InputParam(id = "gene", type = "string", prefix = "-g",
                 default = "A,B,C,DPB1,DQB1,DQA1,DRB1")
p3 <- InputParam(id = "threads", type = "int", prefix = "-t")
p4 <- InputParam(id = "genotype", type = "File", prefix = "-G")
o1 <- OutputParam(id = "pg", type = "File", glob = "*.partial_genotype.json")
o2 <- OutputParam(id = "align", type = "File", glob = "*.partial_alignment.p")
req1 <- requireDocker("hubentu/arcas-hla")
arcasHLA_partial <- cwlProcess(baseCommand = c("arcasHLA", "partial"),
                               arguments = list("-o", ".", "-v"),
                               requirements = list(req1),
                               inputs = InputParamList(p1, p2, p3, p4),
                               outputs = OutputParamList(o1, o2))

