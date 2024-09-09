# https://github.com/Xinglab/rmats-turbo
p1 <- InputParam(id = "bam1", type = "File[]", position = -1)
p2 <- InputParam(id = "bam2", type = "File[]", position = -1)
p3 <- InputParam(id = "type", type = "string", prefix = "-t", default = "paired")
p4 <- InputParam(id = "readLength", type = "int", prefix = "--readLength")
p5 <- InputParam(id = "gtf", type = "File", prefix = "--gtf")
p6 <- InputParam(id = "threads", type = "int?", prefix = "--nthread", default = 1L)
p7 <- InputParam(id = "tstat", type = "int?", prefix = "--tstat")
p8 <- InputParam(id = "tmp", type = "string", prefix = "--tmp", default = "tmp")
p9 <- InputParam(id = "libType", type = "string?", prefix = "--libType")
p10 <- InputParam(id = "varReadLength", type = "boolean?", prefix = "--variable-read-length")
p11 <- InputParam(id = "anchorLength", type = "int?", prefix = "--anchorLength")
p12 <- InputParam(id = "tophatAnchor", type = "int?", prefix = "--tophatAnchor")
p13 <- InputParam(id = "cstat", type = "float?", prefix = "--cstat")
p14 <- InputParam(id = "task", type = "string?", prefix = "--task")
p15 <- InputParam(id = "statoff", type = "boolean?", prefix = "--statoff")
p16 <- InputParam(id = "pairedStats", type = "boolean?", prefix = "--paired-stats")
p17 <- InputParam(id = "novelSS", type = "boolean?", prefix = "--novelSS")
p18 <- InputParam(id = "mil", type = "int?", prefix = "--mil")
p19 <- InputParam(id = "mel", type = "int?", prefix = "--mel")
p20 <- InputParam(id = "allowClipping", type = "boolean?", prefix = "--allow-clipping")
p21 <- InputParam(id = "fixedEvent", type = "Directory?", prefix = "--fixed-event-set")

o1 <- OutputParam(id = "res", type = "File[]", glob = "*.txt")
o2 <- OutputParam(id = "tmp", type = "Directory", glob = "$(inputs.tmp)")
req1 <- requireDocker("xinglab/rmats")
req2 <- requireJS()
req3 <- requireManifest("bam1", sep = ",")
req4 <- requireManifest("bam2", sep = ",")
req5 <- requireInitialWorkDir(listing = list(req3$listing[[1]],
                                             req4$listing[[1]]))
rMATS_bam <- cwlProcess(baseCommand = "",
                      requirements = list(req1, req2, req5),
                      arguments = list("--b1", "bam1", "--b2", "bam2", "--od", "."),
                      inputs = InputParamList(p1, p2, p3, p4, p5, p6, p7, p8, p9,
                                              p10, p11, p12, p13, p14, p15, p16,
                                              p17, p18, p19, p20, p21),
                      outputs = OutputParamList(o1, o2))


rMATS_bam <- addMeta(
    rMATS_bam,
    label = "rMATS_bam",
    doc = "Tool to detect differential alternative splicing events from RNA-Seq data.",
    inputLabels = c("bam1","bam2","type","readLength","gtf","threads","tstat","tmp","libType","varReadLength","anchorLength","tophatAnchor","cstat","task","statoff","pairedStats","novelSS","mil","mel","allowClipping","fixedEvent"),
    inputDocs = c("A text file containing a comma separated list of the BAM files for sample_1. (Only if using BAM)","A text file containing a comma separated list of the BAM files for sample_2. (Only if using BAM)","Type of read used in the analysis: either 'paired' for paired-end data or 'single' for single-end data.Default: paired","The length of each read. Required parameter, with the value set according to the RNA-seq read length","An annotation of genes and transcripts in GTF format","The number of threads. The optimal number of threads should be equal to the number of CPU cores. Default: 1","The number of threads for the statistical model. If not set then the value of --nthread is used","The directory for intermediate output such as '.rmats' files from the prep step","Library type. Use fr-firststrand or fr-secondstrand for strand-specific data. Only relevant to the prep step, not the post step. Default: fr-unstranded","Allow reads with lengths that differ from --readLength to be processed. --readLength will still be used to determine IncFormLen and SkipFormLen","The 'anchor length' or 'overhang length' used when counting the number of reads spanning splice junctions. A minimum number of 'anchor length' nucleotides must be mapped to each end of a given splice junction. The minimum value is 1 and the default value is set to 1 to make use of all possible splice junction reads.","The 'anchor length' or 'overhang length' used in the aligner. At least 'anchor length' nucleotides must be mapped to each end of a given splice junction. The default is 1. (Only if using fastq)","The cutoff splicing difference. The cutoff used in the null hypothesis test for differential alternative splicing. The default is 0.0001 for 0.01% difference. Valid: 0 <= cutoff < 1. Does not apply to the paired stats model","Specify which step(s) of rMATS-turbo to run. Default:both. prep: preprocess BAM files and generate .rmats files. post: load .rmats files into memory, detect and count alternative splicing events, and calculate P value (if not --statoff). both: prep + post. inte (integrity): check that the BAM filenames recorded by the prep task(s) match the BAM filenames for the current command line. stat: run statistical test on existing output files","Skip the statistical analysis","Use the paired stats model","Enable detection of novel splice sites (unannotated splice sites). Default is no detection of novel splice sites","Minimum Intron Length. Only impacts --novels behavior. Default: 50","Maximum Exon Length. Only impacts --novelSS behavior.Default: 500","Allow alignments with soft or hard clipping to be used","A directory containing fromGTF.[AS].txt files to be used instead of detecting a new set of events"),
    outputLabels = c("res","tmp"),
    outputDocs = c("Alternative splice information","temporary file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/Xinglab/rmats-turbo",
        example = paste()
    )
)
