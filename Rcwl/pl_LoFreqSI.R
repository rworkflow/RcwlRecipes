## LoFreq PL
#' @include pl_lofreq_indel.R tl_LoFreq.R
p1 <- InputParam(id = "tbam", type = "File", secondaryFiles = ".bai")
p2 <- InputParam(id = "nbam", type = "File", secondaryFiles = ".bai")
p3 <- InputParam(id = "ref", type = "File", secondaryFiles = ".fai")
p4 <- InputParam(id = "region", type = "File")
p5 <- InputParam(id = "dbsnp", type = "File",
                 secondaryFiles = "$(self.nameext == '.gz' ? self.basename+'.tbi' : self.basename+'.idx')")
p6 <- InputParam(id = "out", type = "string")
p7 <- InputParam(id = "threads", type = "int")

s1 <- cwlStep(id = "tbamR", run = lofreq_indel,
              In = list(ref = "ref",
                        bam = "tbam"))
s2 <- cwlStep(id = "nbamR", run = lofreq_indel,
              In = list(ref = "ref",
                        bam = "nbam"))
s3 <- cwlStep(id = "lofreqCall", run = LoFreq,
              In = list(tbam = "tbamR/ibam",
                        nbam = "nbamR/ibam",
                        ref = "ref",
                        region = "region",
                        dbsnp = "dbsnp",
                        out = "out",
                        threads = "threads"))
o1 <- OutputParam(id = "snp", type = "File", outputSource = "lofreqCall/snp")
o2 <- OutputParam(id = "snpdb", type = "File", outputSource = "lofreqCall/snpdb")
o3 <- OutputParam(id = "indel", type = "File", outputSource = "lofreqCall/indel")
o4 <- OutputParam(id = "indeldb", type = "File", outputSource = "lofreqCall/indeldb")

LoFreqSI <- cwlWorkflow(requirements = list(requireSubworkflow()),
                        inputs = InputParamList(p1, p2, p3, p4, p5, p6, p7),
                        outputs = OutputParamList(o1, o2, o3, o4))
LoFreqSI <- LoFreqSI + s1 + s2 + s3
