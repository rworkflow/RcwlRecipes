## CombineGenotypeGVCFs
p1 <- InputParam(id = "vcfs", type = InputArrayParam(items = "File"), secondaryFiles = ".idx")
p2 <- InputParam(id = "Ref", type = "File", secondaryFiles = c(".fai", "$(self.nameroot).dict"))
p3 <- InputParam(id = "out", type = "string")

#' @include tl_CombineGVCFs.R
s1 <- Step(id = "CombineGVCFs", run = CombineGVCFs,
           In = list(vcfs = "vcfs",
                     Ref = "Ref",
                     ovcf = list(source = "out",
                                 valueFrom = "$(self).g.vcf")))
#' @include tl_GenotypeGVCFs.R
s2 <- Step(id = "GenotypeGVCFs", run = GenotypeGVCFs,
           In = list(variant = "CombineGVCFs/cvcf",
                     ref = "Ref",
                     vout = "out"))
o1 <- OutputParam(id = "VCF", type = "File",
                  outputSource = "GenotypeGVCFs/vcf", secondaryFiles = ".idx")
req1 <- list(class = "StepInputExpressionRequirement")
req2 <- list(class = "InlineJavascriptRequirement")
CombineGenotypeGVCFs <- cwlStepParam(requirements = list(req1, req2),
                                     inputs = InputParamList(p1, p2, p3),
                                     outputs = OutputParamList(o1))
CombineGenotypeGVCFs <- CombineGenotypeGVCFs + s1 + s2
