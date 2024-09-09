## https://github.com/lh3/seqtk
p1 <- InputParam(id = "seq", type = "File", position = 1L)
p2 <- InputParam(id = "frac", type = "float?", position = 2L)
p3 <- InputParam(id = "num", type = "int?", position = 2L)
p4 <- InputParam(id = "seed", type = "int?", prefix = "-s")
p5 <- InputParam(id = "pass", type = "boolean?", prefix = "-2")
o1 <- OutputParam(id = "fq", type = "File", glob = "$(inputs.seq.nameroot)_s.fq")
req1 <- requireDocker("quay.io/biocontainers/seqtk:1.4--he4a0461_1")

seqtk_sample <- cwlProcess(baseCommand = c("seqtk", "sample"),
           requirements = list(req1),
           inputs = InputParamList(p1, p2, p3, p4, p5),
           outputs = OutputParamList(o1),
           stdout = "$(inputs.seq.nameroot)_s.fq")


seqtk_sample <- addMeta(
    seqtk_sample,
    label = "seqtk_sample",
    doc = "Randomly select and extract a subset of sequences from a given FASTA or FASTQ file.",
    inputLabels = c("seq","frac","num","seed","pass"),
    inputDocs = c("Sequence file","Fraction of seq to extract","Number of seq to extract","RNG seed [11]","2-pass mode: twice as slow but with much reduced memory"),
    outputLabels = c("fq"),
    outputDocs = c("Extracted file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/lh3/seqtk",
        example = paste()
    )
)
