
p1 <- InputParam(id = "vcf", type = "File", prefix = "--variant")
p2 <- InputParam(id = "bam", type = "File", prefix = "-I", secondaryFiles = ".bai")
p3 <- InputParam(id = "ref", type = "File", prefix = "-R",
                 secondaryFiles = c(".fai", "$(self.nameroot).dict"))
p4 <- InputParam(id = "ovcf", type = "string", prefix = "-o")
p5 <- InputParam(id = "region", type = "File", prefix = "-L")
o1 <- OutputParam(id = "oVcf", type = "File", glob = "$(inputs.ovcf)")
req1 <- list(class = "DockerRequirement",
             dockerPull = "broadinstitute/gatk3:3.8-1")
ReadBackedPhasing <- cwlProcess(baseCommand = c("java", "-jar", "/usr/GenomeAnalysisTK.jar",
                                              "-T", "ReadBackedPhasing"),
                              requirements = list(req1),
                              inputs = InputParamList(p1, p2, p3, p4, p5),
                              outputs = OutputParamList(o1))


ReadBackedPhasing <- addMeta(
    ReadBackedPhasing,
    label = "ReadBackedPhasing",
    doc = "Tool to phase variants by determining their haplotype structure based on the alignment of reads that span multiple variants.",
    inputLabels = c("vcf","bam","ref","ovcf","region"),
    inputDocs = c("Input VCF file","Input file containing sequence data (BAM or CRAM)","Reference sequence file","File to which variants should be written","One or more genomic intervals over which to operate"),
    outputLabels = c("oVcf"),
    outputDocs = c("Output vcf file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/broadinstitute/gatk",
        example = paste()
    )
)
