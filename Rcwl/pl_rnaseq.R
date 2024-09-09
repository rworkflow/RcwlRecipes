##source(system.file("tools", "fastQC.R", package = "RcwlPipelines"))
##source(system.file("tools", "featureCounts.R", package = "RcwlPipelines"))
##source(system.file("tools", "samtools_flagstat.R", package = "RcwlPipelines"))
##source(system.file("tools", "samtools_index.R", package = "RcwlPipelines"))
##source(system.file("pipelines", "RSeQC.R", package = "RcwlPipelines"))
##source(system.file("tools", "STAR.R", package = "RcwlPipelines"))

## Pipeline: fastQC + STAR + featureCounts + rnaseqc + TPM
## Note: output to current dir
p1 <- InputParam(id = "in_seqfiles", type = "File[]")
p2 <- InputParam(id = "in_prefix", type = "string")
p3 <- InputParam(id = "in_genomeDir", type = "Directory")
p4 <- InputParam(id = "in_GTFfile", type = "File")
p5 <- InputParam(id = "in_runThreadN", type = "int", default = 1L)
o1 <- OutputParam(id = "out_fastqc", type = "File[]", outputSource = "fastqc/QCfile")
o2a <- OutputParam(id = "out_BAM", type = "File",
                   outputSource = "samtools_index/idx")
o2b <- OutputParam(id = "out_Log", type = "File", outputSource = "STAR/outLog")
o2c <- OutputParam(id = "out_Count", type = "File", outputSource = "STAR/outCount")
##o3 <- OutputParam(id = "out_idx",type = "File", outputSource = "samtools_index/idx")
o4 <- OutputParam(id = "out_stat",type = "File", outputSource = "samtools_flagstat/flagstat")
o5 <- OutputParam(id = "out_count", type = "File", outputSource = "featureCounts/Count")

o6 <- OutputParam(id = "QCout", type = "File[]", outputSource = "rnaseqc/qcOut")

o9 <- OutputParam(id = "out_tpm", type = "File[]", outputSource = "tpm/out")
o10 <- OutputParam(id = "out_ent", type = "File[]", outputSource = "tpm/ent")
o11 <- OutputParam(id = "out_uni", type = "File[]", outputSource = "tpm/uni")

req1 <- list(class = "ScatterFeatureRequirement")
req2 <- list(class = "SubworkflowFeatureRequirement")
req3 <- list(class = "StepInputExpressionRequirement")
rnaseq <- cwlWorkflow(requirements = list(req1, req2, req3),
                      inputs = InputParamList(p1, p2, p3, p4, p5),
                      outputs = OutputParamList(o1, o2a, o2b, o2c, o4, o5, o6,
                                                o9, o10, o11))

## fastqc
#' @include tl_fastqc.R
s1 <- cwlStep(id = "fastqc", run = fastqc,
           In = list(seqfile = "in_seqfiles"),
           scatter = "seqfile")
## STAR
#' @include tl_STAR.R
## fix STAR sort problem
arguments(STAR)[[7]] <- "Unsorted"
s2 <- cwlStep(id = "STAR", run = STAR,
           In = list(prefix = "in_prefix",
                     genomeDir = "in_genomeDir",
                     sjdbGTFfile = "in_GTFfile",
                     readFilesIn = "in_seqfiles",
                     runThreadN = "in_runThreadN"))
## samtools
#' @include tl_sortBam.R tl_samtools_index.R tl_samtools_flagstat.R
s3a <- cwlStep(id = "sortBam", run = sortBam,
            In = list(bam = "STAR/outBAM"))
s3 <- cwlStep(id = "samtools_index", run = samtools_index,
           In = list(bam = "sortBam/sbam"))
s4 <- cwlStep(id = "samtools_flagstat", run = samtools_flagstat,
           In = list(bam = "sortBam/sbam"))
## featureCounts
#' @include tl_featureCounts.R
s5 <- cwlStep(id = "featureCounts", run = featureCounts,
           In = list(gtf = "in_GTFfile",
                     bam = "samtools_index/idx",
                     count = list(valueFrom = "$(inputs.bam.nameroot).featureCounts.txt")))
## rnaseqc
#' @include tl_collapse_annotation.R
s6a <- cwlStep(id = "collapse_annotation", run = collapse_annotation,
               In = list(gtf = "in_GTFfile",
                         out = list(valueFrom = "collapse_annotation.gtf")))
#' @include tl_rnaseqc.R
s6b <- cwlStep(id = "rnaseqc", run = rnaseqc,
               In = list(gtf = "collapse_annotation/gtfout",
                         bam = "sortBam/sbam"))

## TPM
#' @include tl_TPMCalculator.R
s7 <- cwlStep(id = "tpm", run = TPMCalculator,
              In = list(bam = "samtools_index/idx",
                        gtf = "in_GTFfile"))


## pipeline
rnaseq <- rnaseq + s1 + s2 + s3a + s3 + s4 + s5 + s6a + s6b + s7
