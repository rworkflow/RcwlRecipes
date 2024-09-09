## BaseRecalibrator
p1 <- InputParam(id = "bam", type = "File", prefix = "-I")
p2 <- InputParam(id = "ref", prefix = "-R", type = "File", secondaryFiles = c(".fai", "$(self.nameroot).dict"))
p3 <- InputParam(id = "rtable", type = "File", prefix = "--bqsr-recal-file")
p4 <- InputParam(id = "oBam", type = "string", prefix = "-O")
o1 <- OutputParam(id = "Bam", type = "File",
                  glob = "$(inputs.oBam)")
req1 <- list(class = "DockerRequirement",
             dockerPull = "broadinstitute/gatk:latest")

ApplyBQSR <- cwlProcess(baseCommand = c("gatk",
                                      "ApplyBQSR"),
                      requirements = list(req1),
                      inputs = InputParamList(p1, p2, p3, p4),
                      outputs = OutputParamList(o1))


ApplyBQSR <- addMeta(
    ApplyBQSR,
    label = "ApplyBQSR",
    doc = "This tool performs the second pass in a two-stage process called Base Quality Score Recalibration (BQSR). Specifically, it recalibrates the base qualities of the input reads based on the recalibration table produced by the BaseRecalibrator tool, and outputs a recalibrated BAM or CRAM file.",
    inputLabels = c("bam","ref","rtable","oBam"),
    inputDocs = c("BAM/SAM/CRAM file containing reads This argument must be specified at least once.(Required)","Reference sequence Default value: null.","Input recalibration table for BQSR Required.","Write output to this file Required."),
    outputLabels = c("Bam"),
    outputDocs = c("Bam file with base Quality score recaliberated"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/broadinstitute/gatk",
        example = paste()
    )
)
