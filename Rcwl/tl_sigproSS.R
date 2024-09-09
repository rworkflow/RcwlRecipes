# https://github.com/AlexandrovLab/SigProfilerSingleSample
p1 <- InputParam(id = "vcf", type = "File", position = 1)
o1 <- OutputParam(id = "out", type = "Directory", glob = "results")
req1 <- requireDocker("hubentu/sigpro:v2")

sigproSS <- cwlProcess(baseCommand = c("python", "/usr/local/bin/spss.py"),
                       requirements = list(req1),
                       inputs = InputParamList(p1),
                       outputs = OutputParamList(o1))


sigproSS <- addMeta(
    sigproSS,
    label = "sigproSS",
    doc = "SigProfilerSingleSample allows attributing a known set of mutational signatures to an individual sample.",
    inputLabels = c("vcf"),
    inputDocs = c("Input vcf file"),
    outputLabels = c("out"),
    outputDocs = c("Output directory"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/AlexandrovLab/SigProfilerSimulator",
        example = paste()
    )
)
