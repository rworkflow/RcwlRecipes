p1 <- InputParam(id = "files", type = "File[]")
p2 <- InputParam(id = "sep", type = "string?", prefix = "-d")
p3 <- InputParam(id = "outfile", type = "string", position = -1L, default = "paste.txt")
o1 <- OutputParam(id = "out", type = "File", glob = "$(inputs.outfile)")
fpaste <- cwlProcess(baseCommand = "paste",
                     inputs = InputParamList(p1, p2, p3),
                     outputs = OutputParamList(o1),
                     stdout = "$(inputs.outfile)")
