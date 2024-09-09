p1 <- InputParam(id = "ioe", type = "File", prefix = "-i")
p2 <- InputParam(id = "exp", type = "File", prefix = "-e")
p3 <- InputParam(id = "outfile", type = "string", prefix = "-o")
o1 <- OutputParam(id = "outFile", type = "File[]", glob = "$(inputs.outfile).psi")
req1 <- list(class = "DockerRequirement",
             dockerPull = "hubentu/suppa")
SUPPA_psiPerEvent <-
    cwlProcess(baseCommand = c("python", "/opt/SUPPA/suppa.py", "psiPerEvent"),
             requirements = list(req1),
             inputs = InputParamList(p1, p2, p3),
             outputs = OutputParamList(o1))


SUPPA_psiPerEvent <- addMeta(
    SUPPA_psiPerEvent,
    label = "SUPPA_psiPerEvent",
    doc = "calculates the Percent Spliced In (PSI) values for different types of alternative splicing events across multiple samples.",
    inputLabels = c("ioe","exp","outfile"),
    inputDocs = c("Input file with the event-transcripts equivalence (.ioe format).","Input transcript expression file.","Output psi file."),
    outputLabels = c("outFile"),
    outputDocs = c("file containing the PSI values for the specified splicing events across all samples."),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/comprna/SUPPA",
        example = paste()
    )
)
