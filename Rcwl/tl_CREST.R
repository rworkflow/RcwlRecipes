#' https://github.com/hubentu/CREST
p1 <- InputParam(id = "tbam", type = "File", position = 1L, secondaryFiles = ".bai")
p2 <- InputParam(id = "gbam", type = "File", position = 2L, secondaryFiles = ".bai")
p3 <- InputParam(id = "ref", type = "File", position = 3L, secondaryFiles = ".fai")
p4 <- InputParam(id = "bit", type = "File", position = 4L)
p5 <- InputParam(id = "host", type = "string", default = "localhost", position = 5L)
p6 <- InputParam(id = "port", type = "int", default = 2345L, position = 6L)
o1 <- OutputParam(id = "predSV", type = "File", glob = "$(inputs.tbam.basename).predSV.txt")
CREST <- cwlProcess(baseCommand = "/opt/CREST/CREST.sh",
                  requirements = list(requireDocker("hubentu/crest")),
                  inputs = InputParamList(p1, p2, p3, p4, p5, p6),
                  outputs = OutputParamList(o1))

