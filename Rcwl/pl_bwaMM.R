## bwaAlign + mergeBamDup
#' @include pl_bwaAlign.R pl_mergeBamDup.R pl_BaseRecal.R
p1 <- InputParam(id = "outBam", type = "string")
p2 <- InputParam(id = "RG", type = "string[]")
p3 <- InputParam(id = "threads", type = "int")
p4 <- InputParam(id = "Ref", type = "File",
                 secondaryFiles = c(".amb", ".ann", ".bwt", ".pac",
                                    ".sa", ".fai",
                                    "$(self.nameroot).dict"))
p5 <- InputParam(id = "FQ1s", type = "File[]")
p6 <- InputParam(id = "FQ2s", type = "File[]")
## p7 <- InputParam(id = "knowSites", type = InputArrayParam(items = "File"),
##                  secondaryFiles = "$(self.nameext == '.gz' ? self.basename+'.tbi' : self.basename+'.idx')")

## o1 <- OutputParam(id = "BAM", type = "File", outputSource = "BaseRecal/rcBam")
o1 <- OutputParam(id = "matrix", type = "File", outputSource = "mergeBamDup/matrix")
o2 <- OutputParam(id = "Idx", type = "File", outputSource = "mergeBamDup/Idx")
o3 <- OutputParam(id = "flagstat", type = "File", outputSource = "mergeBamDup/stat")
# o4 <- OutputParam(id = "stats", type = "File", outputSource = "BaseRecal/stats")

s1 <- cwlStep(id = "bwaAlign", run = bwaAlign,
           In = list(threads = "threads",
                     RG = "RG",
                     Ref = "Ref",
                     FQ1 = "FQ1s",
                     FQ2 = "FQ2s"),
           scatter = list("RG", "FQ1", "FQ2"),
           scatterMethod = "dotproduct")

s2 <- cwlStep(id = "mergeBamDup", run = mergeBamDup,
           In = list(ibam = "bwaAlign/Bam",
                     obam = "outBam"))


req1 <- list(class = "SubworkflowFeatureRequirement")
req2 <- list(class = "ScatterFeatureRequirement")
req3 <- requireJS()
bwaMM <- cwlWorkflow(requirements = list(req1, req2, req3),
                    inputs = InputParamList(p1, p2, p3, p4, p5, p6),
                    outputs = OutputParamList(o1, o2, o3))

bwaMM <- bwaMM + s1 + s2
