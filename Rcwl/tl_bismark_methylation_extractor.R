p1 <- InputParam(id = "paired", type = "boolean?", prefix = "-p")
p2 <- InputParam(id = "single", type = "boolean?", prefix = "-s")
p3 <- InputParam(id = "bedGraph", type = "boolean?", prefix = "--bedGraph", default = TRUE)
p4 <- InputParam(id = "gzip", type = "boolean?", prefix = "--gzip", default = TRUE)
p5 <- InputParam(id = "core", type = "int", prefix = "--multicore", default = 4)
p6 <- InputParam(id = "bam", type = "File", position = 10)
o1 <- OutputParam(id = "cov", type = "File", glob = "*.cov*")
o2 <- OutputParam(id = "Bed", type = "File?", glob = "*.bedGraph*")
o3 <- OutputParam(id = "report", type = "File[]", glob = "*.txt")
req1 <- requireDocker("quay.io/biocontainers/bismark:0.23.1--hdfd78af_0")
bismark_methylation_extractor <- cwlProcess(baseCommand = "bismark_methylation_extractor",
                                            requirements = list(req1),
                                            inputs = InputParamList(p1, p2, p3, p4, p5, p6),
                                            outputs = OutputParamList(o1, o2, o3))


bismark_methylation_extractor <- addMeta(
    bismark_methylation_extractor,
    label = "bismark_methylation_extractor",
    doc = "This script reads in a bisulfite read alignment results file produced by the Bismark bisulfite mapper (in BAM/CRAM/SAM format) and extracts the methylation information for individual cytosines.",
    inputLabels = c("paired","single","bedGraph","gzip","core","bam"),
    inputDocs = c("Input file(s) are Bismark result file(s) generated from paired-end read data.","Input file(s) are Bismark result file(s) generated from single-end read data","After finishing the methylation extraction, the methylation output is written into a sorted bedGraph file that reports the position of a given cytosine and its methylation state.","The methylation extractor files (CpG_OT_..., CpG_OB_... etc) will be written out in a GZIP compressed form to save disk space.","Sets the number of cores to be used for the methylation extraction process.","Input bam file from bismark"),
    outputLabels = c("cov","Bed","report"),
    outputDocs = c("Coverage output","bedGraph output","genome-wide cytosine methylation report"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/FelixKrueger/Bismark",
        example = paste()
    )
)
