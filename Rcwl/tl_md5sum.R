p1 <- InputParam(id = "file", type = "File")
o1 <- OutputParam(id = "md5", type = "File", glob = "$(inputs.file.basename).md5")
md5sum <- cwlProcess(baseCommand = "md5sum",
                     inputs = InputParamList(p1),
                     outputs = OutputParamList(o1),
                     stdout = "$(inputs.file.basename).md5")
