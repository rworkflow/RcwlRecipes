## GenotypeGVCFs
p1 <- InputParam(id = "variant", type = "File", prefix = "-V",
                 secondaryFiles = ".idx")
p2 <- InputParam(id = "ref", type = "File", prefix = "-R",
                 secondaryFiles = c(".fai", "$(self.nameroot).dict"))
p3 <- InputParam(id = "vout", type = "string", prefix = "-O")
o1 <- OutputParam(id = "vcf", type = "File", glob = "$(inputs.vout)",
                  secondaryFiles = ".idx")
req1 <- list(class = "DockerRequirement",
             dockerPull = "broadinstitute/gatk:latest")
GenotypeGVCFs <- cwlProcess(baseCommand = c("gatk", "GenotypeGVCFs"),
                          requirements = list(req1),
                          inputs = InputParamList(p1, p2, p3),
                          outputs = OutputParamList(o1))


GenotypeGVCFs <- addMeta(
    GenotypeGVCFs,
    label = "GenotypeGVCFs",
    doc = "Perform joint genotyping on a single-sample GVCF from HaplotypeCaller or a multi-sample GVCF from CombineGVCFs or GenomicsDBImport",
    inputLabels = c("variant","ref","vout"),
    inputDocs = c("A VCF file containing variants Required.","Reference sequence file Required.","File to which variants should be written Required."),
    outputLabels = c("vcf"),
    outputDocs = c("A final VCF in which all samples have been jointly genotyped."),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/broadinstitute/gatk",
        example = paste()
    )
)
