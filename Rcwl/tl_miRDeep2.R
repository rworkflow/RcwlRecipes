## https://github.com/rajewsky-lab/mirdeep2
## miRDeep2.pl reads genome mappings miRNAs_ref/none miRNAs_other/none precursors/none [options] 2>report.log

p1 <- InputParam(id = "reads", type = "File", position = 1)
p2 <- InputParam(id = "genome", type = "File", position = 2)
p3 <- InputParam(id = "mappings", type = "File", position = 3)
p4 <- InputParam(id = "miRef", type = list("File", "string"),
                 position = 4, default = "none")
p5 <- InputParam(id = "miOther", type = list("File", "string"),
                 position = 5, default = "none")
p6 <- InputParam(id = "precursors", type = list("File", "string"),
                 position = 6, default = "none")
p7 <- InputParam(id = "species", type = "string",
                 prefix = "-t", position = 7)
o1 <- OutputParam(id = "csvfiles", type = "File[]", glob = "*.csv")
o2 <- OutputParam(id = "htmls", type = "File[]", glob = "*.html")
o3 <- OutputParam(id = "bed", type = "File", glob = "*.bed")
o4 <- OutputParam(id = "expression", type = "Directory", glob = "expression_analyses")
o5 <- OutputParam(id = "mirna_results", type = "Directory", glob = "mirna_results*")
o6 <- OutputParam(id = "pdfs", type = "Directory", glob = "pdf*")
req1 <- list(class = "DockerRequirement",
             dockerPull = "hubentu/mirdeep2")
miRDeep2 <- cwlProcess(baseCommand = "miRDeep2.pl",
                     requirements = list(req1),
                     inputs = InputParamList(p1, p2, p3, p4, p5, p6, p7),
                     outputs = OutputParamList(o1, o2, o3, o4, o5, o6))


miRDeep2 <- addMeta(
    miRDeep2,
    label = "miRDeep2",
    doc = "miRDeep2 discovers active known or novel miRNAs from deep sequencing data",
    inputLabels = c("reads","genome","mappings","miRef","miOther","precursors","species"),
    inputDocs = c("deep sequences in fasta format. The identifier should contain a prefix, a running number and a '_x' to indicate the number of reads that have this sequence.There should be no redundancy in the sequences.","genome contigs in fasta format. The identifiers should be unique.","file_reads mapped against file_genome. The mappings should be in arf format.For details on the format see the documentation.","miRBase miRNA sequences in fasta format. These should be the known mature sequences for the species being analyzed.","miRBase miRNA sequences in fasta format. These should be the pooled known mature sequences for 1-5 species closely related to the species being analyzed.","miRBase miRNA precursor sequences in fasta format. These should be the known precursor sequences for the species being analyzed.","species being analyzed - this is used to link to the appropriate UCSC browser entry"),
    outputLabels = c("csvfiles","htmls","bed","expression","mirna_results","pdfs"),
    outputDocs = c("spread-sheet format of results.html","a html table giving an overview of novel and known miRNAs detected in the data. The table is hyperlinked to pdfs showing the signature and structure of each hairpin.","miRNA bed file","Files containing the expression levels of known miRNAs.","miRNA result","PDF files illustrating the predicted hairpin secondary structures of the novel miRNA precursors."),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/rajewsky-lab/mirdeep2",
        example = paste()
    )
)
