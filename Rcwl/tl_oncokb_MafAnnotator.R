p1 <- InputParam(id = "input", type = "File", prefix = "-i")
p2 <- InputParam(id = "output", type = "string", prefix = "-o")
p3 <- InputParam(id = "clinic", type = "File?", prefix = "-c")
p4 <- InputParam(id = "token", type = "string", prefix = "-b")
o1 <- OutputParam(id = "ofile", type = "File", glob = "$(inputs.output)")
req1 <- requireDocker("hubentu/oncokb-annotator")
oncokb_MafAnnotator <- cwlProcess(baseCommand = c("python", "/opt/MafAnnotator.py"),
                                  requirements = list(req1),
                                  inputs = InputParamList(p1, p2, p3, p4),
                                  outputs = OutputParamList(o1))


oncokb_MafAnnotator <- addMeta(
    oncokb_MafAnnotator,
    label = "oncokb_MafAnnotator",
    doc = "Annotate somatic mutations in a MAF file with relevant clinical information from OncoKB.",
    inputLabels = c("input","output","clinic","token"),
    inputDocs = c("input MAF file","output MAF file","input clinical file","oncokb api bear token"),
    outputLabels = c("ofile"),
    outputDocs = c("Output file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/oncokb/oncokb-annotator",
        example = paste()
    )
)
