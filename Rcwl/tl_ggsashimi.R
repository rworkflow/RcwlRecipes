## https://github.com/guigolab/ggsashimi
p1 <- InputParam(id = "tsv", type = "File", prefix = "-b")
p2 <- InputParam(id = "bamDir", type = "Directory", position = -1,
                  doc = "The bam files in the input tsv should be relative to this directory")
p3 <- InputParam(id = "coord", type = "string", prefix = "-c")
p4 <- InputParam(id = "gtf", type = "File", prefix = "-g")
p5 <- InputParam(id = "Cfactor", type = "int?", prefix = "-C")
p6 <- InputParam(id = "overlay", type = "int?", prefix = "-O")
p7 <- InputParam(id = "oprefix", type = "string", prefix = "-o", default = "sashimi")
p8 <- InputParam(id = "alpha", type = "float", prefix = "--alpha", default = 0.25)
o1 <- OutputParam(id = "plot", type = "File", glob = "$(inputs.oprefix).pdf")

req1 <- requireDocker("guigolab/ggsashimi:1.0.0")
req2 <- requireInitialWorkDir(listing = list("$(inputs.bamDir)"))
ggsashimi <- cwlProcess(baseCommand = "",
                        requirements = list(req1, req2),
                        inputs = InputParamList(p1, p2, p3, p4, p5, p6, p7, p8),
                        outputs = OutputParamList(o1))
