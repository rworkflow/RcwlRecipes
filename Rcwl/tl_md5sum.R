p1 <- InputParam(id = "file", type = "File")
o1 <- OutputParam(id = "md5", type = "File", glob = "$(inputs.file.basename).md5")
md5sum <- cwlProcess(baseCommand = "md5sum",
                     inputs = InputParamList(p1),
                     outputs = OutputParamList(o1),
                     stdout = "$(inputs.file.basename).md5")


md5sum <- addMeta(
    md5sum,
    label = "md5sum",
    doc = "compute and verify MD5 (Message Digest Algorithm 5) checksums for files",
    inputLabels = c("file"),
    inputDocs = c("Input FIle"),
    outputLabels = c("md5"),
    outputDocs = c("md5 checksum"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "NA",
        example = paste()
    )
)
