p1 <- InputParam(id = "infiles", type = "File[]")
p2 <- InputParam(id = "outfile", type = "string", default = "catout.txt", position = -1)
Cat <- cwlParam(baseCommand = "cat", inputs = InputParamList(p1, p2), stdout = "$(inputs.outfile)")
