#' @include tl_vcf2bed.R tl_samtools_view.R tl_samtools_index.R
p1 <- InputParam(id = "vcf", type = "File")
p2 <- InputParam(id = "fai", type = "File")
p3 <- InputParam(id = "win", type = "int")
p4 <- InputParam(id = "bam", type = "File")
s1 <- cwlStep(id = "vcf2bed", run = vcf2bed,
              In = list(vcf = "vcf",
                        fai = "fai",
                        win = "win"))
s2 <- cwlStep(id = "subBam", run = samtools_view,
              In = list(bam = "bam",
                        bed = "vcf2bed/bed",
                        outb = list(valueFrom = "$(true)"),
                        obam = list(valueFrom = "$(inputs.bam.nameroot).sub.bam")))
s3 <- cwlStep(id = "idxBam", run = samtools_index,
              In = list(bam = "subBam/oBam"))
o1 <- OutputParam(id = "outBam", type = "File",
                  outputSource = "idxBam/idx", secondaryFiles = ".bai")
req1 <- requireStepInputExpression()
req2 <- requireJS()
vcfSubBam <- cwlWorkflow(requirements = list(req1, req2),
                         inputs = InputParamList(p1, p2, p3, p4),
                         outputs = OutputParamList(o1))
vcfSubBam <- vcfSubBam + s1 + s2 + s3
