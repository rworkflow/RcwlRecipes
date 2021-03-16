## https://sourceforge.net/p/mageck/wiki/Home/
p1 <- InputParam(id = "library", type = "File", prefix = "-l")
p2 <- InputParam(id = "fastq", type = "File[]", prefix = "--fastq")
p3 <- InputParam(id = "samples", type = "string[]?",
                 itemSeparator = ",", prefix = "--sample-label")
p4 <- InputParam(id = "prefix", type = "string", prefix = "-n")
p5 <- InputParam(id = "conSGRNA", type = "File?", prefix = "--control-sgrna")
o1 <- OutputParam(id = "counts", type = "File[]",
                  glob = "$(inputs.prefix)*")

req1 <- requireDocker("quay.io/biocontainers/mageck:0.5.9.4--py38hed8969a_0")
mageck_count <- cwlProcess(baseCommand = c("mageck", "count"),
                           requirements = list(req1),
                           inputs = InputParamList(p1, p2, p3, p4, p5),
                           outputs = OutputParamList(o1))
