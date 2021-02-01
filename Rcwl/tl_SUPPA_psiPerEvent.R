p1 <- InputParam(id = "ioe", type = "File", prefix = "-i")
p2 <- InputParam(id = "exp", type = "File", prefix = "-e")
p3 <- InputParam(id = "outfile", type = "string", prefix = "-o")
o1 <- OutputParam(id = "outFile", type = "File[]", glob = "$(inputs.outfile).psi")
req1 <- list(class = "DockerRequirement",
             dockerPull = "hubentu/suppa")
SUPPA_psiPerEvent <-
    cwlProcess(baseCommand = c("python", "/opt/SUPPA/suppa.py", "psiPerEvent"),
             requirements = list(req1),
             inputs = InputParamList(p1, p2, p3),
             outputs = OutputParamList(o1))
