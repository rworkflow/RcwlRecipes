p1 <- InputParam(id = "fq1", type = "File", prefix = "-1")
p2 <- InputParam(id = "fq2", type = "File", prefix = "-2")
o1 <- OutputParam(id = "FQ1", type = "File", glob = "$(inputs.fq1.nameroot)_*")
o2 <- OutputParam(id = "FQ2", type = "File", glob = "$(inputs.fq2.nameroot)_*")
req1 <- requireInitialWorkDir(listing = list("$(inputs.fq1)",
                                             "$(inputs.fq2)"))
req2 <- requireDocker("hubentu/rrbs")

trimRRBSdiversity <- cwlProcess(baseCommand = c("python",
                                                "/opt/trimRRBSdiversityAdaptCustomers.py"),
                                requirements = list(req1, req2),
                                inputs = InputParamList(p1, p2),
                                outputs = OutputParamList(o1, o2))


trimRRBSdiversity <- addMeta(
    trimRRBSdiversity,
    label = "trimRRBSdiversity",
    doc = "Given a set of paired end read files, performs the trimming for RRBS with diversity adapters. Make sure the pattern names are in quotations.",
    inputLabels = c("fq1","fq2"),
    inputDocs = c("pattern for forward read files","pattern for reverse read files"),
    outputLabels = c("FQ1","FQ2"),
    outputDocs = c("Trimmed forward read file","Trimmed reverse read file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "NA",
        example = paste()
    )
)
