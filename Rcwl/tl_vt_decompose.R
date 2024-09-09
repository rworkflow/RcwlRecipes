## https://genome.sph.umich.edu/wiki/Vt

p1 <- InputParam(id = "ivcf", type = "File", position = 1)
p2 <- InputParam(id = "ovcf", type = "string", prefix = "-o", position = 2)
o1 <- OutputParam(id = "oVcf", type = "File", glob = "$(inputs.ovcf)")
    
req1 <- list(class = "DockerRequirement",
             dockerPull = "hubentu/vt")
vt_decompose <- cwlProcess(baseCommand = c("vt", "decompose"),
                         requirements = list(req1),
                         arguments = list("-s"),
                         inputs = InputParamList(p1, p2),
                         outputs = OutputParamList(o1))


vt_decompose <- addMeta(
    vt_decompose,
    label = "vt_decompose",
    doc = "variant manipulation toolset used for processing and analyzing VCF (Variant Call Format) files.",
    inputLabels = c("ivcf","ovcf"),
    inputDocs = c("Input vcf file","Output vcf file"),
    outputLabels = c("oVcf"),
    outputDocs = c("Output manipulated vcf file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://genome.sph.umich.edu/wiki/Vt",
        example = paste()
    )
)
