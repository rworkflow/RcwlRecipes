
p1 <- InputParam(id = "bam", type = "File", prefix = "I=", separate = FALSE)
p2 <- InputParam(id = "fq1", type = "string", prefix = "F=", separate = FALSE)
p3 <- InputParam(id = "fq2", type = "string", prefix = "F2=", separate = FALSE)
o1 <- OutputParam(id = "FQ1", type = "File", glob = "$(inputs.fq1)")
o2 <- OutputParam(id = "FQ2", type = "File", glob = "$(inputs.fq2)")

req1 <- list(class = "DockerRequirement",
             dockerPull = "quay.io/biocontainers/picard:2.21.1--0")
SamToFastq <- cwlProcess(baseCommand = c("picard",
                                       "SamToFastq"),
                       requirements = list(req1),
                       inputs = InputParamList(p1, p2, p3),
                       outputs = OutputParamList(o1, o2))


SamToFastq <- addMeta(
    SamToFastq,
    label = "SamToFastq",
    doc = "Converts a SAM or BAM file to FASTQ.",
    inputLabels = c("bam","fq1","fq2"),
    inputDocs = c("Input SAM/BAM file to extract reads from Required.","Output FASTQ file1 (single-end fastq or, if paired, first end of the pair FASTQ). Required. Cannot be used in conjuction with option(s) OUTPUT_DIR (ODIR) COMPRESS_OUTPUTS_PER_RG (GZOPRG) OUTPUT_PER_RG (OPRG)","Output FASTQ file2 (single-end fastq or, if paired, first end of the pair FASTQ). Required. Cannot be used in conjuction with option(s) OUTPUT_DIR (ODIR) COMPRESS_OUTPUTS_PER_RG (GZOPRG) OUTPUT_PER_RG (OPRG)"),
    outputLabels = c("FQ1","FQ2"),
    outputDocs = c("Fastq1","Fastq2"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/broadinstitute/picard",
        example = paste()
    )
)
