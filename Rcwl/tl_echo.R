p1 <- InputParam(id = "sth", type = "string")
p2 <- InputParam(id = "escape", type = "boolean?", prefix = "-e")
p3 <- InputParam(id = "outfile", type = "string", position = -1L, default = "echo.txt")
o1 <- OutputParam(id = "out", type = "File", glob = "$(inputs.outfile)")
echo <- cwlProcess(baseCommand = "echo",
                   inputs = InputParamList(p1, p2, p3),
                   outputs = OutputParamList(o1),
                   stdout = "$(inputs.outfile)")


echo <- addMeta(
    echo,
    label = "echo",
    doc = "Print string to file",
    inputLabels = c("sth","escape","outfile"),
    inputDocs = c("String to be printed","enables interpretation of escape sequences like \n (new line) or \t (tab).","Name of the output file"),
    outputLabels = c("out"),
    outputDocs = c("Outputfile that contains the printed string"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "NA",
        example = paste()
    )
)
