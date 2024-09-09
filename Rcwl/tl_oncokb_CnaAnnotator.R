p1 <- InputParam(id = "input", type = "File", prefix = "-i")
p2 <- InputParam(id = "output", type = "string", prefix = "-o")
p3 <- InputParam(id = "clinic", type = "File?", prefix = "-c")
p4 <- InputParam(id = "token", type = "string", prefix = "-b")
o1 <- OutputParam(id = "ofile", type = "File", glob = "$(inputs.output)")
req1 <- requireDocker("hubentu/oncokb-annotator")
oncokb_CnaAnnotator <- cwlProcess(
    baseCommand = c("python", "/opt/CnaAnnotator.py"),
    requirements = list(req1),
    inputs = InputParamList(p1, p2, p3, p4),
    outputs = OutputParamList(o1))


oncokb_CnaAnnotator <- addMeta(
    oncokb_CnaAnnotator,
    label = "oncokb_CnaAnnotator",
    doc = "Annotate CNAs (such as gene amplifications or deletions) detected in cancer samples with information from the OncoKB knowledge base.",
    inputLabels = c("input","output","clinic","token"),
    inputDocs = c("Input CNS file","Output CNA file","Input Clinical file","oncokb_api_bear_token"),
    outputLabels = c("ofile"),
    outputDocs = c("Annotated output file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/oncokb/oncokb-annotator",
        example = paste()
    )
)
