## mutliqc
p1 <- InputParam(id = "dir", type = "Directory")
o1 <- OutputParam(id = "qc", type = "File", glob = "*.html")
o2 <- OutputParam(id = "qcDat", type = "Directory", glob = "multiqc_data")
req1 <- requireDocker("quay.io/biocontainers/multiqc:1.11--pyhdfd78af_0")

multiqc <- cwlProcess(baseCommand = "multiqc",
                    requirements = list(req1),
                    inputs = InputParamList(p1),
                    outputs = OutputParamList(o1, o2))


multiqc <- addMeta(
    multiqc,
    label = "multiqc",
    doc = "MultiQC aggregates results from bioinformatics analyses across many samples into a single report.",
    inputLabels = c("dir"),
    inputDocs = c("Input directory"),
    outputLabels = c("qc","qcDat"),
    outputDocs = c("Output QC metric","Output QC metric"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/ewels/MultiQC",
        example = paste()
    )
)
