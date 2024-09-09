
p1 <- InputParam(id = "bam", type = "File",
                 prefix = "-b", secondaryFiles = ".bai")
p2 <- InputParam(id = "outFile", type = "string", prefix = "-o")
p3 <- InputParam(id = "binsize", type = "int",
                 prefix = "-bs", default = 1L)
p4 <- InputParam(id = "processors", type = "string",
                 prefix = "-p", default = "max")
p5 <- InputParam(id = "outFormat", type = "string",
                 prefix = "--outFileFormat", default = "bigwig")
o1 <- OutputParam(id = "bigwig", type = "File", glob = "$(inputs.bw)")
req1 <- list(class = "DockerRequirement",
             dockerPull = "quay.io/biocontainers/deeptools:3.4.3--py_0")
bamCoverage <- cwlProcess(baseCommand = "bamCoverage",
                        requirements = list(req1),
                        arguments = list("--ignoreDuplicates",
                                         "--skipNonCoveredRegions"),
                        inputs = InputParamList(p1, p2, p3, p4, p5),
                        outputs = OutputParamList(o1))


bamCoverage <- addMeta(
    bamCoverage,
    label = "bamCoverage",
    doc = "This tool takes an alignment of reads or fragments as input (BAM file) and generates a coverage track (bigWig or bedGraph) as output.",
    inputLabels = c("bam","outFile","binsize","processors","outFormat"),
    inputDocs = c("BAM file to process (default: None)","Output file name. (default: None)","Size of the bins, in bases, for the output of the bigwig/bedgraph file. (Default: 50)","Number of processors to use. Type 'max/2' to use half the maximum number of processors or 'max' to use all available processors. (Default: 1)","{bigwig,bedgraph}, -of {bigwig,bedgraph} Output file type. Either 'bigwig' or 'bedgraph'.(default: bigwig)"),
    outputLabels = c("bigwig"),
    outputDocs = c("Proccesed bigwig file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/gartician/deepTools-bamCoverage",
        example = paste()
    )
)
