p1 <- InputParam(id = "bam", type = "File[]", secondaryFiles = ".bai")

#' @include tl_samtools_view.R tl_samtools_index.R
## extractSplitReads_BwaMem
arguments(samtools_view) <- list("-h")
s1 <- cwlStep(id = "discord", run = samtools_view,
              In = list(bam = "bam",
                        outb = list(valueFrom = "$(true)"),
                        exFlag = list(valueFrom = "1294"),
                        obam = list(valueFrom = "$(inputs.bam.nameroot).discord.bam")),
              scatter = "bam")
#' @include tl_lumpy_extractSplitReads_BwaMem.R tl_lumpy.R
s2 <- cwlStep(id = "sam", run = samtools_view,
              In = list(bam = "bam",
                        obam = list(valueFrom = "$(inputs.bam.nameroot).sam")),
              scatter = "bam")
s3 <- cwlStep(id = "split", run = lumpy_extractSplitReads_BwaMem,
              In = list(sam = "sam/oBam"),
              scatter = "sam")
s4 <- cwlStep(id = "sam2bam", run = samtools_view,
              In = list(bam = "split/splitReads",
                        outb = list(valueFrom = "$(true)"),
                        obam = list(valueFrom = "$(inputs.bam.nameroot).bam")),
              scatter = "bam")

s5 <- cwlStep(id = "discord_idx", run = samtools_index,
              In = list(bam = "discord/oBam"),
              scatter = "bam")
s6 <- cwlStep(id = "split_idx", run = samtools_index,
              In = list(bam = "sam2bam/oBam"),
              scatter = "bam")

s7 <- cwlStep(id = "lumpy", run = lumpy,
              In = list(bam = "bam",
                        split = "split_idx/idx",
                        discord = "discord_idx/idx",
                        vout = list(valueFrom = "$(inputs.bam[0].nameroot).vcf")))


o1 <- OutputParam(id = "vcf", type = "File", outputSource = "lumpy/vcf")
req1 <- requireJS()
req2 <- requireStepInputExpression()
req3 <- list(class = "ScatterFeatureRequirement")
lumpyPL <- cwlWorkflow(requirements = list(req1, req2, req3),
                       inputs = InputParamList(p1),
                       outputs = OutputParamList(o1))
lumpyPL <- lumpyPL + s1 + s2 + s3 + s4 + s5 + s6 + s7
