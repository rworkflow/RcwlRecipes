## CalculateContamination
p1 <- InputParam(id = "ttable", type = "File", prefix = "-I")
p2 <- InputParam(id = "ntable", type = "File", prefix = "-matched")
p3 <- InputParam(id = "cont", type = "string", prefix = "-O")
p4 <- InputParam(id = "seg", type = "string", prefix = "-segments")
o1 <- OutputParam(id = "Cout", type = "File", glob = "$(inputs.cont)")
o2 <- OutputParam(id = "Seg", type = "File", glob = "$(inputs.seg)")
req1 <- requireDocker("broadinstitute/gatk:latest")
CalculateContamination <- cwlProcess(baseCommand = c("gatk", "CalculateContamination"),
                                   requirements = list(req1),
                                   inputs = InputParamList(p1, p2, p3, p4),
                                   outputs = OutputParamList(o1, o2))


CalculateContamination <- addMeta(
    CalculateContamination,
    label = "CalculateContamination",
    doc = "Calculate the fraction of reads coming from cross-sample contamination",
    inputLabels = c("ttable","ntable","cont","seg"),
    inputDocs = c("The input table Required.","The matched normal input table Default value: null.","The output table Required.","The output table containing segmentation of the tumor by minor allele fraction Default value: null."),
    outputLabels = c("Cout","Seg"),
    outputDocs = c("Contamination table","segmentation based on baf"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/broadinstitute/gatk",
        example = paste()
    )
)
