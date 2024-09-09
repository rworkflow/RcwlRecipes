## https://illumina.github.io/NirvanaDocumentation/
p1 <- InputParam(id = "genome", type = "string", prefix = "--ga")
o1 <- OutputParam(id = "data", type = "Directory[]", glob = "*")
req1 <- requireDocker("annotation/nirvana:3.14")
Nirvana_download <- cwlProcess(baseCommand = c("dotnet", "/opt/nirvana/Downloader.dll"),
                               arguments = list("-o", "./"),
                               requirements = list(req1),
                               inputs = InputParamList(p1),
                               outputs = OutputParamList(o1))


Nirvana_download <- addMeta(
    Nirvana_download,
    label = "Nirvana_download",
    doc = "Download the necessary reference data files and annotation databases required by Nirvana to perform variant annotation.",
    inputLabels = c("genome"),
    inputDocs = c("genome assembly version"),
    outputLabels = c("data"),
    outputDocs = c("Downloaded output file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://illumina.github.io/NirvanaDocumentation/",
        example = paste()
    )
)
