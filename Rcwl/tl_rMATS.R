
p1 <- InputParam(id = "bam1", type = "File[]", itemSeparator = ",", position = 1)
p2 <- InputParam(id = "bam2", type = "File[]", itemSeparator = ",", position = 2)
p3 <- InputParam(id = "type", type = "string", position = 3, default = "paired")
p4 <- InputParam(id = "readLength", type = "int", position = 4)
p5 <- InputParam(id = "gtf", type = "File", position = 5)
p6 <- InputParam(id = "od", type = "string?", position = 6, default = "./")
p7 <- InputParam(id = "threads", type = "int", position = 7, default = 4L)
p8 <- InputParam(id = "tstat", type = "int?", position = 8, default = 4L)
o1 <- OutputParam(id = "res", type = "File[]", glob = "*.txt")
req1 <- list(class = "DockerRequirement",
             dockerPull = "hubentu/rmats")
rMATS <- cwlProcess(baseCommand = "rmats_bam.sh",
                  requirements = list(req1),
                  inputs = InputParamList(p1, p2, p3, p4, p5, p6, p7, p8),
                  outputs = OutputParamList(o1))
