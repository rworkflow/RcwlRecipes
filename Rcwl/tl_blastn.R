## blast:v2.2.31_cv2

p1 <- InputParam(id = "ThreadN", type = "int", prefix = "-num_threads")
p2 <- InputParam(id = "Ref", type = "File", prefix = "-db", secondaryFiles = c(".nhr", ".nin", ".nsq"))
p3 <- InputParam(id = "Query", type = "File", prefix = "-query")
p4 <- InputParam(id = "IdenPerc", type = "int", prefix = "-perc_identity")
p5 <- InputParam(id = "WordSize", type = "int", prefix = "-word_size")
p6 <- InputParam(id = "Evalue", type = "float", prefix = "-evalue")
p7 <- InputParam(id = "OutFormat", type = "int", prefix = "-outfmt")
p8 <- InputParam(id = "OutFile", type = "string", prefix = "-out")
o1 <- OutputParam(id = "Output", type = "File", glob = "$(inputs.OutFile)")

req1 <- list(class = "DockerRequirement", 
             dockerPull = "biocontainers/blast:v2.2.31_cv2")
blastn <- cwlProcess(baseCommand = "blastn",
                   requirements = list(req1),
                   inputs = InputParamList(p1, p2, p3, p4, p5, p6, p7, p8),
                   outputs = OutputParamList(o1))


blastn <- addMeta(
    blastn,
    label = "blastn",
    doc = "BLAST finds regions of similarity between biological sequences. The program compares nucleotide or protein sequences to sequence databases and calculates the statistical significance",
    inputLabels = c("ThreadN","Ref","Query","IdenPerc","WordSize","Evalue","OutFormat","OutFile"),
    inputDocs = c("Number of threads (CPUs) to use in the BLAST search Default = 1","BLAST database name","Input file name","Percent identity","Word size for wordfinder algorithm (length of best perfect match)","Expectation value (E) threshold for saving hits Default = `10'","Output format.alignment view options:0 = pairwise,1 = query-anchored showing identities,2 = query-anchored no identities,3 = flat query-anchored, show identities,4 = flat query-anchored, no identities,5 = XML Blast output,6 = tabular,7 = tabular with comment lines,8 = Text ASN.1,9 = Binary ASN.1,10 = Comma-separated values,11 = BLAST archive format (ASN.1),12 = JSON Seqalign output,13 = JSON Blast output,14 = XML2 Blast output","Output file name"),
    outputLabels = c("Output"),
    outputDocs = c("Blast specified output"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/ncbi/blast_plus",
        example = paste()
    )
)
