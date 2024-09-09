p1 <- InputParam(id = "ovcf", type = "string", prefix = "-o")
p2 <- InputParam(id = "vcf", type = "File",
                 secondaryFiles = ".tbi?")
p3 <- InputParam(id = "type", type = "string?", prefix = "-O")
p4 <- InputParam(id = "dup", type = "string?", prefix = "-d")
o1 <- OutputParam(id = "Fout", type = "File", glob = "$(inputs.ovcf)", secondaryFiles = ".tbi?")
req1 <- requireDocker("quay.io/biocontainers/bcftools:1.13--h3a49de5_0")

bcftools_norm <- cwlProcess(cwlVersion = "v1.2",
                            baseCommand = c("bcftools", "norm"),
                            requirements = list(req1),
                            inputs = InputParamList(p1, p2, p3, p4),
                            outputs = OutputParamList(o1))


bcftools_norm <- addMeta(
    bcftools_norm,
    label = "bcftools_norm",
    doc = "Left-align and normalize indels, check if REF alleles match the reference, split multiallelic sites into multiple rows; recover multiallelics from multiple rows. Left-alignment and normalization will only be applied if the –fasta-ref option is supplied",
    inputLabels = c("ovcf","vcf","type","dup"),
    inputDocs = c("Write output to a file [standard output]","Input VCF file","b' compressed BCF; 'u' uncompressed BCF; 'z' compressed VCF; 'v' uncompressed VCF [v]","Remove duplicate snps|indels|both|all|exact"),
    outputLabels = c("Fout"),
    outputDocs = c("BCF normalized output file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/samtools/bcftools",
        example = paste()
    )
)
