## picard ReorderSam
p1 <- InputParam(id = "ibam", type = "File", prefix = "I=", separate = FALSE)
p2 <- InputParam(id = "obam", type = "string", prefix = "O=", separate = FALSE)
p3 <- InputParam(id = "dict", type = "File", prefix = "SD=", separate = FALSE)
o1 <- OutputParam(id = "rBam", type = "File", glob = "$(inputs.obam)")
req1 <- list(class = "DockerRequirement",
             dockerPull = "quay.io/biocontainers/picard:2.21.1--0")
ReorderSam <- cwlProcess(baseCommand = c("picard",
                                       "ReorderSam"),
                       requirements = list(req1),
                       inputs = InputParamList(p1, p2, p3),
                       outputs = OutputParamList(o1))


ReorderSam <- addMeta(
    ReorderSam,
    label = "ReorderSam",
    doc = "ReorderSam reorders reads in a SAM/BAM file to match the contig ordering in a provided reference file, as determined by exact name matching of contigs.",
    inputLabels = c("ibam","obam","dict"),
    inputDocs = c("Input file (SAM or BAM) to extract reads from. Required.","Output file (SAM or BAM) to write extracted reads to. Required.","A Sequence Dictionary for the OUTPUT file (can be read from one of the following file types (SAM, BAM, VCF, BCF, Interval List, Fasta, or Dict) Required."),
    outputLabels = c("rBam"),
    outputDocs = c("Reordered bam file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/broadinstitute/picard",
        example = paste()
    )
)
