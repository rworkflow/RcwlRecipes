# https://github.com/AlexandrovLab/SigProfilerSingleSample
p1 <- InputParam(id = "vcf", type = "File", position = 1)
o1 <- OutputParam(id = "out", type = "Directory", glob = "results")
req1 <- requireDocker("hubentu/sigpro:v2")

sigproSS <- cwlProcess(baseCommand = c("python", "/usr/local/bin/spss.py"),
                       requirements = list(req1),
                       inputs = InputParamList(p1),
                       outputs = OutputParamList(o1))
