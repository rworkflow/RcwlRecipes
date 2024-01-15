p1 <- InputParam(id = "fqs", type = "File[]", position = 1L)
p2 <- InputParam(id = "gene", type = "string", prefix = "-g",
                 default = "A,B,C,DPB1,DQB1,DQA1,DRB1")
p3 <- InputParam(id = "threads", type = "int", prefix = "-t")
o1 <- OutputParam(id = "genotype", type = "File", glob = "*.genotype.json")
o2 <- OutputParam(id = "align", type = "File", glob = "*.alignment.p")
o3 <- OutputParam(id = "gjs", type = "File", glob = "*.genes.json")
req1 <- requireDocker("hubentu/arcas-hla")
arcasHLA_genotype <- cwlProcess(baseCommand = c("arcasHLA", "genotype"),
                                arguments = list("-o", ".", "-v"),
                                requirements = list(req1),
                                inputs = InputParamList(p1, p2, p3),
                                outputs = OutputParamList(o1, o2, o3))
