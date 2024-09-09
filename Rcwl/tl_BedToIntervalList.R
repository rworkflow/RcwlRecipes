
p1 <- InputParam(id = "bed", type = "File", prefix = "I=", separate = FALSE)
p2 <- InputParam(id = "SD", type = "File", prefix = "SD=", separate = FALSE)
p3 <- InputParam(id = "out", type = "string", prefix = "O=", separate = FALSE)
o1 <- OutputParam(id = "intval", type = "File", glob = "$(inputs.out)")

req1 <- list(class = "DockerRequirement",
             dockerPull = "quay.io/biocontainers/picard:2.21.1--0")
BedToIntervalList <- cwlProcess(baseCommand = c("picard",
                                              "BedToIntervalList"),
                              requirements = list(req1),
                              inputs = InputParamList(p1, p2, p3),
                              outputs = OutputParamList(o1))


BedToIntervalList <- addMeta(
    BedToIntervalList,
    label = "BedToIntervalList",
    doc = "Converts a BED file to a Picard Interval List. This tool provides easy conversion from BED to the Picard interval_list format which is required by many Picard processing tools.",
    inputLabels = c("bed","SD","out"),
    inputDocs = c("Input Bed file","The sequence dictionary, or BAM/VCF/IntervalList from which a dictionary can be extracted.","The output Picard Interval List"),
    outputLabels = c("intval"),
    outputDocs = c("Convertrd picard intervel list"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/broadinstitute/gatk",
        example = paste()
    )
)
