## https://github.com/nygenome/lancet

p1 <- InputParam(id = "tbam", type = "File", prefix = "--tumor",
                 secondaryFiles = list("^.bai?", ".bai?"))
p2 <- InputParam(id = "nbam", type = "File", prefix = "--normal",
                 secondaryFiles = list("^.bai?", ".bai?"))
p3 <- InputParam(id = "ref", type = "File", prefix = "--ref",
                 secondaryFiles = ".fai")
p4 <- InputParam(id = "bed", type = "File?", prefix = "--bed")
p5 <- InputParam(id = "reg", type = "string?", prefix = "--reg")
p6 <- InputParam(id = "threads", type = "int", prefix = "--num-threads")
o1 <- OutputParam(id = "vcf", type = "File", glob = "$(inputs.tbam.namerooot)_lancet.vcf")
req1 <- requireDocker("hubentu/lancet")
lancet <- cwlProcess(cwlVersion = "v1.2",
                     baseCommand = "lancet",
                     requirements = list(req1),
                     inputs = InputParamList(p1, p2, p3, p4, p5, p6),
                     outputs = OutputParamList(o1),
                     stdout = "$(inputs.tbam.namerooot)_lancet.vcf")


lancet <- addMeta(
    lancet,
    label = "lancet",
    doc = "Lancet is a somatic variant caller (SNVs and indels) for short read data. Lancet uses a localized micro-assembly strategy to detect somatic mutation with high sensitivity and accuracy on a tumor/normal pair.",
    inputLabels = c("tbam","nbam","ref","bed","reg","threads"),
    inputDocs = c("BAM file of mapped reads for tumor","BAM file of mapped reads for normal","FASTA file of reference genome","genomic regions from file (BED format)","genomic region (in chr:start-end format)","number of parallel threads [default: 1]"),
    outputLabels = c("vcf"),
    outputDocs = c("Variant vcf file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/nygenome/lancet",
        example = paste()
    )
)
