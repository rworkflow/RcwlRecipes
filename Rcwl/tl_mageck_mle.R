p1 <- InputParam(id = "countTable", type = "File", prefix = "-k")
p2 <- InputParam(id = "desgin", type = "File?", prefix = "-d")
p3 <- InputParam(id = "day0", type = "string?", prefix = "--day0-label")
p4 <- InputParam(id = "prefix", type = "string", prefix = "-n")
p5 <- InputParam(id = "conSGRNA", type = "File?", prefix = "--control-sgrna")
o1 <- OutputParam(id = "mout", type = "File[]", glob = "$(inputs.prefix)*")

req1 <- requireDocker("quay.io/biocontainers/mageck:0.5.9.4--py38hed8969a_0")
mageck_mle <- cwlProcess(baseCommand = c("mageck", "mle"),
                         requirements = list(req1),
                         inputs = InputParamList(p1, p2, p3, p4, p5),
                         outputs = OutputParamList(o1))
