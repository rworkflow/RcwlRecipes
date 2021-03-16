p1 <- InputParam(id = "geneRank", type = "File", prefix = "--gene-ranking")
p2 <- InputParam(id = "gmt", type = "File", prefix = "--gmt-file")
p3 <- InputParam(id = "prefix", type = "string", prefix = "-n")
o1 <- OutputParam(id = "pouts", type = "File[]", glob = "$(inputs.prefix)*")

req1 <- requireDocker("quay.io/biocontainers/mageck:0.5.9.4--py38hed8969a_0")
mageck_pathway <- cwlProcess(baseCommand = c("mageck", "pathway"),
                             requirements = list(req1),
                             inputs = InputParamList(p1, p2, p3),
                             outputs = OutputParamList(o1))
