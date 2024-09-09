## featureCounts
## Note: output to current directory
f1 <- InputParam(id = "gtf", type = "File", prefix = "-a")
f2 <- InputParam(id = "count", type = "string", prefix = "-o")
f3 <- InputParam(id = "bam", type = "File")
o1 <- OutputParam(id = "Count", type = "File", glob = "$(inputs.count)", secondaryFiles = ".summary")

req1 <- requireDocker("quay.io/biocontainers/subread:2.0.6--he4a0461_0")
featureCounts <- cwlProcess(baseCommand = "featureCounts",
                            arguments = list("-p", "--countReadPairs"),
                            requirements = list(req1),
                            inputs = InputParamList(f1, f2, f3),
                            outputs = OutputParamList(o1))



featureCounts <- addMeta(
    featureCounts,
    label = "featureCounts",
    doc = "Feature count is a program that counts how many reads map to genomic features, such as genes, exon, promoter and genomic bins",
    inputLabels = c("gtf","count","bam"),
    inputDocs = c("Name of an annotation file. GTF/GFF format by default. See -F option for more format information. Inbuilt annotations (SAF format) is available in 'annotation' directory of the package. Gzipped file is also accepted.","Name of the output file including read counts. A separate file including summary statistics of counting results is also included in the output ('<string>.summary')","Input bam file"),
    outputLabels = c("Count"),
    outputDocs = c("Count file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/toghrulb/subread",
        example = paste()
    )
)
