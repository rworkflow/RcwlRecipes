p1 <- InputParam(id = "countTable", type = "File", prefix = "-k")
p2 <- InputParam(id = "desgin", type = "File?", prefix = "-d")
p3 <- InputParam(id = "day0", type = "string?", prefix = "--day0-label")
p4 <- InputParam(id = "prefix", type = "string", prefix = "-n")
p5 <- InputParam(id = "conSGRNA", type = "File?", prefix = "--control-sgrna")
o1 <- OutputParam(id = "mout", type = "File[]", glob = "$(inputs.prefix)*")

req1 <- requireDocker("quay.io/biocontainers/mageck:0.5.9.4--py38hed8969a_0")
mageck_mle <- cwlProcess(baseCommand = c("mageck", "mle"),
                         requirements = list(req1),
                         inputs = InputParamList(p1, p2, p3, p4, p5),
                         outputs = OutputParamList(o1))


mageck_mle <- addMeta(
    mageck_mle,
    label = "mageck_mle",
    doc = "Estimates gene effects and their significance in each condition for multiple CRISPR experimental conditions or groups",
    inputLabels = c("countTable","desgin","day0","prefix","conSGRNA"),
    inputDocs = c("Provide a tab-separated count table. Each line in the table should include sgRNA name (1st column), target gene (2nd column) and read counts in each sample.","Provide a design matrix, either a file name or a quoted string of the design matrix. For example, '1,1;1,0'. The row of the design matrix must match the order of the samples in the count table (if --include- samples is not specified), or the order of the samples by the --include-samples option.","Specify the label for control sample (usually day 0 or plasmid). For every other sample label, the MLE module will treat it as a single condition and generate an corresponding design matrix.","The prefix of the output file(s). Default sample1.","A list of control sgRNAs for normalization and for generating the null distribution of RRA."),
    outputLabels = c("mout"),
    outputDocs = c("Output files"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://sourceforge.net/p/mageck/wiki/Home/",
        example = paste()
    )
)
