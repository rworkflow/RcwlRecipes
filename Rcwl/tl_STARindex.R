p1 <- InputParam(id = "genomeDir", type = "string", prefix = "--genomeDir",
                 default = "STARindex")
p2 <- InputParam(id = "genomeFastaFiles", type = "File", prefix = "--genomeFastaFiles")
p3 <- InputParam(id = "sjdbGTFfile", type = "File", prefix = "--sjdbGTFfile")
p4 <- InputParam(id = "runThreadN", type = "int", prefix = "--runThreadN", default = 4L)

o1 <- OutputParam(id = "outIndex", type = "Directory", glob = "$(inputs.genomeDir)")

STARindex <- cwlProcess(baseCommand = "STAR",
                      requirements = list(requireDocker("quay.io/biocontainers/star:2.7.10a--h9ee0642_0")),
                      arguments = list("--runMode", "genomeGenerate"),
                      inputs = InputParamList(p1, p2, p3, p4),
                      outputs = OutputParamList(o1))


STARindex <- addMeta(
    STARindex,
    label = "STARindex",
    doc = "Create star index",
    inputLabels = c("genomeDir","genomeFastaFiles","sjdbGTFfile","runThreadN"),
    inputDocs = c("path to the directory where the genome indices are stored.","one or more FASTA files with the genome reference sequences","path to the file with annotated transcripts in the standard GTF format.","defines the number of threads to be used for genome generation"),
    outputLabels = c("outIndex"),
    outputDocs = c("Output index file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/alexdobin/STAR",
        example = paste()
    )
)
