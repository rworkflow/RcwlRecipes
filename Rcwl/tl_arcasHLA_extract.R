p1 <- InputParam(id = "bam", type = "File", position = 1L, secondaryFiles = ".bai")
p2 <- InputParam(id = "threads", type = "int", prefix = "-t", default=4L)
o1 <- OutputParam(id = "fqs", type = "File[]", glob = "*.fq.gz")
req1 <- requireDocker("hubentu/arcas-hla")
arcasHLA_extract <- cwlProcess(baseCommand = c("arcasHLA", "extract"),
                               arguments = list("-o", ".", "-v"),
                               requirements = list(req1),
                               inputs = InputParamList(p1, p2),
                               outputs = OutputParamList(o1))


arcasHLA_extract <- addMeta(
    arcasHLA_extract,
    label = "arcasHLA_extract",
    doc = "arcasHLA extract takes sorted BAM files and extracts chromosome 6 reads and related HLA sequences. If the BAM file is not indexed, this tool will run samtools index before extracting reads",
    inputLabels = c("bam","threads"),
    inputDocs = c("Input Bam file","No. of threads"),
    outputLabels = c("fqs"),
    outputDocs = c("paired FASTQ files; use the --single flag for single-end samples"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/RabadanLab/arcasHLA",
        example = paste()
    )
)
