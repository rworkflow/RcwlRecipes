## https://bioinformatics.mdanderson.org/public-software/muse/
p1 <- InputParam(id = "tbam", type = "File",
                 secondaryFiles = ".bai", position = 1)
p2 <- InputParam(id = "nbam", type = "File",
                 secondaryFiles = ".bai", position = 2)
p3 <- InputParam(id = "ref", type = "File", prefix = "-f",
                 secondaryFiles = ".fai", position = 3)
p4 <- InputParam(id = "region", type = "File?",
                 prefix = "-l", position = 4)
p5 <- InputParam(id = "dbsnp", type = "File", prefix = "-D", position = 10,
                 secondaryFiles = "$(self.nameext == '.gz' ? self.basename+'.tbi' : self.basename+'.idx')")
p6 <- InputParam(id = "vcf", type = "string",
                 prefix = "-O", position = 11)
p7 <- InputParam(id = "exome", type = "boolean",
                 prefix = "-E", position = 12, default = TRUE)
p8 <- InputParam(id = "genome", type = "boolean",
                 prefix = "-G", position = 12, default = FALSE)
o1 <- OutputParam(id = "outVcf", type = "File", glob = "$(inputs.vcf)", secondaryFiles = ".tbi?")

req1 <- list(class = "DockerRequirement",
             dockerPull = "quay.io/biocontainers/muse:1.0.rc--h2e03b76_5")
req2 <- list(class = "ShellCommandRequirement")
req3 <- requireJS()
MuSE <- cwlProcess(cwlVersion = "v1.0",
                   baseCommand = c("MuSE", "call"),
                   requirements = list(req1, req2, req3),
                   arguments = list(
                       "-O", "output",
                       list(valueFrom = " && ", position = 5L, shellQuote = FALSE),
                       list(valueFrom = "MuSE", position = 6L),
                       list(valueFrom = "sump", position = 7L),
                       list(valueFrom = "-I", position = 8L),
                       list(valueFrom = "output.MuSE.txt", position = 9L)
                   ),
                   inputs = InputParamList(p1, p2, p3, p4, p5, p6, p7, p8),
                   outputs = OutputParamList(o1))


MuSE <- addMeta(
    MuSE,
    label = "MuSE",
    doc = "Statistical approach for mutation calling based on a Markov substitution model for molecular evolution.",
    inputLabels = c("tbam","nbam","ref","region","dbsnp","vcf","exome","genome"),
    inputDocs = c("Tumor bam file","Normal bam file","faidx indexed reference sequence file","list of regions (chr:pos-pos or BED), one region per line","dbSNP vcf file that should be bgzip compressed,tabix indexed and based on the same reference genome used in 'MuSE call'","output file name (VCF format)","input generated from whole exome sequencing data","input generated from whole genome sequencing data"),
    outputLabels = c("outVcf"),
    outputDocs = c("Output VCF file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://bioinformatics.mdanderson.org/public-software/muse/",
        example = paste()
    )
)
