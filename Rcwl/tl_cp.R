p1 <- InputParam(id = "file1", type = list("File", "Directory"), position = 2)
p2 <- InputParam(id = "file2", type = "string", position = 3)
p3 <- InputParam(id = "folder", type = "boolean?", prefix = "-r", position = 1)
o1 <- OutputParam(id = "cpfile", type = list("File", "Directory"), glob = "$(inputs.file2)")

cp <- cwlProcess(baseCommand = "cp",
                 inputs = InputParamList(p1, p2, p3),
                 outputs = OutputParamList(o1))


cp <- addMeta(
    cp,
    label = "cp",
    doc = "Copy files",
    inputLabels = c("file1","file2","folder"),
    inputDocs = c("Copy from file","Copy to file","Folder"),
    outputLabels = c("cpfile"),
    outputDocs = c("Copied file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "NA",
        example = paste()
    )
)
