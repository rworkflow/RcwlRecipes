p1 <- InputParam(id = "method", type = "string", prefix = "-m")
p2 <- InputParam(id = "iox", type = "File", prefix = "-i")
p3 <- InputParam(id = "psi", type = "File[]", prefix = "-p")
p4 <- InputParam(id = "exp", type = "File[]", prefix = "-e")
p5 <- InputParam(id = "output", type = "string", prefix = "-o")
p6 <- InputParam(id = "gc", type = "boolean", prefix = "-gc", default = TRUE)
p7 <- InputParam(id = "paired", type = "boolean", prefix = "-pa", default = FALSE)
o1 <- OutputParam(id = "outFile", type = "File[]", glob = "$(inputs.output)*")
req1 <- list(class = "DockerRequirement",
             dockerPull = "hubentu/suppa")
SUPPA_diffSplice <-
    cwlProcess(baseCommand = c("python", "/opt/SUPPA/suppa.py", "diffSplice"),
             requirements = list(req1),
             inputs = InputParamList(p1, p2, p3, p4, p5, p6, p7),
             outputs = OutputParamList(o1))



SUPPA_diffSplice <- addMeta(
    SUPPA_diffSplice,
    label = "SUPPA_diffSplice",
    doc = "tool within the SUPPA suite designed to detect differential alternative splicing events between experimental conditions using RNA-seq data.",
    inputLabels = c("method","iox","psi","exp","output","gc","paired"),
    inputDocs = c("Method to test significance. Required.","Input file with the event-transcripts equivalence","Path of the PSI files. PSI files and the transcript expression (TPM) files must have the same order.","Path of the transcript expression (TPM) files.Conditions files and the transcript expression (TPM) files must have the same order.","Name of the output files.","If True, SUPPA correct the p-values by gene.(Default: False).","Indicates if replicates in conditions are paired. (Default: False)."),
    outputLabels = c("outFile"),
    outputDocs = c("Output files of SUPPA diffsplice"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/comprna/SUPPA",
        example = paste()
    )
)
