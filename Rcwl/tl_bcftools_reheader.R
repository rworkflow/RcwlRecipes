p1 <- InputParam(id = "fai", type = "File?", prefix = "-f")
p2 <- InputParam(id = "header", type = "File?", prefix = "-h")
p3 <- InputParam(id = "samples", type = "File?", prefix = "-s")
p4 <- InputParam(id = "vcf", type = "File")
p5 <- InputParam(id = "output", type = "string", prefix = "-o")
o1 <- OutputParam(id = "outvcf", type = "File", glob = "$(inputs.output)")
req1 <- requireDocker("quay.io/biocontainers/bcftools:1.13--h3a49de5_0")
bcftools_reheader <- cwlProcess(baseCommand = c("bcftools", "reheader"),
                                requirements = list(req1),
                                inputs = InputParamList(p1, p2, p3, p4, p5),
                                outputs = OutputParamList(o1))


bcftools_reheader <- addMeta(
    bcftools_reheader,
    label = "bcftools_reheader",
    doc = "Modify header of VCF/BCF files, change sample names.",
    inputLabels = c("fai","header","samples","vcf","output"),
    inputDocs = c("update sequences and their lengths from the .fai file","new header","new sample names","input VCF file","write output to a file [standard output]"),
    outputLabels = c("outvcf"),
    outputDocs = c("output VCF with modified header"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/samtools/bcftools",
        example = paste()
    )
)
