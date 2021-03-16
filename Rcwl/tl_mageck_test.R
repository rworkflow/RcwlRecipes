p1 <- InputParam(id = "countTable", type = "File", prefix = "-k")
p2 <- InputParam(id = "treat", type = "string[]",
                 prefix = "-t", itemSeparator = ",")
p3 <- InputParam(id = "control", type = "string[]",
                 prefix = "-c", itemSeparator = ",")
p4 <- InputParam(id = "prefix", type = "string, prefix = "-n"")
p5 <- InputParam(id = "conSGRNA", type = "File?", prefix = "--control-sgrna")
o1 <- OutputParam(id = "touts", type = "File[]", glob = "$(inputs.prefix)*")

req1 <- requireDocker("quay.io/biocontainers/mageck:0.5.9.4--py38hed8969a_0")
mageck_test <- cwlProcess(baseCommand = c("mageck", "test"),
                          requirements = list(req1),
                          inputs = InputParamList(p1, p2, p3, p4, p5),
                          outputs = OutputParamList(o1))
