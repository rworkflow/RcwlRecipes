## GetPileupSummaries
p1 <- InputParam(id = "bam", type = "File", prefix = "-I", secondaryFiles = ".bai")
p2 <- InputParam(id = "vcf", type = "File", prefix = "-V",
                 secondaryFiles = "$(self.nameext == '.gz' ? self.basename+'.tbi' : self.basename+'.idx')")
p3 <- InputParam(id = "interval", type = "File", prefix = "-L",
                 secondaryFiles = "$(self.nameext == '.gz' ? self.basename+'.tbi' : self.basename+'.idx')")
p4 <- InputParam(id = "pileup", type = "string", prefix = "-O")
o1 <- OutputParam(id = "pout", type = "File", glob = "$(inputs.pileup)")
req1 <- list(class = "DockerRequirement",
             dockerPull = "broadinstitute/gatk:latest")
req2 <- requireJS()
GetPileupSummaries <- cwlProcess(baseCommand = c("gatk", "GetPileupSummaries"),
                                 requirements = list(req1, req2),
                                 inputs = InputParamList(p1, p2, p3, p4),
                                 outputs = OutputParamList(o1))


GetPileupSummaries <- addMeta(
    GetPileupSummaries,
    label = "GetPileupSummaries",
    doc = "Tabulates pileup metrics for inferring contamination",
    inputLabels = c("bam","vcf","interval","pileup"),
    inputDocs = c("BAM/SAM/CRAM file containing reads This argument must be specified at least once. Required.","A VCF file containing variants and allele frequencies Required.","One or more genomic intervals over which to operate This argument must be specified at least once. Required.","The output table Required."),
    outputLabels = c("pout"),
    outputDocs = c("Output table"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/broadinstitute/gatk",
        example = paste()
    )
)
