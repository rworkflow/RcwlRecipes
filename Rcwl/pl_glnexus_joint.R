## https://github.com/google/deepvariant/blob/r1.1/docs/trio-merge-case-study.md
p1 <- InputParam(id = "config", type = "string")
p2 <- InputParam(id = "bed", type = "File?")
p3 <- InputParam(id = "gvcfs", type = "File[]")
p4 <- InputParam(id = "ovcf", type = "string")
p5 <- InputParam(id = "threads", type = "int")

#' @include tl_glnexus_cli_list.R
s1 <- cwlStep(id = "glnexus", run = glnexus_cli_list,
              In = list(config = "config",
                        threads = "threads",
                        bed = "bed",
                        gvcfs = "gvcfs",
                        ovcf = list(valueFrom = "merged.bcf")))
#' @include tl_bcftools_view.R
s2 <- cwlStep(id = "bcf", run = bcftools_view,
              In = list(vcf = "glnexus/bcf",
                        fout = "ovcf",
                        otype = list(valueFrom = "z")))
o1 <- OutputParam(id = "outVcf", type = "File", outputSource = "bcf/Fout")
req1 <- requireStepInputExpression()
glnexus_joint <- cwlWorkflow(requirements = list(req1),
                             inputs = InputParamList(p1, p2, p3, p4, p5),
                             outputs = OutputParamList(o1))
glnexus_joint <- glnexus_joint + s1 + s2
