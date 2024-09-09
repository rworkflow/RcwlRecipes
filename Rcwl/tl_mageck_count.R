## https://sourceforge.net/p/mageck/wiki/Home/
p1 <- InputParam(id = "library", type = "File", prefix = "-l")
p2 <- InputParam(id = "fastq", type = "File[]", prefix = "--fastq")
p3 <- InputParam(id = "samples", type = "string[]?",
                 itemSeparator = ",", prefix = "--sample-label")
p4 <- InputParam(id = "prefix", type = "string", prefix = "-n")
p5 <- InputParam(id = "conSGRNA", type = "File?", prefix = "--control-sgrna")
o1 <- OutputParam(id = "counts", type = "File[]",
                  glob = "$(inputs.prefix)*")

req1 <- requireDocker("quay.io/biocontainers/mageck:0.5.9.4--py38hed8969a_0")
mageck_count <- cwlProcess(baseCommand = c("mageck", "count"),
                           requirements = list(req1),
                           inputs = InputParamList(p1, p2, p3, p4, p5),
                           outputs = OutputParamList(o1))


mageck_count <- addMeta(
    mageck_count,
    label = "mageck_count",
    doc = "Used to quantify guide RNA (gRNA) counts from CRISPR screens",
    inputLabels = c("library","fastq","samples","prefix","conSGRNA"),
    inputDocs = c("A file containing the list of sgRNA names, their sequences and associated genes. Support file format: csv and txt. Provide an empty file for collecting all possible sgRNA counts.","Sample fastq files (or fastq.gz files, or SAM/BAM files after v0.5.5), separated by space; use comma (,) to indicate technical replicates of the same sample.","Sample labels, separated by comma (,). Must be equal to the number of samples provided (in --fastq option).","The prefix of the output file(s). Default sample1.","A list of control sgRNAs for normalization and for generating the null distribution of RRA."),
    outputLabels = c("counts"),
    outputDocs = c("Output count file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://sourceforge.net/p/mageck/wiki/Home/",
        example = paste()
    )
)
