p1 <- InputParam(id = "inputFiles", type = "File[]", prefix = "-i")
p2 <- InputParam(id = "key", type = "int", prefix = "-k")
p3 <- InputParam(id = "field", type = "int", prefix = "-f")
p4 <- InputParam(id = "outfile", type = "string", prefix = "-o")
p5 <- InputParam(id = "noheader", type = "boolean?")
o1 <- OutputParam(id = "outFile", type = "File", glob = "$(inputs.outfile)")
req1 <- list(class = "DockerRequirement",
             dockerPull = "hubentu/suppa")
SUPPA_multipleFieldSelection <-
    cwlProcess(baseCommand = c("python", "/opt/SUPPA/multipleFieldSelection.py"),
             requirements = list(req1),
             inputs = InputParamList(p1, p2, p3, p4, p5),
             outputs = OutputParamList(o1))


SUPPA_multipleFieldSelection <- addMeta(
    SUPPA_multipleFieldSelection,
    label = "SUPPA_multipleFieldSelection",
    doc = "Takes 1 or more fields from multiple files with a common format and at least a common field which can be used as a unique identifier.",
    inputLabels = c("inputFiles","key","field","outfile","noheader"),
    inputDocs = c("spaced separated list of files to join.","common field among the input files.","spaced separated list of fields to select.(starting in 1)","name of the output file.","use it if the file has no header."),
    outputLabels = c("outFile"),
    outputDocs = c("Feild selected output file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/comprna/SUPPA",
        example = paste()
    )
)
