p1 <- InputParam(id = "seg", type = "File", prefix = "-seg")
p2 <- InputParam(id = "refgene", type = "File", prefix = "-refgene")
p3 <- InputParam(id = "markers", type = "File?", prefix = "-mk")
p4 <- InputParam(id = "rx", type = "int?", prefix = "-rx")
p5 <- InputParam(id = "genegistic", type = "int?", prefix = "-genegistic")
p6 <- InputParam(id = "savegene", type = "int?", prefix = "-savegene")
p7 <- InputParam(id = "tamp", type = "float?", prefix = "-ta")
p8 <- InputParam(id = "tdel", type = "float?", prefix = "-td")
p9 <- InputParam(id = "gcm", type = "string?", prefix = "-gcm")
p10 <- InputParam(id = "brlen", type = "float?", prefix = "-brlen")
p11 <- InputParam(id = "conf", type = "float?", prefix = "-conf")
o1 <- OutputParam(id = "outs", type = "File[]", glob = "*")

req1 <- requireDocker("hubentu/gistic2")
gistic2 <- cwlProcess(baseCommand = "gistic2",
                      requirements = list(req1),
                      arguments = list("-b", "./"),
                      inputs = InputParamList(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11),
                      outputs = OutputParamList(o1))
