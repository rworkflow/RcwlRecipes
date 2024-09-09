## gene body coverage
p1 <- InputParam(id = "bam", type = "File", prefix = "-i", secondaryFiles = ".bai")
p2 <- InputParam(id = "bed", type = "File", prefix = "-r")
p3 <- InputParam(id = "prefix", type = "string", prefix = "-o")
o1 <- OutputParam(id = "gCovPDF", type = "File", glob = "*.geneBodyCoverage.curves.pdf")
o2 <- OutputParam(id = "gCovTXT", type = "File", glob = "*.geneBodyCoverage.txt")
req1 <- list(class = "DockerRequirement",
             dockerPull = "hubentu/rcwl-rnaseq")
geneBody_coverage <- cwlProcess(baseCommand = c("geneBody_coverage.py"),
                              requirements = list(req1),
                              inputs = InputParamList(p1, p2, p3),
                              outputs = OutputParamList(o1, o2))


geneBody_coverage <- addMeta(
    geneBody_coverage,
    label = "geneBody_coverage",
    doc = "Calculate the RNA-seq reads coverage over gene body.",
    inputLabels = c("bam","bed","prefix"),
    inputDocs = c("Input file(s) in BAM format. '-i' takes these input:1) a single BAM file. 2) ',' separated BAM files. 3)directory containing one or more bam files. 4) plain text file containing the path of one or more bam file(Each row is a BAM file path). All BAM files should be sorted and indexed using samtools.","Reference gene model in bed format. [required]","Prefix of output files(s). [required]"),
    outputLabels = c("gCovPDF","gCovTXT"),
    outputDocs = c("The final plot, in PDF format","Table that includes the data used to generate the plots"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/Xinglab/rseqc",
        example = paste()
    )
)
