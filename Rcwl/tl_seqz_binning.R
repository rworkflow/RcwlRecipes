p1 <- InputParam(id = "seqz", type = "File", prefix = "--seqz")
p2 <- InputParam(id = "window", type = "int", prefix = "-w")
p3 <- InputParam(id = "out", type = "string", prefix = "-o")
o1 <- OutputParam(id = "seqzs", type = "File", glob = "$(inputs.out)")
r1 <- requireDocker("quay.io/biocontainers/sequenza-utils:3.0.0--py39h67e14b5_5")
seqz_binning <- cwlProcess(baseCommand = c("sequenza-utils", "seqz_binning"),
                           requirements = list(r1),
                           inputs = InputParamList(p1, p2, p3),
                           outputs = OutputParamList(o1))


seqz_binning <- addMeta(
    seqz_binning,
    label = "seqz_binning",
    doc = "Group or 'bin' sequencing data into uniform windows across the genome.",
    inputLabels = c("seqz","window","out"),
    inputDocs = c("A seqz file.","Window size used for binning the original seqz file. Default is 50.","Output file '-' for STDOUT"),
    outputLabels = c("seqzs"),
    outputDocs = c("A binned dataset that contains averaged statistics over fixed-size genomic windows."),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "NA",
        example = paste()
    )
)
