
p1 <- InputParam(id = "bam", type = "File",
                 prefix = "-I", secondaryFiles = ".bai")
p2 <- InputParam(id = "prefix", type = "string", prefix = "-o")
p3 <- InputParam(id = "region", type = "File", prefix = "-L")
p4 <- InputParam(id = "ref", type = "File",
                 prefix = "-R", secondaryFiles = c(".fai", "$(self.nameroot).dict"))
p5 <- InputParam(id = "ct", type = InputArrayParam(items = "int",
                                                   prefix = "-ct"),
                 default = list(1L, 10L, 20L, 30L))
o1 <- OutputParam(id = "out", type = "File", glob = "$(inputs.prefix).sample_summary")

req1 <- list(class = "DockerRequirement",
             dockerPull = "broadinstitute/gatk3:3.8-1")
DepthOfCoverage <- cwlProcess(baseCommand = c("java", "-jar", "/usr/GenomeAnalysisTK.jar",
                                            "-T", "DepthOfCoverage"),
                            requirements = list(req1),
                            arguments = list("-omitBaseOutput"),
                            inputs = InputParamList(p1, p2, p3, p4, p5),
                            outputs = OutputParamList(o1))


DepthOfCoverage <- addMeta(
    DepthOfCoverage,
    label = "DepthOfCoverage",
    doc = "This tool processes a set of bam files to determine coverage at different levels of partitioning and aggregation",
    inputLabels = c("bam","prefix","region","ref","ct"),
    inputDocs = c("Input file containing sequence data (BAM or CRAM)","An output file created by the walker. Will overwrite contents if file exists","One or more genomic intervals over which to operate","Reference sequence file","Coverage threshold (in percent) for summarizing statistics"),
    outputLabels = c("out"),
    outputDocs = c("Tables pertaining to different coverage summaries."),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/broadinstitute/gatk",
        example = paste()
    )
)
