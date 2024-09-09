## gatk LearnReadOrientationModel -I f1r2.tar.gz -O read-orientation-model.tar.gz
p1 <- InputParam(id = "f1r2", type = "File", prefix = "-I")
p2 <- InputParam(id = "romodel", type = "string", prefix = "-O",
                 default = "read-orientation-model.tar.gz")
o1 <- OutputParam(id = "rofile", type = "File", glob = "$(inputs.romodel)")
req1 <- requireDocker("broadinstitute/gatk:latest")
LearnReadOrientationModel <- cwlProcess(baseCommand = c("gatk", "LearnReadOrientationModel"),
                                      requirements = list(req1),
                                      inputs = InputParamList(p1, p2),
                                      outputs = OutputParamList(o1))


LearnReadOrientationModel <- addMeta(
    LearnReadOrientationModel,
    label = "LearnReadOrientationModel",
    doc = "Get the maximum likelihood estimates of artifact prior probabilities in the orientation bias mixture model filter",
    inputLabels = c("f1r2","romodel"),
    inputDocs = c("One or more .tar.gz containing outputs of CollectF1R2Counts This argument must be specified at least once. Required.","tar.gz of artifact prior tables Required."),
    outputLabels = c("rofile"),
    outputDocs = c("learned artifact priors for the same samples."),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/broadinstitute/gatk",
        example = paste()
    )
)
