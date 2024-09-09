p1 <- InputParam(id = "bam", type = "File", prefix = "-b")
p2 <- InputParam(id = "gtf", type = "File", prefix = "-g")
p3 <- InputParam(id = "paired", type = "boolean?", prefix = "-p", default = TRUE)
p4 <- InputParam(id = "all", type = "boolean?", prefix = "-a", default = TRUE)
o1 <- OutputParam(id = "out", type = "File[]", glob = "*.out")
o2 <- OutputParam(id = "ent", type = "File[]?", glob = "*.ent")
o3 <- OutputParam(id = "uni", type = "File[]?", glob = "*.uni")
req1 <- requireDocker(searchContainer("tpmcalculator")$container[1])
TPMCalculator <- cwlProcess(baseCommand = "TPMCalculator",
                            requirements = list(req1),
                            inputs = InputParamList(p1, p2, p3, p4),
                            outputs = OutputParamList(o1, o2, o3))


TPMCalculator <- addMeta(
    TPMCalculator,
    label = "TPMCalculator",
    doc = "Quantifying gene expression levels from RNA sequencing (RNA-seq) data.",
    inputLabels = c("bam","gtf","paired","all"),
    inputDocs = c("Input bam file","GTF file","Use only properly paired reads. Default: No. Recommended for paired-end reads.","Print out all features with read counts equal to zero. Default: No."),
    outputLabels = c("out","ent","uni"),
    outputDocs = c("The main output file that contains the calculated TPM (Transcripts Per Million) and FPKM (Fragments Per Kilobase of transcript per Million mapped reads) values for each gene or transcript.","This file provides additional details or metadata about the genes or transcripts included in the analysis.","This file contains information about uniquely mapped reads to genes or transcripts."),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/ncbi/TPMCalculator",
        example = paste()
    )
)
