## CombineGVCFs
p1 <- InputParam(id = "vcfs",
                 type = InputArrayParam(items = "File", prefix = "--variant"),
                 secondaryFiles = ".tbi")
p2 <- InputParam(id = "Ref", type = "File", prefix = "-R",
                 secondaryFiles = c(".fai", "$(self.nameroot).dict"))
p3 <- InputParam(id = "ovcf", type = "string", prefix = "-O")
o1 <- OutputParam(id = "vcf", type = "File", glob = "$(inputs.ovcf)",
                  secondaryFiles = ".idx")
req1 <- list(class = "DockerRequirement",
             dockerPull = "broadinstitute/gatk:latest")
CombineGVCFs <- cwlProcess(baseCommand = c("gatk", "CombineGVCFs"),
                         requirements = list(req1),
                         inputs = InputParamList(p1, p2, p3),
                         outputs = OutputParamList(o1))


CombineGVCFs <- addMeta(
    CombineGVCFs,
    label = "CombineGVCFs",
    doc = "Merges one or more HaplotypeCaller GVCF files into a single GVCF with appropriate annotations",
    inputLabels = c("vcfs","Ref","ovcf"),
    inputDocs = c("One or more VCF files containing variants This argument must be specified at least once. Required.","Reference sequence file Required.","The combined GVCF output file Required."),
    outputLabels = c("vcf"),
    outputDocs = c("Combined GVCF file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/broadinstitute/gatk",
        example = paste()
    )
)
