## https://github.com/nugentechnologies/NuMetRRBS

p1 <- InputParam(id = "fq1", type = "File")
p2 <- InputParam(id = "fq2", type = "File?")
p3 <- InputParam(id = "fq3", type = "File")
p4 <- InputParam(id = "sample", type = "string")
p5 <- InputParam(id = "genome", type = "Directory")
p6 <- InputParam(id = "threads", type = "int")
#' @include tl_trim_galore.R
s1 <- cwlStep(id = "trim", run = trim_galore,
              In = list(fq1 = "fq1",
                        fq2 = "fq2"))
#' @include tl_trimRRBSdiversity.R
s2 <- cwlStep(id = "trimDiversity", run = trimRRBSdiversity,
              In = list(fq1 = "trim/FQ1",
                        fq2 = "trim/FQ2"))
#' @include tl_bismark.R
s3 <- cwlStep(id = "bismark", run = bismark,
              In = list(genome = "genome",
                        fq1 = "trimDiversity/FQ1",
                        fq2 = "trimDiversity/FQ2",
                        sam = list(valueFrom = "$(true)")))
#' @include tl_strip_sam.R
s4 <- cwlStep(id = "stripSam", run = strip_sam,
              In = list(sam = "bismark/align"))
#' @include tl_nudup.R
s5 <- cwlStep(id = "nudup", run = nudup,
              In = list(index = "fq3",
                        paired = list(valueFrom = "$(true)"),
                        out = "sample",
                        sam = "stripSam/strip"))
#' @include tl_samtools_sort.R
arguments(samtools_sort) <- list("-n")
s6 <- cwlStep(id = "resort", run = samtools_sort,
              In = list(bam = "nudup/dbam",
                        obam = list(valueFrom = "$(inputs.bam.nameroot)_nsort.bam")))
#' @include tl_bismark_methylation_extractor.R
s7 <- cwlStep(id = "extractor", run = bismark_methylation_extractor,
              In = list(paired = list(valueFrom = "$(true)"),
                        core = "threads",
                        bam = "resort/sbam"))
o1 <- OutputParam(id = "mbam", type = "File", outputSource = "nudup/mbam")
o2 <- OutputParam(id = "nbam", type = "File", outputSource = "resort/sbam")
o3 <- OutputParam(id = "cov", type = "File", outputSource = "extractor/cov")
o4 <- OutputParam(id = "Bed", type = "File?", outputSource = "extractor/Bed")
o5 <- OutputParam(id = "report", type = "File[]", outputSource = "extractor/report")
req1 <- requireJS()
req2 <- requireStepInputExpression()
rrbs <- cwlWorkflow(requirements = list(req1, req2),
                    inputs = InputParamList(p1, p2, p3, p4, p5, p6),
                    outputs = OutputParamList(o1, o2, o3, o4, o5))
rrbs <- rrbs + s1 + s2 + s3 + s4 + s5 + s6 + s7
