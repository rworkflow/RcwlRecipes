#' @include tl_bam2seqz.R tl_seqz_binning.R tl_scar_HRD.R
p1 <- InputParam(id = "normal", type = "File", secondaryFiles = ".bai")
p2 <- InputParam(id = "tumor", type = "File", secondaryFiles = ".bai")
p3 <- InputParam(id = "ref", type = "File", secondaryFiles = ".fai")
p4 <- InputParam(id = "gc", type = "File")
p5 <- InputParam(id = "out", type = "string")
p6 <- InputParam(id = "window", type = "int", default = 50L)
p7 <- InputParam(id = "build", type = "string", default = "grch37")
s1 <- cwlStep(id = "bam2seqz", run = bam2seqz,
              In = list(normal = "normal",
                        tumor = "tumor",
                        ref = "ref",
                        gc = "gc",
                        out = "out"))
s2 <- cwlStep(id = "seqz_binning", run = seqz_binning,
              In = list(seqz = "bam2seqz/seqz",
                        window = "window",
                        out = "out"))
s3 <- cwlStep(id = "hrd", run = scar_HRD,
              In = list(seg = "seqz_binning/seqzs",
                        reference = "build"))
o1 <- OutputParam(id = "segs", type = "File", outputSource = "seqz_binning/seqzs")
o2 <- OutputParam(id = "score", type = "File", outputSource = "hrd/HRD")
ScarHRD <- cwlWorkflow(inputs = InputParamList(p1, p2 , p3, p4, p5, p6, p7),
                       outputs = OutputParamList(o1, o2))
ScarHRD <- ScarHRD + s1 + s2 + s3
