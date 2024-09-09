
p1 <- InputParam(id = "vcf", type = "File", prefix = "I=", separate = FALSE)
p2 <- InputParam(id = "ovcf", type = "string", prefix = "O=", separate = FALSE)
p3 <- InputParam(id = "dict", type = "File?", prefix = "SD=", separate = FALSE)
o1 <- OutputParam(id = "oVcf", type = "File", glob = "$(inputs.ovcf)")

req1 <- list(class = "DockerRequirement",
             dockerPull = "broadinstitute/picard")
SortVcf <- cwlProcess(baseCommand = c("java", "-jar", "/usr/picard/picard.jar",
                                    "SortVcf"),
                    requirements = list(req1),
                    inputs = InputParamList(p1, p2, p3),
                    outputs = OutputParamList(o1))


SortVcf <- addMeta(
    SortVcf,
    label = "SortVcf",
    doc = "Sorts one or more VCF files. This tool sorts the records in VCF files according to the order of the contigs in the header/sequence dictionary and then by coordinate.",
    inputLabels = c("vcf","ovcf","dict"),
    inputDocs = c("Input VCF(s) to be sorted. Multiple inputs must have the same sample names (in order) This argument must be specified at least once. Required.","Output VCF to be written. Required.","Sequence directory"),
    outputLabels = c("oVcf"),
    outputDocs = c("Sorted vcf file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/broadinstitute/picard",
        example = paste()
    )
)
