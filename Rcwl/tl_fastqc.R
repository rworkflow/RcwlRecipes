## fastqc
f1 <- InputParam(id = "seqfile", type = "File")
o1 <- OutputParam(id = "QCfile", type = "File", glob = "*.zip")

req1 <- requireDocker("quay.io/biocontainers/fastqc:0.12.1--hdfd78af_0")
fastqc <- cwlProcess(baseCommand = "fastqc",
                   requirements = list(req1),
                   arguments = list("--outdir", "./"),
                   inputs = InputParamList(f1),
                   outputs = OutputParamList(o1))

