p1 <- InputParam(id = "ovcf", type = "string", prefix = "-o")
p2 <- InputParam(id = "gvcfs", type = "File[]", position = -1)
p3 <- InputParam(id = "type", type = "string?", prefix = "-O")
p4 <- InputParam(id = "overlap", type = "boolean?", prefix = "-a")
o1 <- OutputParam(id = "Fout", type = "File", glob = "$(inputs.ovcf)", secondaryFiles = ".tbi?")
req1 <- requireDocker("quay.io/biocontainers/bcftools:1.13--h3a49de5_0")
req2 <- requireManifest("gvcfs", sep = "\t")

bcftools_concat_file <- cwlProcess(cwlVersion = "v1.2",
                                   baseCommand = c("bcftools", "concat"),
                                   requirements = list(req1, req2),
                                   arguments = list("-f", "gvcfs"),
                                   inputs = InputParamList(p1, p2, p3, p4),
                                   outputs = OutputParamList(o1))


bcftools_concat_file <- addMeta(
    bcftools_concat_file,
    label = "bcftools_concat_file",
    doc = "Concatenate or combine VCF/BCF files. All source files must have the same sample columns appearing in the same order.",
    inputLabels = c("ovcf","gvcfs","type","overlap"),
    inputDocs = c("Write output to a file [standard output]","Input zipped vcf files","b: compressed BCF, u: uncompressed BCF, z: compressed VCF, v: uncompressed VCF [v]","First coordinate of the next file can precede last record of the current file."),
    outputLabels = c("Fout"),
    outputDocs = c("Concatinated vcf file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/samtools/bcftools",
        example = paste()
    )
)
