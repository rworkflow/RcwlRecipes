## https://github.com/AstraZeneca-NGS/VarDictJava

p1 <- InputParam(id = "tbam", type = "File",
                 secondaryFiles = ".bai", position = -1)
p2 <- InputParam(id = "nbam", type = "File",
                 secondaryFiles = ".bai", position = -1)
p3 <- InputParam(id = "ref", type = "File", prefix = "-G",
                 secondaryFiles = ".fai", position = 2)
p4 <- InputParam(id = "region", type = "File", position = 1)
p5 <- InputParam(id = "af", type = "string", default = "0.01", position = -1)
p6 <- InputParam(id = "vcf", type = "string", position = -1)
p7 <- InputParam(id = "threads", type = "int", position = 4,
                 prefix = "-th", default = 1L)
o1 <- OutputParam(id = "outVcf", type = "File", glob = "$(inputs.vcf)")
req1 <- list(class = "DockerRequirement",
             dockerPull = "quay.io/biocontainers/vardict-java:1.8.2--hdfd78af_1")
req2 <- list(class = "ShellCommandRequirement")
VarDict <- cwlProcess(baseCommand = c("vardict-java"),
                    requirements = list(req1, req2),
                    arguments = list(
                        list(valueFrom = "-b", position = 5L),
                        list(valueFrom = "$(inputs.tbam.path)|$(inputs.nbam.path)", position = 6L),
                        list(valueFrom = "-f", position  = 7L),
                        list(valueFrom = "$(inputs.af)", position = 8L),
                        "-c", "1", "-S", "2", "-E", "3", "-g", "4",
                        list(valueFrom = " | ", position = 9L, shellQuote = FALSE),
                        list(valueFrom = "testsomatic.R", position = 10L),
                        list(valueFrom = " | ", position = 11L, shellQuote = FALSE),
                        list(valueFrom = "var2vcf_paired.pl", position = 12L),
                        list(valueFrom = "-N", position = 13L),
                        list(valueFrom = "TUMOR|NORMAL", position = 14L),
                        list(valueFrom = "-f", position = 15L),
                        list(valueFrom = "$(inputs.af)", position = 16L)
                    ),
                    inputs = InputParamList(p1, p2, p3, p4, p5, p6, p7),
                    outputs = OutputParamList(o1),
                    stdout = "$(inputs.vcf)")


VarDict <- addMeta(
    VarDict,
    label = "VarDict",
    doc = "VarDict is a variant calling program for SNV, MNV, indels (<50 bp), and complex variants. It accepts any BAM format, either from DNA-seq or RNA-seq.",
    inputLabels = c("tbam","nbam","ref","region","af","vcf","threads"),
    inputDocs = c("Tumor bam file","Normal bam file","The reference fasta.","The region of interest.","The minimum allele frequency threshold for reporting variants.","The name of the VCF (Variant Call Format) file that will contain the output variants detected by VarDict.","The number of CPU threads to use for parallel processing."),
    outputLabels = c("outVcf"),
    outputDocs = c("Output vcf file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/AstraZeneca-NGS/VarDictJava",
        example = paste()
    )
)
