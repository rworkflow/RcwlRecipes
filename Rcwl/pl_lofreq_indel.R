
#' @include tl_lofreq_indelqual.R tl_samtools_index
p1 <- InputParam(id = "ref", type = "File", secondaryFiles = ".fai")
p2 <- InputParam(id = "bam", type = "File", secondaryFiles = ".bai")
## s1 <- cwlStep(id = "realign", run = lofreq_viterbi,
##               In = list(ref = "ref",
##                         bam = "bam",
##                         vbam = list(valueFrom = "$(inputs.bam.nameroot)_v.bam")))
## s2 <- cwlStep(id = "sortBam", run = samtools_sort,
##               In = list(bam = "realign/obam"))
s3 <- cwlStep(id = "indelq", run = lofreq_indelqual,
              In = list(ref = "ref",
                        bam = "bam",
                        ibam = list(valueFrom = "$(inputs.bam.nameroot)_i.bam")))
s4 <- cwlStep(id = "bamIdx", run = samtools_index,
              In = list(bam = "indelq/obam"))
o1 <- OutputParam(id = "ibam", type = "File", outputSource = "bamIdx/idx", secondaryFiles = ".bai")
lofreq_indel <- cwlWorkflow(requirements = list(requireStepInputExpression()),
                            inputs = InputParamList(p1, p2),
                            outputs = OutputParamList(o1))
lofreq_indel <- lofreq_indel + s3 + s4
