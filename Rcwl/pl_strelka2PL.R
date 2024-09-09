#' @include tl_manta.R tl_strelka.R
p1 <- InputParam(id = "tbam", type = "File", secondaryFiles = ".bai")
p2 <- InputParam(id = "nbam", type = "File", secondaryFiles = ".bai")
p3 <- InputParam(id = "ref", type = "File", secondaryFiles = ".fai")
p4 <- InputParam(id = "region", type = "File?", secondaryFiles = ".tbi")
p5 <- InputParam(id = "exome", type = "boolean", default = TRUE)
s1 <- cwlStep(id = "manta", run = manta,
           In = list(tbam = "tbam",
                     nbam = "nbam",
                     ref = "ref",
                     callRegions = "region",
                     exome = "exome"))
s2 <- cwlStep(id = "strelka", run = strelka,
           In = list(tbam = "tbam",
                     nbam = "nbam",
                     ref = "ref",
                     callRegions = "region",
                     indelCandidates = "manta/candidateSmallIndels",
                     exome = "exome"))
#' @include tl_bcftools_view.R
s3 <- cwlStep(id = "strelkaSNV", run = bcftools_view,
              In = list(vcf = "strelka/snvs",
                        filter = list(valueFrom = "PASS"),
                        fout = list(source = "tbam",
                                    valueFrom = "$(self.nameroot)_strelka2.somatic.snvs.vcf")))
s4 <- cwlStep(id = "strelkaIndel", run = bcftools_view,
              In = list(vcf = "strelka/indels",
                        filter = list(valueFrom = "PASS"),
                        fout = list(source = "tbam",
                                    valueFrom = "$(self.nameroot)_strelka2.somatic.indels.vcf")))

o1 <- OutputParam(id = "snvs", type = "File", outputSource = "strelkaSNV/Fout")
o2 <- OutputParam(id = "indels", type = "File", outputSource = "strelkaIndel/Fout")
##o3 <- OutputParam(id = "somaticSV", type = "File", outputSource = "manta/somaticSV")
##o4 <- OutputParam(id = "diploidSV", type = "File", outputSource = "manta/diploidSV")
strelka2PL <- cwlWorkflow(requirements = list(requireStepInputExpression()),
                          inputs = InputParamList(p1, p2, p3, p4, p5),
                          outputs = OutputParamList(o1, o2))
strelka2PL <- strelka2PL + s1 + s2 + s3 + s4
