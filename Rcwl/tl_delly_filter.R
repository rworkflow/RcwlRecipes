
p1 <- InputParam(id = "filter", type = "string", prefix = "-f", default = "somatic")
p2 <- InputParam(id = "outfile", type = "string", prefix = "-o")
p3 <- InputParam(id = "samples", type = "File", prefix = "-s")
p4 <- InputParam(id = "tbcf", type = "File", secondaryFiles = ".csi")
o1 <- OutputParam(id = "fbcf", type = "File", glob = "$(inputs.outfile)",
                  secondaryFiles = ".csi")
req1 <- requireDocker("quay.io/biocontainers/delly:0.8.7--he03298f_1")
delly_filter <- cwlProcess(baseCommand = c("delly", "filter"),
                           requirements = list(req1),
                           inputs = InputParamList(p1, p2, p3, p4),
                           outputs = OutputParamList(o1))


delly_filter <- addMeta(
    delly_filter,
    label = "delly_filter",
    doc = "Filter structural variant calls based on specific criteria",
    inputLabels = c("filter","outfile","samples","tbcf"),
    inputDocs = c("Filter mode (somatic, germline)","Filtered SV BCF output file","Two-column sample file listing sample name and tumor or control","Input BCF file"),
    outputLabels = c("fbcf"),
    outputDocs = c("Filtered BCF file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/dellytools/delly",
        example = paste()
    )
)
