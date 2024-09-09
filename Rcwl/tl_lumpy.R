## https://github.com/arq5x/lumpy-sv
p1 <- InputParam(id = "bam", type = "File[]", prefix = "-B", itemSeparator = ",", secondaryFiles = ".bai")
p2 <- InputParam(id = "split", type = "File[]", prefix = "-S", itemSeparator = ",", secondaryFiles = ".bai")
p3 <- InputParam(id = "discord", type = "File[]", prefix = "-D", itemSeparator = ",", secondaryFiles = ".bai")
p4 <- InputParam(id = "vout", type = "string", prefix = "-o")
o1 <- OutputParam(id = "vcf", type = "File", glob = "$(inputs.vout)")
req1 <- requireDocker("quay.io/biocontainers/lumpy-sv:0.3.1--hdfd78af_3")
lumpy <- cwlProcess(baseCommand = "lumpyexpress",
                    requirements = list(req1),
                    inputs = InputParamList(p1, p2, p3, p4),
                    outputs = OutputParamList(o1))


lumpy <- addMeta(
    lumpy,
    label = "lumpy",
    doc = "A probabilistic framework for structural variant discovery.",
    inputLabels = c("bam","split","discord","vout"),
    inputDocs = c("full BAM or CRAM file(s) (comma separated) (required)","split reads BAM file(s) (comma separated)","discordant reads BAM files(s) (comma separated)","output file [fullBam.bam.vcf]"),
    outputLabels = c("vcf"),
    outputDocs = c("Output Variant file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/arq5x/lumpy-sv",
        example = paste()
    )
)
