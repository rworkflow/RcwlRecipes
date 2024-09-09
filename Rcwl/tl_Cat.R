p1 <- InputParam(id = "infiles", type = "File[]")
p2 <- InputParam(id = "outfile", type = "string", default = "catout.txt", position = -1)
Cat <- cwlProcess(baseCommand = "cat", inputs = InputParamList(p1, p2), stdout = "$(inputs.outfile)")


Cat <- addMeta(
    Cat,
    label = "Cat",
    doc = "Tool to read and copy files",
    inputLabels = c("infiles","outfile"),
    inputDocs = c("Input file to read and display","Output file to copy"),
    outputLabels = c(""),
    outputDocs = c(""),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "NA",
        example = paste()
    )
)
