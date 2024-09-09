##source(system.file("tools", "bwa.R", package = "RcwlPipelines"))
##source(system.file("tools", "samtools_samTobam.R", package = "RcwlPipelines"))
##source(system.file("tools", "samtools_sortBam.R", package = "RcwlPipelines"))
##source(system.file("tools", "samtools_index.R", package = "RcwlPipelines"))

## params
#' @include tl_bwa.R tl_sam2bam.R tl_samtools_sort.R tl_samtools_index.R
p1 <- InputParam(id = "threads", type = "int")
p2 <- InputParam(id = "RG", type = "string")
p3 <- InputParam(id = "Ref", type = "File",
                 secondaryFiles = c(".amb", ".ann", ".bwt", ".pac", ".sa"))
p4 <- InputParam(id = "FQ1", type = "File")
p5 <- InputParam(id = "FQ2", type = "File?")

## bwa
s1 <- cwlStep(id = "bwa", run = bwa,
           In = list(threads = "threads",
                     RG = "RG",
                     Ref = "Ref",
                     FQ1 = "FQ1",
                     FQ2 = "FQ2"))

## sam to bam
s2 <- cwlStep(id = "sam2bam", run = sam2bam,
              In = list(sam = "bwa/sam"))
                        ##bam = list(valueFrom = "$(inputs.sam.nameroot).bam")))

## sort bam
s3 <- cwlStep(id = "sortBam", run = samtools_sort,
              In = list(bam = "sam2bam/bam",
                        obam = list(valueFrom = "$(inputs.bam.nameroot)_sort.bam")))
## index bam
s4 <- cwlStep(id = "idxBam", run = samtools_index,
           In = list(bam = "sortBam/sbam"))

## outputs
o1 <- OutputParam(id = "Bam", type = "File", outputSource = "sortBam/sbam")
o2 <- OutputParam(id = "Idx", type = "File", outputSource = "idxBam/idx")

## stepParam
req1 <- requireStepInputExpression()
bwaAlign <- cwlWorkflow(requirements = list(req1),
                        inputs = InputParamList(p1, p2, p3, p4, p5),
                        outputs = OutputParamList(o1, o2))

## pipeline
bwaAlign <- bwaAlign + s1 + s2 + s3 + s4
