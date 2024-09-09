p1 <- InputParam(id = "dbam", type = "File", position=1, secondaryFile=".bai")
p2 <- InputParam(id = "gbam", type = "File", position=2, secondaryFile=".bai")
p3 <- InputParam(id = "out", type = "string", position=3)
p4 <- InputParam(id = "ref", type = "File", position=4, secondaryFile=".fai")
o1 <- OutputParam(id = "vout", type = "File", glob = "$(inputs.out)")

req1 <- requireDocker("hubentu/bambino")
bambino <- cwlProcess(baseCommand = "/opt/run.sh",
                      requirements = list(req1),
                      inputs = InputParamList(p1, p2, p3, p4),
                      outputs = OutputParamList(o1))


bambino <- addMeta(
    bambino,
    label = "bambino",
    doc = "NA",
    inputLabels = c("dbam","gbam","out","ref"),
    inputDocs = c("NA","NA","NA","NA"),
    outputLabels = c("vout"),
    outputDocs = c("NA"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "NA",
        example = paste()
    )
)
