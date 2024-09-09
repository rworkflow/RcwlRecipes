p1 <- InputParam(id = "input", type = "File", prefix = "-i")
p2 <- InputParam(id = "output", type = "string", prefix = "-o")
p3 <- InputParam(id = "clinic", type = "File?", prefix = "-c")
p4 <- InputParam(id = "token", type = "string", prefix = "-b")
o1 <- OutputParam(id = "ofile", type = "File", glob = "$(inputs.output)")
req1 <- requireDocker("hubentu/oncokb-annotator")
oncokb_FusionAnnotator <- cwlProcess(baseCommand = c("python", "/opt/FusionAnnotator.py"),
                                     requirements = list(req1),
                                     inputs = InputParamList(p1, p2, p3, p4),
                                     outputs = OutputParamList(o1))


oncokb_FusionAnnotator <- addMeta(
    oncokb_FusionAnnotator,
    label = "oncokb_FusionAnnotator",
    doc = "Annotate gene fusions identified in cancer samples with relevant clinical information from OncoKB.",
    inputLabels = c("input","output","clinic","token"),
    inputDocs = c("input Fusion file","output Fusion file","input clinical file","oncokb api bear token"),
    outputLabels = c("ofile"),
    outputDocs = c("Output annotaated file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/oncokb/oncokb-annotator",
        example = paste()
    )
)
