p1 <- InputParam(id = "seg", type = "File", prefix = "-seg")
p2 <- InputParam(id = "refgene", type = "File", prefix = "-refgene")
p3 <- InputParam(id = "markers", type = "File?", prefix = "-mk")
p4 <- InputParam(id = "rx", type = "int?", prefix = "-rx")
p5 <- InputParam(id = "genegistic", type = "int?", prefix = "-genegistic")
p6 <- InputParam(id = "savegene", type = "int?", prefix = "-savegene")
p7 <- InputParam(id = "tamp", type = "float?", prefix = "-ta")
p8 <- InputParam(id = "tdel", type = "float?", prefix = "-td")
p9 <- InputParam(id = "gcm", type = "string?", prefix = "-gcm")
p10 <- InputParam(id = "brlen", type = "float?", prefix = "-brlen")
p11 <- InputParam(id = "conf", type = "float?", prefix = "-conf")
o1 <- OutputParam(id = "outs", type = "File[]", glob = "*")

req1 <- requireDocker("hubentu/gistic2")
gistic2 <- cwlProcess(baseCommand = "gistic2",
                      requirements = list(req1),
                      arguments = list("-b", "./"),
                      inputs = InputParamList(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11),
                      outputs = OutputParamList(o1))


gistic2 <- addMeta(
    gistic2,
    label = "gistic2",
    doc = "The GISTIC module identifies regions of the genome that are significantly amplified or deleted across a set of samples",
    inputLabels = c("seg","refgene","markers","rx","genegistic","savegene","tamp","tdel","gcm","brlen","conf"),
    inputDocs = c("Path to segmented data input file (REQUIRED, see below for file description).","Path to reference genome data input file (REQUIRED, see below for file description).","Path to markers input file (OPTIONAL, but encouraged: see below for file description).","Flag indicating whether to remove data from the sex chromosomes before analysis. Allowed values= {1,0}. (DEFAULT=1, remove X,Y)","Flag indicating that the gene GISTIC algorithm should be used to calculate the significance of deletions at a gene level instead of a marker level. Allowed values= {1,0}. (DEFAULT=0, no gene GISTIC).","Flag indicating that gene tables should be saved. Allowed values= {1,0}. (DEFAULT=0, don't save gene tables)","Threshold for copy number amplifications. Regions with a copy number gain above this positive value are considered amplified. Regions with a copy number gain smaller than this value are considered noise and set to 0. (DEFAULT=0.1)","Threshold for copy number deletions. Regions with a copy number loss below the negative of this positive value are considered deletions. Regions with a smaller copy number loss are considered noise and set to 0. (DEFAULT=0.1)","Method for reducing marker-level copy number data to the gene-level copy number data in the gene tables. Markers contained in the gene are used when available, otherwise the flanking marker or markers are used. Allowed values are mean, median, min, max or extreme. The extreme method chooses whichever of min or max is furthest from diploid. (DEFAULT=mean)","Threshold used to distinguish broad from focal events, given in units of fraction of chromosome arm. (DEFAULT = 0.98)","Confidence level used to calculate the region containing a driver. (DEFAULT=0.75)"),
    outputLabels = c("outs"),
    outputDocs = c("gistic2 output files"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/broadinstitute/gistic2",
        example = paste()
    )
)
