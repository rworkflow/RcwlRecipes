## https://pachterlab.github.io/kallisto/

p1 <- InputParam(id = "index", type = "File", prefix = "-i")
p2 <- InputParam(id = "fastq", type = "File[]")
p3 <- InputParam(id = "threads", type = "int", prefix = "-t")
o1 <- OutputParam(id = "h5", type = "File", glob = "abundance.h5")
o2 <- OutputParam(id = "tsv", type = "File", glob = "abundance.tsv")
o3 <- OutputParam(id = "info", type = "File", glob = "run_info.json")

req1 <- list(class = "DockerRequirement",
             dockerPull = "zlskidmore/kallisto")
kallisto_quant <- cwlProcess(baseCommand = c("kallisto", "quant"),
                           requirements = list(req1),
                           arguments = list("-o", "./"),
                           inputs = InputParamList(p1, p2, p3),
                           outputs = OutputParamList(o1, o2, o3))


kallisto_quant <- addMeta(
    kallisto_quant,
    label = "kallisto_quant",
    doc = "Runs the quantification algorithm",
    inputLabels = c("index","fastq","threads"),
    inputDocs = c("Filename for the kallisto index to be used for quantification","Input dastq file","Number of threads to use (default: 1)"),
    outputLabels = c("h5","tsv","info"),
    outputDocs = c("HDF5 (Hierarchical Data Format) binary file that contains the same abundance information","Estimated abundance of transcripts in the RNA-Seq sample","A JSON file that contains metadata and information about the kallisto quant"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://pachterlab.github.io/kallisto/",
        example = paste()
    )
)
