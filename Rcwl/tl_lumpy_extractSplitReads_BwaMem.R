p1 <- InputParam(id = "sam", type = "File", prefix = "-i")
o1 <- OutputParam(id = "splitReads", type = "File", glob = "$(inputs.sam.nameroot).splitReads.sam")
req1 <- requireDocker("quay.io/biocontainers/lumpy-sv:0.3.1--hdfd78af_3")
lumpy_extractSplitReads_BwaMem <- cwlProcess(baseCommand = "extractSplitReads_BwaMem",
                                             requirements = list(req1),
                                             inputs = InputParamList(p1),
                                             outputs = OutputParamList(o1),
                                             stdout = "$(inputs.sam.nameroot).splitReads.sam")


lumpy_extractSplitReads_BwaMem <- addMeta(
    lumpy_extractSplitReads_BwaMem,
    label = "lumpy_extractSplitReads_BwaMem",
    doc = "Get split-read alignments from bwa-mem in lumpy compatible format. Ignores reads marked as duplicates.",
    inputLabels = c("sam"),
    inputDocs = c("A SAM file or standard input (-i stdin)."),
    outputLabels = c("splitReads"),
    outputDocs = c("split read alignment in lumpy format"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/arq5x/lumpy-sv",
        example = paste()
    )
)
