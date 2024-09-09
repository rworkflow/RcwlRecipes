## bwa mem
p1 <- InputParam(id = "threads", type = "int", prefix = "-t", position = 1)
p2 <- InputParam(id = "RG", type = "string?", prefix = "-R", position = 2)
p3 <- InputParam(id = "Ref", type = "File", position = 3,
                 secondaryFiles = c(".amb", ".ann", ".bwt", ".pac", ".sa"))
p4 <- InputParam(id = "FQ1", type = "File", position = 4)
p5 <- InputParam(id = "FQ2", type = "File?", position = 5)
o1 <- OutputParam(id = "sam", type = "File", glob = "*.sam")
req1 <- list(class = "DockerRequirement",
             dockerPull = "biocontainers/bwa:v0.7.17-3-deb_cv1")
bwa <- cwlProcess(baseCommand = c("bwa", "mem"),
                requirements = list(req1),
                inputs = InputParamList(p1, p2, p3, p4, p5),
                outputs = OutputParamList(o1),
                stdout = "bwaOutput.sam")


bwa <- addMeta(
    bwa,
    label = "bwa",
    doc = "BWA is a software package for mapping DNA sequences against a large reference genome, such as the human genome.",
    inputLabels = c("threads","RG","Ref","FQ1","FQ2"),
    inputDocs = c("number of threads [1]","read group header line such as '@RG\tID:foo\tSM:bar' [null]","Reference file","Paired fastq file 1","Paired fastq file 2"),
    outputLabels = c("sam"),
    outputDocs = c("Aligned sam File"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/lh3/bwa",
        example = paste()
    )
)
