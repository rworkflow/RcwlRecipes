## fastqc
f1 <- InputParam(id = "seqfile", type = "File")
o1 <- OutputParam(id = "QCfile", type = "File", glob = "*.zip")

req1 <- requireDocker("quay.io/biocontainers/fastqc:0.12.1--hdfd78af_0")
fastqc <- cwlProcess(baseCommand = "fastqc",
                   requirements = list(req1),
                   arguments = list("--outdir", "./"),
                   inputs = InputParamList(f1),
                   outputs = OutputParamList(o1))



fastqc <- addMeta(
    fastqc,
    label = "fastqc",
    doc = "FastQC reads a set of sequence files and produces from each one a quality control report consisting of a number of different modules, each one of which will help to identify a different potential type of problem in your data.",
    inputLabels = c("seqfile"),
    inputDocs = c("Input fastq file"),
    outputLabels = c("QCfile"),
    outputDocs = c("Output Quality score report"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/s-andrews/FastQC",
        example = paste()
    )
)
