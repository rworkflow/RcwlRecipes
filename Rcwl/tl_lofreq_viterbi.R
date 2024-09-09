p1 <- InputParam(id = "ref", type = "File", prefix = "-f",
                 secondaryFiles = ".fai", position = 1)
p2 <- InputParam(id = "bam", type = "File", position = 2, secondaryFiles = ".bai")
p3 <- InputParam(id = "vbam", type = "string", position = -1)
o1 <- OutputParam(id = "obam", type = "File", glob = "$(inputs.vbam)")
req1 <- requireDocker("quay.io/biocontainers/lofreq:2.1.5--py37h916d2e8_4")
lofreq_viterbi <- cwlProcess(baseCommand = c("lofreq", "viterbi"),
                             requirements = list(req1),
                             arguments = list("--verbose"),
                             inputs = InputParamList(p1, p2, p3),
                             outputs = OutputParamList(o1),
                             stdout = "$(inputs.vbam)")


lofreq_viterbi <- addMeta(
    lofreq_viterbi,
    label = "lofreq_viterbi",
    doc = "Probabilistic realignment of your already mapped reads, which corrects mapping errors (run right after mapping). Not recommended for non-Illumina data.",
    inputLabels = c("ref","bam","vbam"),
    inputDocs = c("Indexed reference fasta file [null]","Input bam file","Input variant bam file"),
    outputLabels = c("obam"),
    outputDocs = c("realigned bam file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/arq5x/lumpy-sv",
        example = paste()
    )
)
