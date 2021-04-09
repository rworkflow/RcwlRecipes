p1 <- InputParam(id = "sth", type = "string")
p2 <- InputParam(id = "escape", type = "boolean?", prefix = "-e")
p3 <- InputParam(id = "outfile", type = "string", position = -1L, default = "echo.txt")
o1 <- OutputParam(id = "out", type = "File", glob = "$(inputs.outfile)")
echo <- cwlProcess(baseCommand = "echo",
                   inputs = InputParamList(p1, p2, p3),
                   outputs = OutputParamList(o1),
                   stdout = "$(inputs.outfile)")
