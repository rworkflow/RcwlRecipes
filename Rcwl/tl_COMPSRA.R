## https://github.com/cougarlj/COMPSRA
p1 <- InputParam(id = "fq", type = "File", prefix = "-in")
p2 <- InputParam(id = "adapt", type = "string", prefix = "-ra")
p3 <- InputParam(id = "ref", type = "string", prefix = "-ref", default = "hg38")
p4 <- InputParam(id = "DB", type = "Directory", position = -1)
o1 <- OutputParam(id = "outdir", type = "Directory", glob = "$(inputs.fq.nameroot.split('.')[0])")
req1 <- requireDocker("hubentu/compsra")
req2 <- requireInitialWorkDir(listing =list(
                                  list(entry = "$(inputs.DB)",
                                       entryname = "$('bundle_v1/')")))
req3 <- requireJS()
COMPSRA <- cwlProcess(cwlVersion = "v1.2",
                      baseCommand = c("java", "-jar", "/opt/COMPSRA.jar"),
                      arguments = list("-qc", "-rb", "4", "-rh", "20", "-rt", "20", "-rr", "20", "-rlh", "8,17",
                                       "-aln", "-mt", "star", "-ann", "-ac", "1,2,3,4,5,6", "-out", "."),
                      requirements = list(req1, req2, req3),
                      inputs = InputParamList(p1, p2, p3, p4),
                      outputs = OutputParamList(o1))



COMPSRA <- addMeta(
    COMPSRA,
    label = "COMPSRA",
    doc = "A tool for identifying and quantifying small RNAs from small RNA sequencing data.",
    inputLabels = c("fq","adapt","ref","DB"),
    inputDocs = c("Annotation files for small RNAs,such as GFF3.","Remove adapters.","The version of reference genome","Database reference used"),
    outputLabels = c("outdir"),
    outputDocs = c("The directory of the output"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/cougarlj/COMPSRA",
        example = paste()
    )
)
