## HaplotypeCaller
p1 <- InputParam(id = "bam", type = "File", prefix = "-I",
                 secondaryFiles = ".bai")
p2 <- InputParam(id = "interval", type = "File", prefix = "-L")
p3 <- InputParam(id = "ref", type = "File", prefix = "-R",
                 secondaryFiles = c(".fai", "$(self.nameroot).dict"))
p4 <- InputParam(id = "gout", type = "string", prefix = "-O")
p5 <- InputParam(id = "emit", type = "string", prefix = "-ERC", default = "GVCF")
p6 <- InputParam(id = "downsampling", type = "int", prefix = "--max-reads-per-alignment-start",
                 default = 50L)
o1 <- OutputParam(id = "gvcf", type = "File", glob = "$(inputs.gout)",
                  secondaryFiles = ".idx")
req1 <- list(class = "DockerRequirement",
             dockerPull = "broadinstitute/gatk:latest")
HaplotypeCaller <- cwlProcess(baseCommand = c("gatk", "HaplotypeCaller"),
                            requirements = list(req1),
                            inputs = InputParamList(p1, p2, p3, p4, p5, p6),
                            outputs = OutputParamList(o1))


HaplotypeCaller <- addMeta(
    HaplotypeCaller,
    label = "HaplotypeCaller",
    doc = "Call germline SNPs and indels via local re-assembly of haplotypes",
    inputLabels = c("bam","interval","ref","gout","emit","downsampling"),
    inputDocs = c("BAM/SAM/CRAM file containing reads This argument must be specified at least once.Required.","One or more genomic intervals over which to operate This argument may be specified 0 or more times. Default value: null.","Reference sequence file Required.","File to which variants should be written Required.","Mode for emitting reference confidence scores (For Mutect2, this is a BETA feature) Default value: NONE. Possible values: {NONE, BP_RESOLUTION, GVCF}","Maximum number of reads to retain per alignment start position. Reads above this threshold will be downsampled. Set to 0 to disable. Default value: 50."),
    outputLabels = c("gvcf"),
    outputDocs = c("output vcf file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/broadinstitute/gatk",
        example = paste()
    )
)
