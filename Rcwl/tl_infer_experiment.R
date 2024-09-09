p1 <- InputParam(id = "bed", type = "File", prefix = "-r")
p2 <- InputParam(id = "bam", type = "File", prefix = "-i", secondaryFiles = ".bai")
p3 <- InputParam(id = "size", type = "int?", prefix = "-s")
o1 <- OutputParam(id = "sout", type = "File", glob = "$(inputs.bam.nameroot).strand.txt")
req1 <- requireDocker("quay.io/biocontainers/rseqc:4.0.0--py38h4a8c8d9_1")
infer_experiment <- cwlProcess(baseCommand = "infer_experiment.py",
                               requirements = list(req1),
                               inputs = InputParamList(p1, p2, p3),
                               outputs = OutputParamList(o1),
                               stdout = "$(inputs.bam.nameroot).strand.txt")


infer_experiment <- addMeta(
    infer_experiment,
    label = "infer_experiment",
    doc = "Tool to “guess” how RNA-seq sequencing were configured, particulary how reads were stranded for strand-specific RNA-seq data",
    inputLabels = c("bed","bam","size"),
    inputDocs = c("Reference gene model in bed fomat.","Input alignment file in SAM or BAM format","Number of reads sampled from SAM/BAM file.default=200000"),
    outputLabels = c("sout"),
    outputDocs = c("Info regarding how reads were stranded for strand-specific RNA-seq data"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/Xinglab/rseqc",
        example = paste()
    )
)
