## https://illumina.github.io/NirvanaDocumentation/
p1 <- InputParam(id = "cache", type = "Directory", position = -1)
p2 <- InputParam(id = "sd", type = "Directory", prefix = "--sd")
p3 <- InputParam(id = "ref", type = "File", prefix = "-r")
p4 <- InputParam(id = "prefix", type = "string", prefix = "-o")
p5 <- InputParam(id = "vcf", type = "File", prefix = "-i")
o1 <- OutputParam(id = "out", type = "File", glob = "$(inputs.prefix).json.gz",
                  secondaryFile = ".jsi")
req1 <- requireDocker("annotation/nirvana:3.14")
Nirvana <- cwlProcess(cwlVersion = "v1.2",
                      baseCommand = c("dotnet", "/opt/nirvana/Nirvana.dll"),
                      arguments = list("-c", list(valueFrom="$(inputs.cache.path)/Both")),
                      requirements = list(req1),
                      inputs = InputParamList(p1, p2, p3, p4, p5),
                      outputs = OutputParamList(o1))


Nirvana <- addMeta(
    Nirvana,
    label = "Nirvana",
    doc = "Nirvana provides clinical-grade annotation of genomic variants (SNVs, MNVs, insertions, deletions, indels, STRs, gene fusions, and SVs (including CNVs).",
    inputLabels = c("cache","sd","ref","prefix","vcf"),
    inputDocs = c("input cache","input supplementary annotation directory","input compressed reference sequence path","output file path","input VCF path"),
    outputLabels = c("out"),
    outputDocs = c("Clinical grade annotated output"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://illumina.github.io/NirvanaDocumentation/",
        example = paste()
    )
)
