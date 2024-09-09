## HTseq
## Input BAM needs to be sorted by position or name 
## For gene quantification

req1 <- list(class = "DockerRequirement",
             dockerPull = "genomicpariscentre/htseq")

p1 <- InputParam(id = "minaqual", type = "int", prefix = "-a")
p2 <- InputParam(id = "stranded", type = "string", prefix = "-s")
p3 <- InputParam(id = "bam", type = "File")
p4 <- InputParam(id = "gtf", type = "File")
o1 <- OutputParam(id = "out", type = "File", glob = "$(inputs.bam.nameroot).htseq.txt")

htseq <- cwlProcess(baseCommand = "htseq-count",
                 requirements = list(req1),
                 arguments = list("--format", "bam",
                                  "--mode", "intersection-strict"),
                 inputs = InputParamList(p1, p2, p3, p4),
                 outputs = OutputParamList(o1),
                 stdout = "$(inputs.bam.nameroot).htseq.txt")


htseq <- addMeta(
    htseq,
    label = "htseq",
    doc = "HTseq Input BAM needs to be sorted by position or name For gene quantification",
    inputLabels = c("minaqual","stranded","bam","gtf"),
    inputDocs = c("skip all reads with alignment quality lower than the given minimum value (default: 10)","whether the data is from a strand-specific assay.Specify 'yes', 'no', or 'reverse' (default: yes).'reverse' means 'yes' with reversed strand interpretation","Path to the SAM/BAM files containing the mapped reads.If '-' is selected, read from standard input","Path to the file containing the features"),
    outputLabels = c("out"),
    outputDocs = c("Count file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/htseq/htseq",
        example = paste()
    )
)
