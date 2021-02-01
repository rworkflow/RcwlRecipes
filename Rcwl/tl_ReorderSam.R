## picard ReorderSam
p1 <- InputParam(id = "ibam", type = "File", prefix = "I=", separate = FALSE)
p2 <- InputParam(id = "obam", type = "string", prefix = "O=", separate = FALSE)
p3 <- InputParam(id = "dict", type = "File", prefix = "SD=", separate = FALSE)
o1 <- OutputParam(id = "rBam", type = "File", glob = "$(inputs.obam)")
req1 <- list(class = "DockerRequirement",
             dockerPull = "quay.io/biocontainers/picard:2.21.1--0")
ReorderSam <- cwlProcess(baseCommand = c("picard",
                                       "ReorderSam"),
                       requirements = list(req1),
                       inputs = InputParamList(p1, p2, p3),
                       outputs = OutputParamList(o1))
