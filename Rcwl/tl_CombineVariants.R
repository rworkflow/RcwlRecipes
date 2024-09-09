
p1 <- InputParam(id = "variants",
                 type = InputArrayParam(items = "File", prefix = "--variant"))
p2 <- InputParam(id = "ref", prefix = "-R", type = "File",
                 secondaryFiles = c(".fai", "$(self.nameroot).dict"))
p3 <- InputParam(id = "ovcf", type = "string", prefix = "-o")
o1 <- OutputParam(id = "oVcf", type = "File", glob = "$(inputs.ovcf)")
req1 <- list(class = "DockerRequirement",
             dockerPull = "broadinstitute/gatk3:3.8-1")
CombineVariants <- cwlProcess(baseCommand = c("java", "-jar", "/usr/GenomeAnalysisTK.jar",
                                            "-T", "CombineVariants"),
                            requirements = list(req1),
                            arguments = list("--assumeIdenticalSamples"),
                            inputs = InputParamList(p1, p2, p3),
                            outputs = OutputParamList(o1))


CombineVariants <- addMeta(
    CombineVariants,
    label = "CombineVariants",
    doc = "Merges variant call format (VCF) files from different sources into a single VCF file.",
    inputLabels = c("variants","ref","ovcf"),
    inputDocs = c("VCF files to merge together","Reference sequence file","File to which variants should be written"),
    outputLabels = c("oVcf"),
    outputDocs = c("Merged variant files"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/broadinstitute/gatk",
        example = paste()
    )
)
