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


arcasHLA_genotype <- addMeta(
    arcasHLA_genotype,
    label = "arcasHLA_genotype",
    doc = "arcasHLA genotype predicts the most likely genotype (no partial alleles), input the FASTQs produced by extract or the original FASTQs with all reads (experimental - use with caution).",
    inputLabels = c("fqs","gene","threads"),
    inputDocs = c("list of fastq files (e.g. sample.extracted.fq.gz) or alignment file (sample.alignment.p)","comma separated list of HLA genes ,default: all,options: A, B, C, DMA, DMB, DOA, DOB, DPA1, DPB1, DQA1,DQB1, DRA, DRB1, DRB3, DRB5, E, F, G, H, J, K, L","No. of threads"),
    outputLabels = c("genotype","align","gjs"),
    outputDocs = c("most likely genotype","pseudoalignment of the extracted reads with Kallisto","quantified allele abundances"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/RabadanLab/arcasHLA",
        example = paste()
    )
)
