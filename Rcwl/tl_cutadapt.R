## Cutadapt
## Work for paired-end reads
## Input files need to be in one of these formats: 
##   - FASTA with extensions: .fasta, .fa or .fna
##   - FASTQ with extensions: .fastq or .fq
##   - Any of the above, but compressed as .gz, .bz2 or .xz

## req1 <- list(class = "DockerRequirement", 
##              dockerPull = "kfdrc/cutadapt")
req1 <- requireDocker("quay.io/biocontainers/cutadapt:4.2--py310h1425a21_0")

p1 <- InputParam(id = "threadN", type = "int?", prefix = "-j", position = 1, default = 1L)
p2a <- InputParam(id = "adapter1a", type = "string?", prefix = "-a", position = 2)
p2b <- InputParam(id = "adapter2a", type = "string?", prefix = "-A", position = 3)
p2c <- InputParam(id = "adapter1g", type = "string?", prefix = "-g", position = 4)
p2d <- InputParam(id = "adapter2g", type = "string?", prefix = "-G", position = 5)
p2e <- InputParam(id = "adapter1b", type = "string?", prefix = "-b", position = 6)
p2f <- InputParam(id = "adapter2b", type = "string?", prefix = "-B", position = 7)
p3 <- InputParam(id = "out1prefix", type = "string", prefix = "-o", position = 8)
p4 <- InputParam(id = "out2prefix", type = "string?", prefix = "-p", position = 9)
p5 <- InputParam(id = "in1", type = "File", position = 99)
p6 <- InputParam(id = "in2", type = "File?", position = 100)
o1 <- OutputParam(id = "out1", type = "File", glob = "$(inputs.out1prefix)")
o2 <- OutputParam(id = "out2", type = "File?", glob = "$(inputs.out2prefix)")

cutadapt <- cwlProcess(baseCommand = "cutadapt", 
                         requirements = list(req1),
                         inputs = InputParamList(p1, p2a, p2b, p2c, p2d, p2e, p2f, p3, p4, p5, p6), 
                         outputs = OutputParamList(o1, o2))


cutadapt <- addMeta(
    cutadapt,
    label = "cutadapt",
    doc = "Cutadapt Work for paired-end reads Input files need to be in one of these formats: - FASTA with extensions: .fasta, .fa or .fna - FASTQ with extensions: .fastq or .fq - Any of the above, but compressed as .gz, .bz2 or .xz req1 <- list(class = 'DockerRequirement', dockerPull = 'kfdrc/cutadapt')",
    inputLabels = c("threadN","adapter1a","adapter2a","adapter1g","adapter2g","adapter1b","adapter2b","out1prefix","out2prefix","in1","in2"),
    inputDocs = c("Number of CPU cores to use. Use 0 to auto-detect.Default: 1","Sequence of an adapter ligated to the 3' end (paired data: of the first read). The adapter and subsequent bases are trimmed. If a '$' character is appended ('anchoring'), the adapter is only found if it is a suffix of the read.","3' adapter to be removed from second read in a pair.","Sequence of an adapter ligated to the 5' end (paired data: of the first read). The adapter and any preceding bases are trimmed. Partial matches at the 5' end are allowed. If a '^' character is prepended ('anchoring'), the adapter is only found if it is a prefix of the read.","5' adapter to be removed from second read in a pair.","Sequence of an adapter that may be ligated to the 5' or 3' end (paired data: of the first read). Both types of matches as described under -a und -g are allowed. If the first base of the read is part of the match, the behavior is as with -g, otherwise as with -a. This option is mostly for rescuing failed library preparations - do not use if you know which end your adapter was ligated to!","5'/3 adapter to be removed from second read in a pair.","Write trimmed reads to FILE. FASTQ or FASTA format is chosen depending on input. Summary report is sent to standard output. Use '{name}' for demultiplexing (see docs). Default: write to standard output","Write second read in a pair to FILE.","first fastq file","second fastq file"),
    outputLabels = c("out1","out2"),
    outputDocs = c("modified first fastq file","modified second fastq file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/marcelm/cutadapt",
        example = paste()
    )
)
