## https://pachterlab.github.io/kallisto/

p1 <- InputParam(id = "index", type = "string", prefix = "-i")
p2 <- InputParam(id = "fasta", type = "File")
o1 <- OutputParam(id = "fidx", type = "File", glob = "$(inputs.index)")

req1 <- list(class = "DockerRequirement",
             dockerPull = "zlskidmore/kallisto")
kallisto_index <- cwlProcess(baseCommand = c("kallisto", "index"),
                           requirements = list(req1),
                           inputs = InputParamList(p1, p2),
                           outputs = OutputParamList(o1))


kallisto_index <- addMeta(
    kallisto_index,
    label = "kallisto_index",
    doc = "builds an index from a FASTA formatted file of target sequences.",
    inputLabels = c("index","fasta"),
    inputDocs = c("Filename for the kallisto index to be constructed","Input fasta file"),
    outputLabels = c("fidx"),
    outputDocs = c("Indexed file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://pachterlab.github.io/kallisto/",
        example = paste()
    )
)
