#' @include tl_vcf2bed.R tl_samtools_view.R tl_samtools_index.R
p1 <- InputParam(id = "vcf", type = "File")
p2 <- InputParam(id = "bam", type = "File", secondaryFiles = ".bai")
s1 <- cwlStep(id = "vcf2bed", run = vcf2bed,
              In = list(vcf = "vcf",
                        out = list(valueFrom = "$(inputs.vcf.nameroot).bed")))
s2 <- cwlStep(id = "samtoolsview", run = samtools_view,
              In = list(bam = "bam",
                        bed = "vcf2bed/bed",
                        outb = list(valueFrom = "$(true)"),
                        obam = list(valueFrom = "$(inputs.bam.nameroot).mini.bam")))
s3 <- cwlStep(id = "samtoolsidx", run = samtools_index,
              In = list(bam = "samtoolsview/oBam"))
o1 <- OutputParam(id = "mBam", type = "File", outputSource = "samtoolsidx/idx")
req1 <- requireStepInputExpression()
req2 <- requireJS()
subBamByVcf <- cwlWorkflow(requirements = list(req1, req2),
                        inputs = InputParamList(p1, p2),
                        outputs = OutputParamList(o1))
subBamByVcf <- subBamByVcf + s1 + s2 + s3
