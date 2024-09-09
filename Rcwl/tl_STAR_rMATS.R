## STAR
## Note: output to current dir
p1 <- InputParam(id = "prefix", type = "string", prefix = "--outFileNamePrefix")
p2 <- InputParam(id = "readFilesIn", type = "File[]", prefix = "--readFilesIn")
p3 <- InputParam(id = "genomeDir", type = "Directory", prefix = "--genomeDir")
p4 <- InputParam(id = "sjdbGTFfile", type = "File", prefix = "--sjdbGTFfile")
p5 <- InputParam(id = "runThreadN", type = "int", prefix = "--runThreadN", default = 1L)
p6 <- InputParam(id = "readFilesCommand", type = "string?", prefix = "--readFilesCommand")
p7 <- InputParam(id = "twopass", type = "string?", prefix = "--twopassMode")
p8 <- InputParam(id = "chimSegmentMin", type = "int?", prefix = "--chimSegmentMin")
p9 <- InputParam(id = "outFilterMismatchNmax", type = "int?", prefix = "--outFilterMismatchNmax")
p10 <- InputParam(id = "alignIntronMax", type = "int?", prefix = "--alignIntronMax")
p11 <- InputParam(id = "alignSJDBoverhangMin", type = "int?", prefix = "--alignSJDBoverhangMin")
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
                                  "--quantMode", "GeneCounts"),
                 inputs = InputParamList(p1, p2, p3, p4, p5,
                                         p6, p7, p8, p9, p10, p11),
                 outputs = OutputParamList(o1, o2, o3))


STAR <- addMeta(
    STAR,
    label = "STAR",
    doc = "STAR (Spliced Transcripts Alignment to a Reference) aligner that is tailored to work with rMATS (RNA-seq Multivariate Analysis of Transcript Splicing),",
    inputLabels = c("prefix","readFilesIn","genomeDir","sjdbGTFfile","runThreadN","readFilesCommand","twopass","chimSegmentMin","outFilterMismatchNmax","alignIntronMax","alignSJDBoverhangMin"),
    inputDocs = c("output files name prefix (including full or relative path). Can only be defined on the command line.","paths to files that contain input read1 (and, if needed, read2)","path to the directory where genome files are stored","path to the GTF file with annotations","number of threads to run STAR","command line to execute for each of the input file. This command should generate FASTA or FASTQ text and send it to stdout","2-pass mapping mode.","minimum length of chimeric segment length, if ==0, no chimeric output","maximum number of mismatches per pair, large number switches off this filter","maximum intron size, if 0, max intron size will be determined by (2ˆwinBinNbits)*winAnchorDistNbins","minimum overhang for annotated junctions"),
    outputLabels = c("outBAM","outLog","outCount"),
    outputDocs = c("Aligned Bam file","detailed logs providing statistics and metrics about the alignment process.","reads mapped to each gene"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/alexdobin/STAR",
        example = paste()
    )
)
