## BaseRecalibrator
p1 <- InputParam(id = "bam", type = "File", prefix = "-I")
p2 <- InputParam(id = "ref", prefix = "-R", type = "File", secondaryFiles = c(
                                                               ".fai",
                                                               "$(self.nameroot).dict"))
p3 <- InputParam(id = "knowSites", type = InputArrayParam(items = "File",
                                                          prefix = "--known-sites"),
                 secondaryFiles = "$(self.nameext == '.gz' ? self.basename+'.tbi' : self.basename+'.idx')")
p4 <- InputParam(id = "recal", type = "string", prefix = "-O")
o1 <- OutputParam(id = "rtable", type = "File",
                  glob = "$(inputs.recal)")
req1 <- list(class = "DockerRequirement",
             dockerPull = "broadinstitute/gatk:latest")
req2 <- requireJS()
BaseRecalibrator <- cwlProcess(cwlVersion = "v1.0",
                               baseCommand = c("gatk", "BaseRecalibrator"),
                               requirements = list(req1, req2),
                               inputs = InputParamList(p1, p2, p3, p4),
                               outputs = OutputParamList(o1))


BaseRecalibrator <- addMeta(
    BaseRecalibrator,
    label = "BaseRecalibrator",
    doc = "First pass of the Base Quality Score Recalibration (BQSR) -- Generates recalibration table based on various user-specified covariates",
    inputLabels = c("bam","ref","knowSites","recal"),
    inputDocs = c("BAM/SAM/CRAM file containing reads This argument must be specified at least once.(Required)","Reference sequence file (Required)","One or more databases of known polymorphic sites used to exclude regions around known polymorphisms from analysis. This argument must be specified at least once.(Required)","The output recalibration table file to create (Required)"),
    outputLabels = c("rtable"),
    outputDocs = c("recalibration table"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/broadinstitute/gatk",
        example = paste()
    )
)
