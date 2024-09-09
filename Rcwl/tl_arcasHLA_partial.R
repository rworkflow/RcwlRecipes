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



arcasHLA_partial <- addMeta(
    arcasHLA_partial,
    label = "arcasHLA_partial",
    doc = "arcasHLA_partial alignes reads to a reference containing partial alleles. Possible partial alleles are selected and compared with the complete genotype",
    inputLabels = c("fqs","gene","threads","genotype"),
    inputDocs = c("list of fastq files or '.partial.json' file","comma separated list of HLA genes ,default: all,options: A, B, C, DMA, DMB, DOA, DOB, DPA1, DPB1, DQA1,DQB1, DRA, DRB1, DRB3, DRB5, E, F, G, H, J, K, L","THREADS","genotype.json file from arcasHLA genotype"),
    outputLabels = c("pg","align"),
    outputDocs = c("partially typed genotype","Aligned reads to reference containing partial alleles"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/RabadanLab/arcasHLA",
        example = paste()
    )
)
