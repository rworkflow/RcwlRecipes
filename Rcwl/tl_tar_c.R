p1 <- InputParam(id = "create", type = "boolean?", prefix = "-c", position = 1, default = TRUE)
p2 <- InputParam(id = "compress", type = "boolean?", prefix = "-z", position = 2, default = TRUE)
p3 <- InputParam(id = "tar", type = "string", prefix = "-f", position = 3)
p4 <- InputParam(id = "files", type = list("File[]?", "File?"), position = 4)
p5 <- InputParam(id = "dir", type = "Directory[]?", position = 5)
o1 <- OutputParam(id = "tarfile", type = "File", glob = "$(inputs.tar)")

tar_c <- cwlProcess(baseCommand = "tar",
                    inputs = InputParamList(p1, p2, p3, p4, p5),
                    outputs = OutputParamList(o1))


tar_c <- addMeta(
    tar_c,
    label = "tar_c",
    doc = "The tar command bundles multiple files and directories into a single file,",
    inputLabels = c("create","compress","tar","files","dir"),
    inputDocs = c("Create a new archive.","Compress or decompress using gzip.","name of the archive file","File list","Input directroty"),
    outputLabels = c("tarfile"),
    outputDocs = c("tar files"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "NA",
        example = paste()
    )
)
