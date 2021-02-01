
p1 <- InputParam(id = "bam", type = "File",
                 prefix = "-b", secondaryFiles = ".bai")
p2 <- InputParam(id = "outFile", type = "string", prefix = "-o")
p3 <- InputParam(id = "binsize", type = "int",
                 prefix = "-bs", default = 1L)
p4 <- InputParam(id = "processors", type = "string",
                 prefix = "-p", default = "max")
p5 <- InputParam(id = "outFormat", type = "string",
                 prefix = "--outFileFormat", default = "bigwig")
o1 <- OutputParam(id = "bigwig", type = "File", glob = "$(inputs.bw)")
req1 <- list(class = "DockerRequirement",
             dockerPull = "quay.io/biocontainers/deeptools:3.4.3--py_0")
bamCoverage <- cwlProcess(baseCommand = "bamCoverage",
                        requirements = list(req1),
                        arguments = list("--ignoreDuplicates",
                                         "--skipNonCoveredRegions"),
                        inputs = InputParamList(p1, p2, p3, p4, p5),
                        outputs = OutputParamList(o1))
