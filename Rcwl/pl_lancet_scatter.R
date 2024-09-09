#' @include tl_lancet.R tl_bcftools_concat.R
p1 <- InputParam(id = "tbam", type = "File",
                 secondaryFiles = list("^.bai?", ".bai?"))
p2 <- InputParam(id = "nbam", type = "File",
                 secondaryFiles = list("^.bai?", ".bai?"))
p3 <- InputParam(id = "ref", type = "File",
                 secondaryFiles = ".fai")
p4 <- InputParam(id = "bed", type = "File[]")
p5 <- InputParam(id = "threads", type = "int")
p6 <- InputParam(id = "outvcf", type = "string")
s1 <- cwlStep(id = "lancet_bed", lancet,
              In = list(tbam = "tbam",
                        nbam = "nbam",
                        ref = "ref",
                        bed = "bed",
                        threads = "threads"),
              scatter = "bed",
              scatterMethod = "dotproduct")
s2 <- cwlStep(id = "mergeVcf", bcftools_concat,
              In = list(ovcf = list(source = list("tbam"),
                                    valueFrom = "$(self.nameroot)_lancet.vcf"),
                        vcfs = "lancet_bed/vcf"))
o1 <- OutputParam(id = "ovcf", type = "File", outputSource = "mergeVcf/Fout")
req1 <- requireScatter()
req2 <- requireStepInputExpression()
req3 <- requireJS()
lancet_scatter <- cwlWorkflow(cwlVersion = "v1.2",
                              requirements = list(req1, req2, req3),
                              inputs = InputParamList(p1, p2, p3, p4, p5),
                              outputs = OutputParamList(o1))
lancet_scatter <- lancet_scatter + s1 + s2
