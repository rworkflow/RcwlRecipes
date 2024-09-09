
p1a <- InputParam(id = "in_fq1", type = "File")
p1b <- InputParam(id = "in_fq2", type = "File")
p2 <- InputParam(id = "in_prefix", type = "string")
p3 <- InputParam(id = "in_genomeDir", type = "Directory")
p4 <- InputParam(id = "in_GTFfile", type = "File")
p5 <- InputParam(id = "in_runThreadN", type = "int", default = 1L)
p6 <- InputParam(id = "salmon_index", type = "Directory")

#' @include tl_STAR_FFPE.R
# arguments(STAR)[[9]] <- "Unsorted"
s1 <- cwlStep(id = "STAR", run = STAR_FFPE,
              In = list(prefix = list(source = "in_prefix",
                                      valueFrom = "$(self)_"),
                        genomeDir = "in_genomeDir",
                        sjdbGTFfile = "in_GTFfile",
                        readFilesIn = list(source = list("in_fq1", "in_fq2"),
                                           linkMerge = "merge_flattened"),
                        runThreadN = "in_runThreadN"))

## samtools sort for lower memory requirement
#' @include tl_sortBam.R tl_samtools_index.R tl_samtools_flagstat.R
s2 <- cwlStep(id = "sortBam", run = sortBam,
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
## RSeQC
#' @include tl_gtfToGenePred.R tl_genePredToBed.R tl_read_distribution.R
s6a <- cwlStep(id = "gtfToGenePred", run = gtfToGenePred,
               In = list(gtf = "in_GTFfile",
                      gPred = list(valueFrom = "$(inputs.gtf.nameroot).genePred")))

s6b <- cwlStep(id = "genePredToBed", run = genePredToBed,
            In = list(genePred = "gtfToGenePred/genePred",
                      Bed = list(valueFrom = "$(inputs.genePred.nameroot).bed")))

s6c <- cwlStep(id = "r_distribution", run = read_distribution,
            In = list(bam = "samtools_index/idx",
                      bed = "genePredToBed/bed"))

## salmon
#' @include tl_salmon_quant.R
s7 <- cwlStep(id = "salmon", run = salmon_quant,
              In = list(threadN = "in_runThreadN",
                        ref = "salmon_index",
                        fq1 = "in_fq1",
                        fq2 = "in_fq2",
                        outPrefix = list(source = "in_prefix",
                                         valueFrom = "$(self)_salmon")))

o1 <- OutputParam(id = "out_BAM", type = "File", outputSource = "samtools_index/idx")
o2 <- OutputParam(id = "out_Log", type = "File", outputSource = "STAR/outLog")
o3 <- OutputParam(id = "out_Count", type = "File", outputSource = "STAR/outCount")
o3 <- OutputParam(id = "out_junction", type = "File", outputSource = "STAR/junction")
o4 <- OutputParam(id = "out_stat",type = "File", outputSource = "samtools_flagstat/flagstat")
o5 <- OutputParam(id = "out_count", type = "File", outputSource = "featureCounts/Count")
o6 <- OutputParam(id = "out_salmon", type = "Directory", outputSource = "salmon/out1")
o7 <- OutputParam(id = "out_rdist", type = "File", outputSource = "r_distribution/distOut")
req1 <- list(class = "MultipleInputFeatureRequirement")
req2 <- list(class = "InlineJavascriptRequirement")
req3 <- list(class = "StepInputExpressionRequirement")
rnaseq_quant <- cwlWorkflow(requirements = list(req1, req2, req3),
                            inputs = InputParamList(p1a, p1b, p2, p3, p4, p5, p6),
                            outputs = OutputParamList(o1, o2, o3, o4, o5, o6, o7))
rnaseq_quant <- rnaseq_quant + s1 + s2 + s3 + s4 + s5 + s6a + s6b + s6c + s7
