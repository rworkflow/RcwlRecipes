## picard markdup
p1 <- InputParam(id = "ibam", type = "File", prefix = "I=", separate = FALSE)
p2 <- InputParam(id = "obam", type = "string", prefix = "O=", separate = FALSE)
p3 <- InputParam(id = "matrix", type = "string", prefix = "M=", separate = FALSE)
o1 <- OutputParam(id = "mBam", type = "File", glob = "$(inputs.obam)")
o2 <- OutputParam(id = "Mat", type = "File", glob = "$(inputs.matrix)")
req1 <- list(class = "DockerRequirement",
             dockerPull = "quay.io/biocontainers/picard:2.21.1--0")
markdup <- cwlProcess(baseCommand = c("picard",
                                    "MarkDuplicates"),
                    requirements = list(req1),
                    inputs = InputParamList(p1, p2, p3),
                    outputs = OutputParamList(o1, o2))


markdup <- addMeta(
    markdup,
    label = "markdup",
    doc = "Identifies duplicate reads.This tool locates and tags duplicate reads in a BAM or SAM file, where duplicate reads are defined as originating from a single fragment of DNA.",
    inputLabels = c("ibam","obam","matrix"),
    inputDocs = c("One or more input SAM or BAM files to analyze. Must be coordinate sorted. Default value:null. This option may be specified 0 or more times.","The output file to write marked records to Required.","File to write duplication metrics to Required."),
    outputLabels = c("mBam","Mat"),
    outputDocs = c("Marked duplicate bam file","Metric of marked duplicate"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/biod/sambamba",
        example = paste()
    )
)
