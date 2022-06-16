p1 <- InputParam(id = "sam", type = "File", prefix = "-i")
o1 <- OutputParam(id = "splitReads", type = "File", glob = "$(inputs.sam.nameroot).splitReads.sam")
req1 <- requireDocker("quay.io/biocontainers/lumpy-sv:0.3.1--hdfd78af_3")
lumpy_extractSplitReads_BwaMem <- cwlProcess(baseCommand = "extractSplitReads_BwaMem",
                                             requirements = list(req1),
                                             inputs = InputParamList(p1),
                                             outputs = OutputParamList(o1),
                                             stdout = "$(inputs.sam.nameroot).splitReads.sam")
