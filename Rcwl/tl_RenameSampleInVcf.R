
p1 <- InputParam(id = "vcf", type = "File", prefix = "I=", separate = FALSE)
p2 <- InputParam(id = "ovcf", type = "string", prefix = "O=", separate = FALSE)
p3 <- InputParam(id = "NewName", type = "string", prefix = "NEW_SAMPLE_NAME=", separate = FALSE)
o1 <- OutputParam(id = "oVcf", type = "File", glob = "$(inputs.ovcf)")

req1 <- list(class = "DockerRequirement",
             dockerPull = "quay.io/biocontainers/picard:2.21.1--0")
RenameSampleInVcf <- cwlProcess(baseCommand = c("picard",
                                              "RenameSampleInVcf"),
                              requirements = list(req1),
                              inputs = InputParamList(p1, p2, p3),
                              outputs = OutputParamList(o1))


RenameSampleInVcf <- addMeta(
    RenameSampleInVcf,
    label = "RenameSampleInVcf",
    doc = "This tool enables the user to rename a sample in either a VCF or BCF file.",
    inputLabels = c("vcf","ovcf","NewName"),
    inputDocs = c("Input single sample VCF or BCF file. Required.","Output single sample VCF. Required.","New name to give sample in output VCF. Required."),
    outputLabels = c("oVcf"),
    outputDocs = c("Sample name renamed vcf file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/broadinstitute/picard",
        example = paste()
    )
)
