p1 <- InputParam(id = "method", type = "string", prefix = "-m")
p2 <- InputParam(id = "iox", type = "File", prefix = "-i")
p3 <- InputParam(id = "psi", type = "File[]", prefix = "-p")
p4 <- InputParam(id = "exp", type = "File[]", prefix = "-e")
p5 <- InputParam(id = "output", type = "string", prefix = "-o")
p6 <- InputParam(id = "gc", type = "boolean", prefix = "-gc", default = TRUE)
p7 <- InputParam(id = "paired", type = "boolean", prefix = "-pa", default = FALSE)
o1 <- OutputParam(id = "outFile", type = "File[]", glob = "$(inputs.output)*")
req1 <- list(class = "DockerRequirement",
             dockerPull = "hubentu/suppa")
SUPPA_diffSplice <-
    cwlProcess(baseCommand = c("python", "/opt/SUPPA/suppa.py", "diffSplice"),
             requirements = list(req1),
             inputs = InputParamList(p1, p2, p3, p4, p5, p6, p7),
             outputs = OutputParamList(o1))

