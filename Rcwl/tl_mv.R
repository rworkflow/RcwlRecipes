p1 <- InputParam(id = "file1", type = "File", position = 1)
p2 <- InputParam(id = "file2", type = "string", position = 2)
o1 <- OutputParam(id = "mvfile", type = "File", glob = "$(inputs.file2)")

mv <- cwlProcess(baseCommand = "mv",
                 inputs = InputParamList(p1, p2),
                 outputs = OutputParamList(o1))


mv <- addMeta(
    mv,
    label = "mv",
    doc = "Move/rename file",
    inputLabels = c("file1","file2"),
    inputDocs = c("Input file","Name of output file"),
    outputLabels = c("mvfile"),
    outputDocs = c("renamed file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "NA",
        example = paste()
    )
)
