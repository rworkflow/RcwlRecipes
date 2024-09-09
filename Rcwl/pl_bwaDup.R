## bwaAlign + mergeBamDup
#' @include pl_bwa_align.R pl_mergeBamDup.R tl_markdup.R tl_mergeBam.R
p1 <- InputParam(id = "outBam", type = "string")
p2 <- InputParam(id = "RG", type = "string[]")
p3 <- InputParam(id = "threads", type = "int")
p4 <- InputParam(id = "Ref", type = "File",
                 secondaryFiles = c(".amb", ".ann", ".bwt",
                                    ".pac", ".sa", ".fai"))
p5 <- InputParam(id = "FQ1s", type = "File[]")
p6 <- InputParam(id = "FQ2s", type = "File[]?")
##p7 <- InputParam(id = "mdup", type = "boolean", default = TRUE)

s1 <- cwlStep(id = "bwaAlign", run = bwa_align,
           In = list(threads = "threads",
                     RG = "RG",
                     Ref = "Ref",
                     FQ1 = "FQ1s",
                     FQ2 = "FQ2s",
                     outBam = "outBam"),
           scatter = list("RG", "FQ1", "FQ2"),
           scatterMethod = "dotproduct")

s2 <- cwlStep(id = "mergeBam", run = mergeBam,
           In = list(ibam = "bwaAlign/Bam",
                     obam = list(source = list("outBam"),
                                 valueFrom="$(self).merge.bam")),
           when = "$(inputs.ibam.length>1)")

s3 <- cwlStep(id = "markdup", run = markdup,
              In = list(ibam = list(source = list("mergeBam/oBam", "bwaAlign/Bam"),
                                    pickValue = "first_non_null",
                                    valueFrom = "$(self)",
                                    linkMerge = "merge_flattened"),
                         obam = "outBam",
                         matrix = list(source = list("outBam"),
                                       valueFrom="$(self).markdup.txt")))
              ## when = "$(self[1]==true)")

#'@include tl_samtools_index.R tl_samtools_flagstat.R tl_samtools_stats.R tl_md5sum.R
s4 <- cwlStep(id = "samtools_index", run = samtools_index,
              In = list(bam = list(
                            source = list("markdup/mBam", "mergeBam/oBam", "bwaAlign/Bam"),
                            pickValue = "first_non_null",
                            valueFrom = "$(self)",
                            linkMerge = "merge_flattened")))
s5 <- cwlStep(id = "samtools_flagstat", run = samtools_flagstat,
           In = list(bam = "samtools_index/idx"))
s6 <- cwlStep(id = "samtools_stats", run = samtools_stats,
           In = list(bam = "samtools_index/idx"))
s7 <- cwlStep(id = "md5sum", run = md5sum,
              In = list(file = "samtools_index/idx"))


o1 <- OutputParam(id = "BAM", type = "File", outputSource = "samtools_index/idx")
o2 <- OutputParam(id = "matrix", type = "File", outputSource = "markdup/Mat")
o3 <- OutputParam(id = "flagstat", type = "File",
                  outputSource = "samtools_flagstat/flagstat")
o4 <- OutputParam(id = "stats", type = "File",
                  outputSource = "samtools_stats/stats")
o5 <- OutputParam(id = "md5s", type = "File", outputSource = "md5sum/md5")

req1 <- list(class = "SubworkflowFeatureRequirement")
req2 <- list(class = "ScatterFeatureRequirement")
req3 <- requireJS()
req4 <- list(class = "MultipleInputFeatureRequirement")
req5 <- list(class = "StepInputExpressionRequirement")
bwaDup <- cwlWorkflow(cwlVersion = "v1.2",
                      requirements = list(req1, req2, req3, req4, req5),
                      inputs = InputParamList(p1, p2, p3, p4, p5, p6),
                      outputs = OutputParamList(o1, o2, o3, o4, o5))
bwaDup <- bwaDup + s1 + s2 + s3 + s4 + s5 + s6 + s7

## bwaDup$outBam <- "test.bam"
## bwaDup$RG <- list("@RG\\tID:L1\\tSM:test", "@RG\\tID:L2\\tSM:test")
## bwaDup$threads <- 2
## bwaDup$Ref <- "~/qhu/references/hs37d5/hs37d5.fa"
## bwaDup$FQ1s <- list("~/qhu/projects/Rworkflow/testdata/test11_R1_L1.fq.gz",
##                     "~/qhu/projects/Rworkflow/testdata/test11_R1_L2.fq.gz")
## bwaDup$FQ2s <- list("~/qhu/projects/Rworkflow/testdata/test11_R2_L1.fq.gz",
##                     "~/qhu/projects/Rworkflow/testdata/test11_R2_L2.fq.gz")
## runCWL(bwaDup, outdir = "~/qhu/projects/Rworkflow/testdata/", showLog = TRUE, docker = "singularity")

## bwaDup$outBam <- "test.bam"
## bwaDup$RG <- list("@RG\\tID:L1\\tSM:test")
## bwaDup$threads <- 2
## bwaDup$Ref <- "~/qhu/references/hs37d5/hs37d5.fa"
## bwaDup$FQ1s <- list("~/qhu/projects/Rworkflow/testdata/test11_R1_L1.fq.gz")
## bwaDup$FQ2s <- list("~/qhu/projects/Rworkflow/testdata/test11_R2_L1.fq.gz")

## runCWL(bwaDup, outdir = "~/qhu/projects/Rworkflow/testdata/", showLog = TRUE, docker = "singularity", cwlArgs = "--debug")
