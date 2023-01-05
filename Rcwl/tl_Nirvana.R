## https://illumina.github.io/NirvanaDocumentation/
p1 <- InputParam(id = "cache", type = "Directory", prefix = "-c")
p2 <- InputParam(id = "sd", type = "Directory", prefix = "--sd")
p3 <- InputParam(id = "ref", type = "File", prefix = "-r")
p4 <- InputParam(id = "prefix", type = "string", prefix = "-o")
o1 <- OutputParam(id = "out", type = "File", glob = "$(inputs.prefix).gz",
                  secondaryFile = ".jsi")
req1 <- requireDocker("annotation/nirvana:3.14")
Nirvana <- cwlProcess(cwlVersion = "v1.2",
                      baseCommand = c("dotnet", "/opt/nirvana/Nirvana.dll"),
                      requirements = list(req1),
                      inputs = InputParamList(p1, p2, p3, p4),
                      outputs = OutputParamList(o1))
