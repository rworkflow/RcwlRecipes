p1 <- InputParam(id = "normal", type = "File", prefix = "-n", secondaryFiles = ".bai")
p2 <- InputParam(id = "tumor", type = "File", prefix = "-t", secondaryFiles = ".bai")
p3 <- InputParam(id = "ref", type = "File", prefix = "--fasta", secondaryFiles = ".fai")
p4 <- InputParam(id = "gc", type = "File", prefix = "-gc")
p5 <- InputParam(id = "out", type = "string", prefix = "-o")
o1 <- OutputParam(id = "seqz", type = "File", glob = "$(inputs.out)")
r1 <- requireDocker("quay.io/biocontainers/sequenza-utils:3.0.0--py39h67e14b5_5")
bam2seqz <- cwlProcess(baseCommand = c("sequenza-utils", "bam2seqz"),
                       requirements = list(r1),
                       inputs = InputParamList(p1, p2, p3, p4, p5),
                       outputs = OutputParamList(o1))


bam2seqz <- addMeta(
    bam2seqz,
    label = "bam2seqz",
    doc = "Process a paired set of BAM/pileup files (tumor and matching normal), and GC-content genome-wide information, to extract the common positions with A and B alleles frequencies",
    inputLabels = c("normal","tumor","ref","gc","out"),
    inputDocs = c("Name of the BAM/pileup file from the reference/normal sample","Name of the BAM/pileup file from the tumor sample","The reference FASTA file used to generate the intermediate pileup. Required when input are BAM","The GC-content wiggle file","Name of the output file. To use gzip compression name the file ending in .gz. Default STDOUT."),
    outputLabels = c("seqz"),
    outputDocs = c("Seqz output file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/Yunuuuu/sequenza",
        example = paste()
    )
)
