

p1 <- InputParam(id = "Sample", type = "string")
p2 <- InputParam(id = "RG", type = "string")
p3 <- InputParam(id = "threads", type = "int")
p4 <- InputParam(id = "Ref", type = "File",
                 secondaryFiles = c(".amb", ".ann", ".bwt", ".pac",
                                    ".sa", ".fai",
                                    "$(self.nameroot).dict"))
p5 <- InputParam(id = "FQ1", type = "File")
p6 <- InputParam(id = "FQ2", type = "File")
p7 <- InputParam(id = "knowSites", type = InputArrayParam(items = "File"),
                 secondaryFiles = ".idx")
p8 <- InputParam(id = "bed", type = "File")
p9 <- InputParam(id = "downsampling", type = "int", default = 0L)

o1 <- OutputParam(id = "BAM", type = "File", outputSource = "BaseRecal/rcBam")
o2 <- OutputParam(id = "flagstat", type = "File", outputSource = "BaseRecal/flagstat")
o3 <- OutputParam(id = "stats", type = "File", outputSource = "BaseRecal/stats")
o4 <- OutputParam(id = "gVCF", type = "File", outputSource = "HaplotypeCaller/gvcf")
o5 <- OutputParam(id = "VCF", type = "File", outputSource = "GenotypeGVCFs/vcf")

req1 <- list(class = "SubworkflowFeatureRequirement")
req2 <- list(class = "StepInputExpressionRequirement")
req3 <- list(class = "InlineJavascriptRequirement")
targetVarCall <- cwlWorkflow(requirements = list(req1, req2, req3),
                          inputs = InputParamList(p1, p2, p3, p4, p5, p6, p7, p8, p9),
                          outputs = OutputParamList(o1, o2, o3, o4, o5))
#' @include pl_bwaAlign.R
s1 <- cwlStep(id = "bwaAlign", run = bwaAlign,
           In = list(threads = "threads",
                     RG = "RG",
                     Ref = "Ref",
                     FQ1 = "FQ1",
                     FQ2 = "FQ2"))
#' @include pl_BaseRecal.R
s2 <- cwlStep(id = "BaseRecal", run = BaseRecal,
           In = list(bam = "bwaAlign/Idx",
                     ref = "Ref",
                     knowSites = "knowSites",
                     oBam = list(source = "Sample",
                                 valueFrom = "$(self).bam")))
#' @include tl_BedToIntervalList.R
s3 <- cwlStep(id = "bedtolist", run = BedToIntervalList,
           In = list(bed = "bed",
                     SD = list(source = "Ref",
                               valueFrom = "$(self.secondaryFiles[6])"),
                     out = list(valueFrom = "$(inputs.bed.nameroot).list")))
#' @include tl_HaplotypeCaller.R
s4 <- cwlStep(id = "HaplotypeCaller", run = HaplotypeCaller,
           In = list(bam = "BaseRecal/rcBam",
                     interval = "bedtolist/intval",
                     ref = "Ref",
                     gout = list(source = "Sample",
                                 valueFrom = "$(self).g.vcf"),
                     downsampling = "downsampling"))
#' @include tl_GenotypeGVCFs.R
s5 <- cwlStep(id = "GenotypeGVCFs", run = GenotypeGVCFs,
           In = list(variant = "HaplotypeCaller/gvcf",
                     ref = "Ref",
                     vout = list(source = "Sample",
                                 valueFrom = "$(self).vcf")))

targetVarCall <- targetVarCall + s1 + s2 + s3 + s4 + s5
