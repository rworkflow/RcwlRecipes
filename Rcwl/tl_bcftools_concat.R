p1 <- InputParam(id = "ovcf", type = "string", prefix = "-o")
p2 <- InputParam(id = "vcfs", type = "File[]?", secondaryFiles = "tbi?")
p3 <- InputParam(id = "type", type = "string?", prefix = "-O")
p4 <- InputParam(id = "overlap", type = "boolean?", prefix = "-a")
p5 <- InputParam(id = "vfile", type = "File?", prefix = "-f")
o1 <- OutputParam(id = "Fout", type = "File", glob = "$(inputs.ovcf)", secondaryFiles = ".tbi?")
req1 <- requireDocker("quay.io/biocontainers/bcftools:1.13--h3a49de5_0")

bcftools_concat <- cwlProcess(cwlVersion = "v1.2",
                              baseCommand = c("bcftools", "concat"),
                              requirements = list(req1),
                              inputs = InputParamList(p1, p2, p3, p4, p5),
                              outputs = OutputParamList(o1))


bcftools_concat <- addMeta(
    bcftools_concat,
    label = "bcftools_concat",
    doc = "Concatenate or combine VCF/BCF files. All source files must have the same sample columns appearing in the same order.",
    inputLabels = c("ovcf","vcfs","type","overlap","vfile"),
    inputDocs = c("Write output to a file [standard output]","Input vcf files","b: compressed BCF, u: uncompressed BCF, z: compressed VCF, v: uncompressed VCF [v]","First coordinate of the next file can precede last record of the current file.","Read the list of files from a file."),
    outputLabels = c("Fout"),
    outputDocs = c("Concatinated vcf file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/samtools/bcftools",
        example = paste()
    )
)
