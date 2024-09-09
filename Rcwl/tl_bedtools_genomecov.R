## bam to bedgraph
p1 <- InputParam(id = "bam", type = "File", prefix = "-ibam")
p2 <- InputParam(id = "bedgraph", type = "boolean", prefix = "-bg", default = TRUE)
o1 <- OutputParam(id = "bed", type = "File", glob = "*.bedgraph")
req1 <- list(class = "DockerRequirement",
             dockerPull = "quay.io/biocontainers/bedtools:2.29.2--hc088bd4_0")
bedtools_genomecov <- cwlProcess(baseCommand = c("bedtools", "genomecov"),
                               requirements = list(req1),
                               inputs = InputParamList(p1, p2),
                               outputs = OutputParamList(o1),
                               stdout = "$(inputs.bam.nameroot).bedgraph")


bedtools_genomecov <- addMeta(
    bedtools_genomecov,
    label = "bedtools_genomecov",
    doc = "Compute the coverage of a feature file among a genome.",
    inputLabels = c("bam","bedgraph"),
    inputDocs = c("The input file is in BAM format.Note: BAM _must_ be sorted by position","Report depth in BedGraph format. For details, see:genome.ucsc.edu/goldenPath/help/bedgraph.html"),
    outputLabels = c("bed"),
    outputDocs = c("Depth of coverage in bedgraph"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/samtools/bcftools",
        example = paste()
    )
)
