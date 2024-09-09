## STAR
## Note: output to current dir
## readFilesIn must be full path ##string
p1 <- InputParam(id = "prefix", type = "string", prefix = "--outFileNamePrefix")
p2 <- InputParam(id = "readFilesIn", type = "File[]", prefix = "--readFilesIn")
p3 <- InputParam(id = "genomeDir", type = "Directory", prefix = "--genomeDir")
p4 <- InputParam(id = "sjdbGTFfile", type = "File", prefix = "--sjdbGTFfile")
p5 <- InputParam(id = "runThreadN", type = "int", prefix = "--runThreadN", default = 1L)
p6 <- InputParam(id = "readFileCommand", type = "string",
                 prefix = "--readFilesCommand", default = "zcat")
o1 <- OutputParam(id = "outBAM", type = "File", glob = "*.bam")
o2 <- OutputParam(id = "outLog", type = "File", glob = "*Log.final.out")
o3 <- OutputParam(id = "outCount", type = "File", glob = "*ReadsPerGene.out.tab")

req1 <- list(class = "DockerRequirement",
             dockerPull = "quay.io/biocontainers/star:2.7.9a--h9ee0642_0")
STAR <- cwlProcess(baseCommand = "STAR",
                 requirements = list(req1),
                 arguments = list("--outSAMunmapped", "Within",
                                  "--outSAMstrandField", "intronMotif",
                                  "--outSAMtype", "BAM", "SortedByCoordinate",
                                  "--twopassMode", "Basic",
                                  "--quantMode", "GeneCounts"),
                 inputs = InputParamList(p1, p2, p3, p4, p5, p6),
                 outputs = OutputParamList(o1, o2, o3))


STAR <- addMeta(
    STAR,
    label = "STAR",
    doc = "RNA-seq read aligner designed specifically for aligning RNA sequencing (RNA-seq) reads to a reference genome.",
    inputLabels = c("prefix","readFilesIn","genomeDir","sjdbGTFfile","runThreadN","readFileCommand"),
    inputDocs = c("Output filr prefix","Input files","Path of the genoem file","specifies the path to the file with annotated transcripts in the standard GTF format.","number of threads to be used for genome generation,","command line to execute for each of the input file. This command should generate FASTA or FASTQ text and send it to stdout"),
    outputLabels = c("outBAM","outLog","outCount"),
    outputDocs = c("Aligned Bam file","detailed logs providing statistics and metrics about the alignment process.","reads mapped to each gene"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/alexdobin/STAR",
        example = paste()
    )
)
