p1 <- InputParam(id = "genome", type = "Directory", prefix = "--genome")
p2 <- InputParam(id = "fq1", type = list("File", "File[]"), prefix = "-1", itemSeparator=",")
p3 <- InputParam(id = "fq2", type = list("File", "File[]"), prefix = "-2", itemSeparator=",")
p4 <- InputParam(id = "sam", type = "boolean?", prefix = "--sam")
p5 <- InputParam(id = "threads", type = "int?", prefix = "-p")
o1 <- OutputParam(id = "align", type = "File", glob = "*_bismark_bt2_pe.*")
o2 <- OutputParam(id = "report", type = "File", glob = "*_report.txt")
req1 <- requireDocker("quay.io/biocontainers/bismark:0.23.1--hdfd78af_0")
bismark <- cwlProcess(cwlVersion = "v1.2",
                      baseCommand = "bismark",
                      arguments = list("-o", "./"),
                      requirements = list(req1),
                      inputs = InputParamList(p1, p2, p3, p4, p5),
                      outputs = OutputParamList(o1, o2))
