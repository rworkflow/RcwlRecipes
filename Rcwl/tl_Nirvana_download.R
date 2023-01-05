## https://illumina.github.io/NirvanaDocumentation/
p1 <- InputParam(id = "genome", type = "string", prefix = "--ga")
o1 <- OutputParam(id = "data", type = "Directory[]", glob = "*")
req1 <- requireDocker("annotation/nirvana:3.14")
Nirvana_download <- cwlProcess(baseCommand = c("dotnet", "/opt/nirvana/Downloader.dll"),
                               arguments = list("-o", "./"),
                               requirements = list(req1),
                               inputs = InputParamList(p1),
                               outputs = OutputParamList(o1))
