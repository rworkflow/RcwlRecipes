p1 <- InputParam(id = "input", type = "File", prefix = "-i")
p2 <- InputParam(id = "output", type = "string", prefix = "-o")
p3 <- InputParam(id = "clinic", type = "File?", prefix = "-c")
p4 <- InputParam(id = "token", type = "string", prefix = "-b")
o1 <- OutputParam(id = "ofile", type = "File", glob = "$(inputs.output)")
req1 <- requireDocker("hubentu/oncokb-annotator")
oncokb_MafAnnotator <- cwlProcess(baseCommand = c("python", "/opt/MafAnnotator.py"),
                                  requirements = list(req1),
                                  inputs = InputParamList(p1, p2, p3, p4),
                                  outputs = OutputParamList(o1))
