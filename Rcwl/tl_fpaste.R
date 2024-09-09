p1 <- InputParam(id = "files", type = "File[]")
p2 <- InputParam(id = "sep", type = "string?", prefix = "-d")
p3 <- InputParam(id = "outfile", type = "string", position = -1L, default = "paste.txt")
o1 <- OutputParam(id = "out", type = "File", glob = "$(inputs.outfile)")
fpaste <- cwlProcess(baseCommand = "paste",
                     inputs = InputParamList(p1, p2, p3),
                     outputs = OutputParamList(o1),
                     stdout = "$(inputs.outfile)")


fpaste <- addMeta(
    fpaste,
    label = "fpaste",
    doc = "Concatenate corresponding lines of multiple input file",
    inputLabels = c("files","sep","outfile"),
    inputDocs = c("Input files","delimiter value","Output file name"),
    outputLabels = c("out"),
    outputDocs = c("Concatinated file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "NA",
        example = paste()
    )
)
