p1 <- InputParam(id = "genome", type = "Directory", prefix = "--genome")
p2 <- InputParam(id = "fq1", type = "File", prefix = "-1")
p3 <- InputParam(id = "fq2", type = "File", prefix = "-2")
p4 <- InputParam(id = "sam", type = "boolean?", prefix = "--sam")
o1 <- OutputParam(id = "align", type = "File", glob = "*_bismark_bt2_pe.*")
o2 <- OutputParam(id = "report", type = "File", glob = "*_report.txt")
req1 <- requireDocker("quay.io/biocontainers/bismark:0.23.1--hdfd78af_0")
bismark <- cwlProcess(baseCommand = "bismark",
                      arguments = list("-o", "./"),
                      requirements = list(req1),
                      inputs = InputParamList(p1, p2, p3, p4),
                      outputs = OutputParamList(o1, o2))
