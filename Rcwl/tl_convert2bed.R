## bedops convert2bed
p1 <- InputParam(id = "infmt", type = "string", prefix = "--input=", separate = FALSE)
p2 <- InputParam(id = "infile", type = "File", position = -1L)
p3 <- InputParam(id = "outbed", type = "string", position = -1L)
o1 <- OutputParam(id = "outBed", type = "File", glob = "$(inputs.outbed)")

req1 <- requireDocker("quay.io/biocontainers/bedops:2.4.39--h7d875b9_1")
convert2bed <- cwlProcess(baseCommand = "convert2bed",
                          requirements = list(req1),
                          inputs = InputParamList(p1, p2, p3),
                          outputs = OutputParamList(o1),
                          stdin = "$(inputs.infile.path)",
                          stdout = "$(inputs.outbed)")
