## makeblastdb: NCBI-blast+:v2.2.31_cv2, only for "-dbtype nucl"

req1 <- list(class = "DockerRequirement",
             dockerPull = "biocontainers/blast:v2.2.31_cv2")
req2 <- list(class = "InitialWorkDirRequirement", 
             listing = list("$(inputs.Ref)"))
req3 <- list(class = "InlineJavascriptRequirement")

p1 <- InputParam(id = "Ref", type = "File", prefix = "-in", valueFrom = "$(self.basename)")
o1 <- OutputParam(id = "idx", type = "File", 
                  glob = "$(inputs.Ref.basename)",
                  secondaryFiles = c("$(inputs.Ref.basename + '.nhr')",
                                     "$(inputs.Ref.basename + '.nin')", 
                                     "$(inputs.Ref.basename + '.nsq')"))

makeblastdb <- cwlProcess(baseCommand = c("makeblastdb"), 
                      requirements = list(req1, req2, req3),
                      arguments = list("-dbtype", "nucl"), 
                      inputs = InputParamList(p1), 
                      outputs = OutputParamList(o1))


makeblastdb <- addMeta(
    makeblastdb,
    label = "makeblastdb",
    doc = "Produces BLAST databases from FASTA files",
    inputLabels = c("Ref"),
    inputDocs = c("Input sequence file"),
    outputLabels = c("idx"),
    outputDocs = c("blast db"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/ncbi/blast_plus",
        example = paste()
    )
)
