## Salmon index
## Reference (refMrna.fa) can be downloaded from http://hgdownload.cse.ucsc.edu/goldenpath/hg38/bigZips/

rep1 <- list(class = "DockerRequirement",
             dockerPull = "combinelab/salmon")
rep2 <- list(class = "InlineJavascriptRequirement")

p1 <- InputParam(id = "threadN", type = "int", prefix = "-p", position = 1)
p2 <- InputParam(id = "kmer", type = "int", prefix = "-k", position = 2)
p3 <- InputParam(id = "refFasta", type = "File", prefix = "-t", position = 3)
p4 <- InputParam(id = "outPrefix", type = "string", prefix = "-i", position = 4)
o1 <- OutputParam(id = "out1", type = "Directory", glob = "$(inputs.outPrefix)")

salmon_index <- cwlProcess(baseCommand = c("salmon", "index"), 
                             requirements = list(rep1, rep2),
                             arguments = list("--type", "quasi"),
                             inputs = InputParamList(p1, p2, p3, p4), 
                             outputs = OutputParamList(o1))


salmon_index <- addMeta(
    salmon_index,
    label = "salmon_index",
    doc = "Creates a salmon index.",
    inputLabels = c("threadN","kmer","refFasta","outPrefix"),
    inputDocs = c("Number of threads to use during indexing.","The size of k-mers that should be used for the quasi index.","Transcript fasta file.","salmon index."),
    outputLabels = c("out1"),
    outputDocs = c("Salmon index file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/COMBINE-lab/salmon",
        example = paste()
    )
)
