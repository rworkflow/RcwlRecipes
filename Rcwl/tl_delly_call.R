## https://github.com/dellytools/delly
p1 <- InputParam(id = "exclude", type = "File?", prefix = "-x")
p2 <- InputParam(id = "genome", type = "File", prefix = "-g", secondaryFiles = ".fai")
p3 <- InputParam(id = "outfile", type = "string", prefix = "-o")
p4 <- InputParam(id = "bcf", type = "File?", prefix = "-v", secondaryFiles = ".csi")
p5 <- InputParam(id = "tbam", type = "File", position = 5, secondaryFiles = ".bai")
p6 <- InputParam(id = "nbam", type = "File?", position = 6, secondaryFiles = ".bai")
o1 <- OutputParam(id = "outbcf", type = "File", glob = "$(inputs.outfile)",
                  secondaryFiles = ".csi")
req1 <- requireDocker("quay.io/biocontainers/delly:0.8.7--he03298f_1")
delly_call <- cwlProcess(baseCommand = c("delly", "call"),
                         requirements = list(req1),
                         inputs = InputParamList(p1, p2, p3, p4, p5, p6),
                         outputs = OutputParamList(o1))


delly_call <- addMeta(
    delly_call,
    label = "delly_call",
    doc = "Delly is an integrated structural variant (SV) prediction method that can discover, genotype and visualize deletions, tandem duplications, inversions and translocations at single-nucleotide resolution in short-read and long-read massively parallel sequencing data.",
    inputLabels = c("exclude","genome","outfile","bcf","tbam","nbam"),
    inputDocs = c("file with regions to exclude","genome fasta file","SV BCF output file","input VCF/BCF file for genotyping","Tumor bam file","Normal Bam file"),
    outputLabels = c("outbcf"),
    outputDocs = c("Output BCF file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/dellytools/delly",
        example = paste()
    )
)
