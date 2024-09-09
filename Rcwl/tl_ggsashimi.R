## https://github.com/guigolab/ggsashimi
p1 <- InputParam(id = "tsv", type = "File", prefix = "-b")
p2 <- InputParam(id = "bamDir", type = "Directory", position = -1,
                  doc = "The bam files in the input tsv should be relative to this directory")
p3 <- InputParam(id = "coord", type = "string", prefix = "-c")
p4 <- InputParam(id = "gtf", type = "File", prefix = "-g")
p5 <- InputParam(id = "Cfactor", type = "int?", prefix = "-C")
p6 <- InputParam(id = "overlay", type = "int?", prefix = "-O")
p7 <- InputParam(id = "oprefix", type = "string", prefix = "-o", default = "sashimi")
p8 <- InputParam(id = "alpha", type = "float", prefix = "--alpha", default = 0.25)
o1 <- OutputParam(id = "plot", type = "File", glob = "$(inputs.oprefix).pdf")

req1 <- requireDocker("guigolab/ggsashimi:1.0.0")
req2 <- requireInitialWorkDir(listing = list("$(inputs.bamDir)"))
ggsashimi <- cwlProcess(baseCommand = "",
                        requirements = list(req1, req2),
                        inputs = InputParamList(p1, p2, p3, p4, p5, p6, p7, p8),
                        outputs = OutputParamList(o1))


ggsashimi <- addMeta(
    ggsashimi,
    label = "ggsashimi",
    doc = "Command-line tool for the visualization of splicing events across multiple samples",
    inputLabels = c("tsv","bamDir","coord","gtf","Cfactor","overlay","oprefix","alpha"),
    inputDocs = c("Individual bam file or file with a list of bam files.In the case of a list of files the format is tsv:1col: id for bam file, 2col: path of bam file, 3+col:additional columns","Bam directory","Genomic region. Format: chr:start-end. Remember that bam coordinates are 0-based","Gtf file with annotation (only exons is enough)","Index of column with color levels (1-based)","Index of column with overlay levels (1-based)","Prefix for plot file name [default=sashimi]","Transparency level for density histogram [default=0.5]"),
    outputLabels = c("plot"),
    outputDocs = c("Plot of splicing event"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/guigolab/ggsashimi",
        example = paste()
    )
)
