p1 <- InputParam(id = "countTable", type = "File", prefix = "-k")
p2 <- InputParam(id = "treat", type = "string[]?",
                 prefix = "-t", itemSeparator = ",")
p3 <- InputParam(id = "control", type = "string[]?",
                 prefix = "-c", itemSeparator = ",")
p4 <- InputParam(id = "prefix", type = "string", prefix = "-n")
p5 <- InputParam(id = "conSGRNA", type = "File?", prefix = "--control-sgrna")
p6 <- InputParam(id = "day0", type = "string?", prefix = "--day0-label")
o1 <- OutputParam(id = "touts", type = "File[]", glob = "$(inputs.prefix)*")

req1 <- requireDocker("quay.io/biocontainers/mageck:0.5.9.4--py38hed8969a_0")
mageck_test <- cwlProcess(baseCommand = c("mageck", "test"),
                          requirements = list(req1),
                          inputs = InputParamList(p1, p2, p3, p4, p5, p6),
                          outputs = OutputParamList(o1))


mageck_test <- addMeta(
    mageck_test,
    label = "mageck_test",
    doc = "Designed to analyze CRISPR screen data by comparing the abundance of guide RNAs (gRNAs) targeting each gene between different experimental conditions",
    inputLabels = c("countTable","treat","control","prefix","conSGRNA","day0"),
    inputDocs = c("Provide a tab-separated count table instead of sam files. Each line in the table should include sgRNA name (1st column), gene name (2nd column) and read counts in each sample.","Sample label or sample index (0 as the first sample) in the count table as treatment experiments, separated by comma (,). If sample label is provided, the labels must match the labels in the first line of the count table; for example, 'HL60.final,KBM7.final'. For sample index, '0,2' means the 1st and 3rd samples are treatment experiments.","Sample label or sample index in the count table as control experiments, separated by comma (,). Default is all the samples not specified in treatment experiments.","The prefix of the output file(s). Default sample1.","A list of control sgRNAs for normalization and for generating the null distribution of RRA.","Specify the label for control sample (usually day 0 or plasmid). For every other sample label, the module will treat it as a treatment condition and compare with control sample."),
    outputLabels = c("touts"),
    outputDocs = c("The outputs generated"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://sourceforge.net/p/mageck/wiki/Home/",
        example = paste()
    )
)
