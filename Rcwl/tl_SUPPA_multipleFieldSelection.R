p1 <- InputParam(id = "inputFiles", type = "File[]", prefix = "-i")
p2 <- InputParam(id = "key", type = "int", prefix = "-k")
p3 <- InputParam(id = "field", type = "int", prefix = "-f")
p4 <- InputParam(id = "outfile", type = "string", prefix = "-o")
p5 <- InputParam(id = "noheader", type = "boolean?")
o1 <- OutputParam(id = "outFile", type = "File", glob = "$(inputs.outfile)")
req1 <- list(class = "DockerRequirement",
             dockerPull = "hubentu/suppa")
SUPPA_multipleFieldSelection <-
    cwlParam(baseCommand = c("python", "/opt/SUPPA-2.3/multipleFieldSelection.py"),
             requirements = list(req1),
             inputs = InputParamList(p1, p2, p3, p4, p5),
             outputs = OutputParamList(o1))
