p1 <- InputParam(id = "gtf", type = "File", prefix = "-i")
p2 <- InputParam(id = "outfile", type = "string", prefix = "-o", default = "event")
p3 <- InputParam(id = "events", type = "string", prefix = "-e",
                 shellQuote = FALSE, default = "SE SS MX RI FL")
p4 <- InputParam(id = "format", type = "string", prefix = "-f",
                 default = "ioe")
o1 <- OutputParam(id = "outGTF", type = "File[]", glob = "$(inputs.outfile)_*_strict.gtf")
o2 <- OutputParam(id = "outIOE", type = "File[]", glob = "$(inputs.outfile)_*_strict.ioe")
req1 <- list(class = "DockerRequirement",
             dockerPull = "hubentu/suppa")
req2 <- list(class = "ShellCommandRequirement")
SUPPA_generateEvents <-
    cwlProcess(baseCommand = c("python", "/opt/SUPPA/suppa.py", "generateEvents"),
             requirements = list(req1, req2),
             inputs = InputParamList(p1, p2, p3, p4),
             outputs = OutputParamList(o1, o2))
