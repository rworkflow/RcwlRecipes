## https://pvactools.readthedocs.io/en/latest/pvacseq/getting_started.html#running-pvacseq-using-docker

p1 <- InputParam(id = "ivcf", type = "File", position = 1, secondaryFiles = ".tbi")
p2 <- InputParam(id = "sample", type = "string", position = 2)
p3 <- InputParam(id = "allele", type = "string[]",
                 itemSeparator = ",", position = 3)
p4 <- InputParam(id = "algorithms", type = "string[]", position = 4)
p5 <- InputParam(id = "outdir", type = "string", position = 5, default = "pvacseq_out")
p6 <- InputParam(id = "length", type = "string",
                 position = 6, prefix = "-e", default = "8,9,10,11")
p7 <- InputParam(id = "phasedVcf", type = "File?",
                 position = 7, prefix = "-p", secondaryFiles = ".tbi")
o1 <- OutputParam(id = "Out", type = "Directory", glob = "$(inputs.outdir)")

req1 <- list(class = "DockerRequirement",
             dockerPull = "griffithlab/pvactools")
pvacseq <- cwlProcess(baseCommand = c("pvacseq", "run"),
                    requirements = list(req1),
                    inputs = InputParamList(p1, p2, p3, p4, p5, p6, p7),
                    outputs = OutputParamList(o1))


pvacseq <- addMeta(
    pvacseq,
    label = "pvacseq",
    doc = "pVACseq is a cancer immunotherapy pipeline for the identification of personalized Variant Antigens by Cancer Sequencing (pVACseq) that integrates tumor mutation and expression data (DNA- and RNA-Seq).",
    inputLabels = c("ivcf","sample","allele","algorithms","outdir","length","phasedVcf"),
    inputDocs = c("VEP-annotated single- or multi-sample VCF containing genotype, transcript, Wildtype protein sequence, and Frameshift protein sequence information.The VCF may be gzipped (requires tabix index).","The name of the tumor sample being processed. When processing a multi-sample VCF the sample name must be a sample ID in the input VCF #CHROM header line.","Name of the allele to use for epitope prediction. Multiple alleles can be specified using a comma- separated list. For a list of available alleles, use:`pvacseq valid_alleles`.","algorith used","The directory for writing all result files.","Length of MHC Class I subpeptides (neoepitopes) to predict. Multiple epitope lengths can be specified using a comma-separated list. Typical epitope lengths vary between 8-15. Required for Class I prediction algorithms. (default: [8, 9, 10, 11])","A VCF with phased proximal variant information. Must be gzipped and tabix indexed. (default: None)"),
    outputLabels = c("Out"),
    outputDocs = c("output of predicted neoantigens"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://pvactools.readthedocs.io/en/latest/pvacseq/getting_started.html#running-pvacseq-using-docker",
        example = paste()
    )
)
