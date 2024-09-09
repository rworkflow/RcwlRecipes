p1 <- InputParam(id = "exclude", type = "string?", prefix = "-e")
p2 <- InputParam(id = "format", type = "string?", prefix = "-f")
p3 <- InputParam(id = "header", type = "boolean?", prefix = "-H")
p4 <- InputParam(id = "include", type = "string?", prefix = "-i")
p5 <- InputParam(id = "listSample", type = "boolean?", prefix = "-l")
p6 <- InputParam(id = "region", type = "string?", prefix = "-r")
p7 <- InputParam(id = "regionFile", type = "File?", prefix = "-R")
p8 <- InputParam(id = "sample", type = "string?", prefix = "-s")
p9 <- InputParam(id = "sampleFile", type = "File?", prefix = "-S")
p10 <- InputParam(id = "target", type = "string?", prefix = "-t")
p11 <- InputParam(id = "targetFile", type = "File?", prefix = "-T")
p12 <- InputParam(id = "uTags", type = "boolean?", prefix = "-u")
p13 <- InputParam(id = "vcfList", type = "File?", prefix = "-v")
p14 <- InputParam(id = "vcf", type = "File?", position = 20L)
p15 <- InputParam(id = "out", type = "string", position = -1L)
o1 <- OutputParam(id = "qout", type = "File", glob = "$(inputs.out)")
req1 <- requireDocker("quay.io/biocontainers/bcftools:1.13--h3a49de5_0")
bcftools_query <- cwlProcess(baseCommand = c("bcftools", "query"),
                             requirements = list(req1),
                             inputs = InputParamList(p1, p2, p3, p4, p5, p6, p7, p8,
                                                     p9, p10, p11, p12, p13, p14, p15),
                             outputs = OutputParamList(o1),
                             stdout = "$(inputs.out)")


bcftools_query <- addMeta(
    bcftools_query,
    label = "bcftools_query",
    doc = "Extracts fields from VCF/BCF file and prints them in user-defined format",
    inputLabels = c("exclude","format","header","include","listSample","region","regionFile","sample","sampleFile","target","targetFile","uTags","vcfList","vcf","out"),
    inputDocs = c("exclude sites for which the expression is true","define specific columns from the VCF file which will be selected","print header","select sites for which the expression is true","print the list of samples and exit","restrict to comma-separated list of regions","restrict to regions listed in a file","list of samples to include","file of samples to include","similar to -r but streams rather than index-jumps","similar to -R but streams rather than index-jumps","print '.' for undefined tags","process multiple VCFs listed in the file","Input VCF file","name of the Output file"),
    outputLabels = c("qout"),
    outputDocs = c("Queried file with extracted information"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/samtools/bcftools",
        example = paste()
    )
)
