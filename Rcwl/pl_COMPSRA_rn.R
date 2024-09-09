#' @include tl_cp.R tl_COMPSRA.R
p0 <- InputParam(id = "samplefq", type = "string")
p1 <- InputParam(id = "fq", type = "File")
p2 <- InputParam(id = "adapt", type = "string")
p3 <- InputParam(id = "ref", type = "string")
p4 <- InputParam(id = "DB", type = "Directory")

s1 <- cwlStep(id = "copy", run = cp,
              In = list(file1 = "fq",
                        file2 = "samplefq"))
s2 <- cwlStep(id = "compsra", run = COMPSRA,
              In = list(fq = "copy/cpfile",
                        adapt = "adapt",
                        ref = "ref",
                        DB = "DB"))
o1 <- OutputParam(id = "out", type = "Directory", outputSource = "compsra/outdir")
COMPSRA_rn <- cwlWorkflow(inputs = InputParamList(p0, p1, p2, p3, p4),
                          outputs = OutputParamList(o1))
COMPSRA_rn <- COMPSRA_rn + s1 + s2
