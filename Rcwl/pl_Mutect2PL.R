## https://gatk.broadinstitute.org/hc/en-us/articles/360035531132--How-to-Call-somatic-mutations-using-GATK4-Mutect2
p1a <- InputParam(id = "tbam", type = "File", secondaryFiles = ".bai")
p1b <- InputParam(id = "nbam", type = "File", secondaryFiles = ".bai")
p2 <- InputParam(id = "Ref", type = "File",
                 secondaryFiles = list(".fai", "^.dict"))
p3 <- InputParam(id = "normal", type = "string")
p4 <- InputParam(id = "tumor", type = "string")
p5 <- InputParam(id = "gresource", type = "File",
                 secondaryFiles = "$(self.nameext == '.gz' ? self.basename+'.tbi' : self.basename+'.idx')")
p6 <- InputParam(id = "pon", type = "File",
                 secondaryFiles = "$(self.nameext == '.gz' ? self.basename+'.tbi' : self.basename+'.idx')")
p7 <- InputParam(id = "interval", type = "File")
p8 <- InputParam(id = "comvcf", type = "File",
                 secondaryFiles = "$(self.nameext == '.gz' ? self.basename+'.tbi' : self.basename+'.idx')")
p9 <- InputParam(id = "filter", type = "string", default = "PASS")
p10 <- InputParam(id = "threads", type = "int?")
#' @include tl_Mutect2.R
s1 <- cwlStep(id = "Mutect2", run = Mutect2,
           In = list(tbam = "tbam",
                     nbam = "nbam",
                     Ref = "Ref",
                     normal = "normal",
                     germline = "gresource",
                     pon = "pon",
                     interval = "interval",
                     threads = "threads",
                     out = list(source = list("normal", "tumor"),
                                valueFrom = "$(self[0]).$(self[1])")))
#' @include tl_GetPileupSummaries.R
s2a <- cwlStep(id = "GetPileupSummariesT", run = GetPileupSummaries,
            In = list(bam = "tbam",
                      vcf = "comvcf",
                      interval = "comvcf",
                      pileup = list(valueFrom = "$(inputs.bam.nameroot).ptable")))
s2b <- cwlStep(id = "GetPileupSummariesN", run = GetPileupSummaries,
            In = list(bam = "nbam",
                      vcf = "comvcf",
                      interval = "comvcf",
                      pileup = list(valueFrom = "$(inputs.bam.nameroot).ptable")))
#' @include tl_CalculateContamination.R
s3 <- cwlStep(id = "CalculateContamination", run = CalculateContamination,
           In = list(ttable = "GetPileupSummariesT/pout",
                     ntable = "GetPileupSummariesN/pout",
                     cont = list(source = list("tumor"),
                                 valueFrom = "$(self).contamination.table"),
                     seg = list(source = list("tumor"),
                                valueFrom = "$(self).segments")))
#' @include tl_LearnReadOrientationModel.R
s4 <- cwlStep(id = "LearnReadOrientationModel", run = LearnReadOrientationModel,
           In = list(f1r2 = "Mutect2/F1r2"))

#' @include tl_FilterMutectCalls.R
s5 <- cwlStep(id = "FilterMutectCalls", run = FilterMutectCalls,
           In = list(vcf = "Mutect2/vout",
                     cont = "CalculateContamination/Cout",
                     seg = "CalculateContamination/Seg",
                     lro = "LearnReadOrientationModel/rofile",
                     ref = "Ref",
                     fvcf = list(source = list("normal", "tumor"),
                                 valueFrom = "$(self[0]).$(self[1]).filtered.vcf")))

#' @include tl_bcfview.R
s6 <- cwlStep(id = "bcfview", run = bcfview,
           In = list(vcf = "FilterMutectCalls/fout",
                     filter = "filter",
                     fout = list(valueFrom = "$(inputs.vcf.nameroot).PASS.vcf")))

o1 <- OutputParam(id = "filterVCF", type = "File", outputSource = "FilterMutectCalls/fout")
o2 <- OutputParam(id = "passVCF", type = "File", outputSource = "bcfview/Fout")
o3 <- OutputParam(id = "conTable", type = "File", outputSource = "CalculateContamination/Cout")
o4 <- OutputParam(id = "segment", type = "File", outputSource = "CalculateContamination/Seg")

req1 <- list(class = "InlineJavascriptRequirement")
req2 <- list(class = "StepInputExpressionRequirement")
req3 <- list(class = "MultipleInputFeatureRequirement")
Mutect2PL <- cwlWorkflow(cwlVersion = "v1.0",
                         requirements = list(req1, req2, req3),
                         inputs = InputParamList(p1a, p1b, p2, p3, p4,
                                                 p5, p6, p7, p8, p9, p10),
                         outputs = OutputParamList(o1, o2, o3, o4))

Mutect2PL <- Mutect2PL + s1 + s2a + s2b + s3 + s4 + s5 + s6 
