## https://cnvkit.readthedocs.io/en/stable/

p1 <- InputParam(id = "tbams", type = "File[]?", secondaryFiles = ".bai")
p2 <- InputParam(id = "ref", type = "File?", prefix = "--fasta",
                 secondaryFiles = ".fai")
p3 <- InputParam(id = "outdir", type = "string", prefix = "--output-dir")
p4 <- InputParam(id = "normal", type = "File[]?", prefix = "--normal",
                 secondaryFiles = ".bai")
p5a <- InputParam(id = "outref", type = "string?", prefix = "--output-reference")
p5b <- InputParam(id = "reference", type = "File?", prefix = "-r")
p6 <- InputParam(id = "target", type = "File?", prefix = "--targets")
p7 <- InputParam(id = "anti", type = "File?", prefix = "--antitargets")
p8 <- InputParam(id = "access", type = "File?", prefix = "--access")
p9 <- InputParam(id = "annotate", type = "File?", prefix = "--annotate")
p10 <- InputParam(id = "parallel", type = "int",
                 prefix = "-p", default = 1)
p11 <- InputParam(id = "diagram", type = "boolean", prefix = "--diagram",
                  default = TRUE)
p12 <- InputParam(id = "scatter", type = "boolean", prefix = "--scatter",
                  default = TRUE)
p13 <- InputParam(id = "method", type = "string?", prefix = "-m")
o1 <- OutputParam(id = "Outdir", type = "Directory", glob = "$(inputs.outdir)")
o2 <- OutputParam(id = "outRef", type = "File?", glob = "$(inputs.outref)")
req1 <- list(class = "DockerRequirement",
             dockerPull = "etal/cnvkit")
cnvkit_batch <- cwlProcess(baseCommand = c("cnvkit.py", "batch"),
                         requirements = list(req1),
                         inputs = InputParamList(p1, p2, p3, p4, p5a, p5b, p6, p7, p8, p9, p10, p11, p12, p13),
                         outputs = OutputParamList(o1, o2))



cnvkit_batch <- addMeta(
    cnvkit_batch,
    label = "cnvkit_batch",
    doc = "CNVkit Batch is a powerful command that automates the process of detecting copy number variations in a batch of sequencing data.",
    inputLabels = c("tbams","ref","outdir","normal","outref","reference","target","anti","access","annotate","parallel","diagram","scatter","method"),
    inputDocs = c("Tumor Mapped sequence reads (.bam)","Reference genome, FASTA format (e.g. UCSC hg19.fa)","Output directory.","Normal samples (.bam) used to construct the pooled,paired, or flat reference. If this option is used but no filenames are given, a 'flat' reference will be built. Otherwise, all filenames following this option will be used.","Output filename/path for the new reference file being created. (If given, ignores the -o/--output-dir option and will write the file to the given path. Otherwise, 'reference.cnn' will be created in the current directory or specified output directory.)","Copy number reference file (.cnn).","Target intervals (.bed or .list)","Antitarget intervals (.bed or .list)","Regions of accessible sequence on chromosomes (.bed), as output by the 'access' command.","Use gene models from this file to assign names to the target regions. Format: UCSC refFlat.txt or ensFlat.txt file (preferred), or BED, interval list, GFF, or similar.","Number of subprocesses used to running each of the BAM files in parallel. Without an argument, use the maximum number of available CPUs. [Default: process each BAM in serial]","Create an ideogram of copy ratios on chromosomes as a PDF.","Create a whole-genome copy ratio profile as a PDF scatter plot.","Sequencing assay type: hybridization capture ('hybrid'), targeted amplicon sequencing ('amplicon'), or whole genome sequencing ('wgs'). Determines whether and how to use antitarget bins. [Default: hybrid]"),
    outputLabels = c("Outdir","outRef"),
    outputDocs = c("Directory where all output files will be stored","Output of new reference file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://cnvkit.readthedocs.io/en/stable/",
        example = paste()
    )
)
