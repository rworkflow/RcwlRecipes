p1 <- InputParam(id = "files", type = "File[]")
p2 <- InputParam(id = "outfile", type = "string",
                 default = "merged.txt", position = -1)
o1 <- OutputParam(id = "out", type = "File", glob = "$(inputs.outfile)")
awk_merge <- cwlProcess(baseCommand = "awk",
                      arguments = list("FNR==1 && NR!=1 { while (/^<header>/) getline; } 1 {print}"),
                      inputs = InputParamList(p1, p2),
                      outputs = OutputParamList(o1),
                      stdout = "$(inputs.outfile)")


awk_merge <- addMeta(
    awk_merge,
    label = "awk_merge",
    doc = "Takes multiple input files and merges them into a single output file",
    inputLabels = c("files","outfile"),
    inputDocs = c("Array of files to be merged","Name of the merged output file"),
    outputLabels = c("out"),
    outputDocs = c("Merged output file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "NA",
        example = paste()
    )
)
