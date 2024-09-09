## https://software.broadinstitute.org/gatk/documentation/tooldocs/3.8-0/org_broadinstitute_gatk_tools_walkers_cancer_m2_MuTect2.php

p1a <- InputParam(id = "tbam", type = "File",
                  prefix = "-I:tumor", secondaryFiles = ".bai")
p1b <- InputParam(id = "nbam", type = "File?",
                  prefix = "-I:normal", secondaryFiles = ".bai")
p2 <- InputParam(id = "Ref", prefix = "-R", type = "File", secondaryFiles = c(".fai", "$(self.nameroot).dict"))
p3 <- InputParam(id = "dbSNP", prefix = "--dbsnp", type = "File?", secondaryFile = ".idx")
p4 <- InputParam(id = "cosmic", prefix = "--cosmic", type = "File?", secondaryFile = ".idx")
p5 <- InputParam(id = "interval", type = "File?", prefix = "-L")
p6 <- InputParam(id = "out", type = "string", prefix = "-o")
p7 <- InputParam(id = "nct", type = "int?", prefix = "-nct")
o1 <- OutputParam(id = "vout", type = "File", glob = "$(inputs.out)", secondaryFiles = c(".idx"))
req1 <- list(class = "DockerRequirement",
             dockerPull = "broadinstitute/gatk3:3.8-1")

Mutect2_gatk3 <- cwlProcess(baseCommand = c("java", "-jar", "/usr/GenomeAnalysisTK.jar",
                                          "-T", "MuTect2"),
                          requirements = list(req1),
                          inputs = InputParamList(p1a, p1b, p2, p3, p4, p5, p6, p7),
                          outputs = OutputParamList(o1))


Mutect2_gatk3 <- addMeta(
    Mutect2_gatk3,
    label = "Mutect2_gatk3",
    doc = "Call somatic SNVs and indels via local assembly of haplotypes GATK3",
    inputLabels = c("tbam","nbam","Ref","dbSNP","cosmic","interval","out","nct"),
    inputDocs = c("Tumer BAM/SAM/CRAM file containing reads This argument must be specified at least once.Required.","Normal BAM/SAM/CRAM file containing reads This argument must be specified at least once.Required.","Reference sequence file Required.","dbSNP file","VCF file of COSMIC sites","One or more genomic intervals over which to operate This argument may be specified 0 or more times. Default value: null.","File to which variants should be written","Number of CPU threads to allocate per data thread"),
    outputLabels = c("vout"),
    outputDocs = c("Variant annotated file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://software.broadinstitute.org/gatk/documentation/tooldocs/3.8-0/org_broadinstitute_gatk_tools_walkers_cancer_m2_MuTect2.php",
        example = paste()
    )
)
