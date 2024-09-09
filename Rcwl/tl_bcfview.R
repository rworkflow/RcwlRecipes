
p1 <- InputParam(id = "vcf", type = "File")
p2 <- InputParam(id = "filter", type = "string?", prefix = "-f", default = "PASS")
p3 <- InputParam(id = "fout", type = "string", prefix = "-o")
p4 <- InputParam(id = "otype", type = "string?", prefix = "-O", default = "v")
p5 <- InputParam(id = "sample", type = "string?", prefix = "-s")
p6 <- InputParam(id = "samplefile", type = "File?", prefix = "-S")
p7 <- InputParam(id = "genotype", type = "string?", prefix = "-g")
p8 <- InputParam(id = "include", type = "string?", prefix = "-i")
p9 <- InputParam(id = "exclude", type = "string?", prefix = "-e")

o1 <- OutputParam(id = "Fout", type = "File", glob = "$(inputs.fout)")
req1 <- list(class = "DockerRequirement",
             dockerPull = "biocontainers/bcftools:v1.5_cv3")

bcfview <- cwlProcess(baseCommand = c("bcftools", "view"),
                    requirements = list(req1),
                    inputs = InputParamList(p1, p2, p3, p4, p5, p6, p7, p8, p9),
                    outputs = OutputParamList(o1))


bcfview <- addMeta(
    bcfview,
    label = "bcfview",
    doc = "VCF/BCF conversion, view, subset and filter VCF/BCF files.",
    inputLabels = c("vcf","filter","fout","otype","sample","samplefile","genotype","include","exclude"),
    inputDocs = c("Input VCF file","require at least one of the listed FILTER strings (e.g. 'PASS,.')","output file name [stdout]","b: compressed BCF, u: uncompressed BCF, z: compressed VCF, v: uncompressed VCF [v]","comma separated list of samples to include (or exclude with '^' prefix)","file of samples to include (or exclude with '^' prefix)","require one or more hom/het/missing genotype or, if prefixed with '^', exclude sites with hom/het/missing genotypes","select sites for which the expression is true","exclude sites for which the expression is true"),
    outputLabels = c("Fout"),
    outputDocs = c("Viewed,filtered,.subsetted vcf file output"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/samtools/bcftools",
        example = paste()
    )
)
