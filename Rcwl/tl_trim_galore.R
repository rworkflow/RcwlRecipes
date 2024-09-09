p1 <- InputParam(id = "fq1", type = "File", position = 9)
p2 <- InputParam(id = "fq2", type = "File?", position = 10)
p3 <- InputParam(id = "a1", type = "string", prefix = "-a", default = "AGATCGGAAGAGC")
p4 <- InputParam(id = "a2", type = "string?", prefix = "-a2", default = "AAATCAAAAAAAC")
p5 <- InputParam(id = "paired", type = "boolean", prefix = "--paired", default = TRUE)
o1 <- OutputParam(id = "FQ1", type = "File", glob = "*_1.fq.gz")
o2 <- OutputParam(id = "FQ2", type = "File", glob = "*_2.fq.gz")
o3 <- OutputParam(id = "report", type = "File[]", glob = "*.txt")
req1 <- requireDocker("quay.io/biocontainers/trim-galore:0.6.7--hdfd78af_0")
trim_galore <- cwlProcess(baseCommand = "trim_galore",
                          arguments = list("-o", "./"),
                          requirements = list(req1),
                          inputs = InputParamList(p1, p2, p3, p4, p5),
                          outputs = OutputParamList(o1, o2, o3))


trim_galore <- addMeta(
    trim_galore,
    label = "trim_galore",
    doc = "Trim Galore is a wrapper around Cutadapt and FastQC to consistently apply adapter and quality trimming to FastQ files, with extra functionality for RRBS data.",
    inputLabels = c("fq1","fq2","a1","a2","paired"),
    inputDocs = c("Fastq file 1","Fastq file 2","Adapter sequence to be trimmed. If not specified explicitly, Trim Galore will try to auto-detect whether the Illumina universal, Nextera transposase or Illumina small RNA adapter sequence was used.","Optional adapter sequence to be trimmed off read 2 of paired-end files. This option requires '--paired' to be specified as well.","This option performs length trimming of quality/adapter/RRBS trimmed reads for paired-end files. To pass the validation test, both sequences of a sequence pair are required to have a certain minimum length which is governed by the option --length (see above)"),
    outputLabels = c("FQ1","FQ2","report"),
    outputDocs = c("Trimmed Fastq1","Trimmed Fastq 2","Quality metric"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/FelixKrueger/TrimGalore",
        example = paste()
    )
)
