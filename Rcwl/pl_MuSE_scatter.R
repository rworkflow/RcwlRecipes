#' @include tl_MuSEv2.R tl_bcftools_concat.R tl_bcftools_norm.R tl_bcftools_sort.R
p1 <- InputParam(id = "tbam", type = "File", secondaryFiles = list(".bai?", "^.bai?"))
p2 <- InputParam(id = "nbam", type = "File", secondaryFiles = list(".bai?", "^.bai?"))
p3 <- InputParam(id = "region", type = "File[]")
p4 <- InputParam(id = "dbsnp", type = "File",
                 secondaryFiles = "$(self.nameext == '.gz' ? self.basename+'.tbi' : self.basename+'.idx')")
p5 <- InputParam(id = "ref", type = "File", secondaryFiles = ".fai")
p6 <- InputParam(id = "vcf", type = "string")
s1 <- cwlStep(id = "MuSEchr", MuSE,
              In = list(tbam = "tbam",
                        nbam = "nbam",
                        dbsnp = "dbsnp",
                        vcf = "vcf",
                        ref = "ref",
                        exome = list(valueFrom = "$(false)"),
                        genome = list(valueFrom = "$(true)"),
                        region = "region"),
              scatter = "region",
              scatterMethod = "dotproduct")
s2 <- cwlStep(id = "mergeVcf", bcftools_concat,
              In = list(ovcf = "vcf",
                        vcfs = "MuSEchr/outVcf"))
s3 <- cwlStep(id = "sortVcf", bcftools_sort,
              In = list(ovcf = "vcf",
                        vcf = "mergeVcf/Fout"))
s4 <- cwlStep(id = "normVcf", bcftools_norm,
              In = list(ovcf = "vcf",
                        vcf = "sortVcf/Fout",
                        dup = list(valueFrom = "none")))
o1 <- OutputParam(id = "ovcf", type = "File", outputSource = "normVcf/Fout")
MuSE_scatter <- cwlWorkflow(cwlVersion = "v1.2",
                            requirements = list(requireScatter(),
                                                requireStepInputExpression(),
                                                requireJS()),
                            inputs = InputParamList(p1, p2, p3, p4, p5, p6),
                            outputs = OutputParamList(o1))
MuSE_scatter <- MuSE_scatter + s1 + s2 + s3 + s4
