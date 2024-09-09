## https://github.com/mingyi-wang/somatic-combiner
p1 <- InputParam(id = "vardict", type = "File?", prefix = "-D")
p2 <- InputParam(id = "lofreqSNV", type = "File?", prefix = "-l", secondaryFiles = ".tbi")
p3 <- InputParam(id = "lofreqIndel", type = "File?", prefix = "-L", secondaryFiles = ".tbi")
p4 <- InputParam(id = "mutect", type = "File?", prefix = "-m", secondaryFiles = ".tbi")
p5 <- InputParam(id = "mutect2", type = "File?", prefix = "-M",
                 secondaryFiles = list(pattern = ".tbi", required = FALSE))
p6 <- InputParam(id = "strelkaSNV", type = "File?", prefix = "-s", secondaryFiles = ".tbi")
p7 <- InputParam(id = "strelkaIndel", type = "File?", prefix = "-S", secondaryFiles = ".tbi")
p8 <- InputParam(id = "muse", type = "File?", prefix = "-u")
p9 <- InputParam(id = "varscanSNV", type = "File?", prefix = "-v")
p10 <- InputParam(id = "varscanIndel", type = "File?", prefix = "-V")
p11 <- InputParam(id = "outvcf", type = "string", prefix = "-o")
o1 <- OutputParam(id = "ovcf", type = "File", glob = "$(inputs.outvcf)")
req1 <- requireDocker("hubentu/somatic_combiner")
somatic_combiner <- cwlProcess(cwlVersion = "v1.2",
                               baseCommand = "",
                               requirements = list(req1),
                               inputs = InputParamList(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11),
                               outputs = OutputParamList(o1))


somatic_combiner <- addMeta(
    somatic_combiner,
    label = "somatic_combiner",
    doc = "A consensus ensemble approach which can combine somatic variants VCFs generated from seven popular callers: LoFreq, MuSE, MuTect2, MuTect, Strelka, VarDict and VarScan.",
    inputLabels = c("vardict","lofreqSNV","lofreqIndel","mutect","mutect2","strelkaSNV","strelkaIndel","muse","varscanSNV","varscanIndel","outvcf"),
    inputDocs = c("Vardict VCF file","Lofreq SNV VCF file","Lofreq INDEL VCF file","Mutect VCF file","Mutect2 VCF file","Strelka SNV VCF file","Strelka INDEL VCF file","Muse VCF file","Varscan SNV VCF file","Varscan INDEL VCF file","Output VCF file"),
    outputLabels = c("ovcf"),
    outputDocs = c("Combined vcf file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/mingyi-wang/somatic-combiner",
        example = paste()
    )
)
