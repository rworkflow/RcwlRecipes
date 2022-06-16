## https://github.com/arq5x/lumpy-sv
p1 <- InputParam(id = "bam", type = "File[]", prefix = "-B", itemSeparator = ",", secondaryFiles = ".bai")
p2 <- InputParam(id = "split", type = "File[]", prefix = "-S", itemSeparator = ",", secondaryFiles = ".bai")
p3 <- InputParam(id = "discord", type = "File[]", prefix = "-D", itemSeparator = ",", secondaryFiles = ".bai")
p4 <- InputParam(id = "vout", type = "string", prefix = "-o")
o1 <- OutputParam(id = "vcf", type = "File", glob = "$(inputs.vout)")
req1 <- requireDocker("quay.io/biocontainers/lumpy-sv:0.3.1--hdfd78af_3")
lumpy <- cwlProcess(baseCommand = "lumpyexpress",
                    requirements = list(req1),
                    inputs = InputParamList(p1, p2, p3, p4),
                    outputs = OutputParamList(o1))
