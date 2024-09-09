## Ref: https://github.com/alexdobin/STAR/blob/master/docs/STARsolo.md

p1 <- InputParam(id = "readFilesIn_cdna", type = "File[]", prefix = "--readFilesIn",
                 position = 1, itemSeparator = ",")
p2 <- InputParam(id = "readFilesIn_cb", type = "File[]", position = 2, itemSeparator = ",")
p3 <- InputParam(id = "genomeDir", type = "Directory", prefix = "--genomeDir")
p4 <- InputParam(id = "whiteList", type = "File", prefix = "--soloCBwhitelist")
p5 <- InputParam(id = "soloType", type = "string", prefix = "--soloType",
                 default = "Droplet")
p6 <- InputParam(id = "soloUMIlen", type = "string", prefix = "--soloUMIlen",
                 default = "12")
p7 <- InputParam(id = "soloCellFilter", type = "string", prefix = "--soloCellFilter")
p8 <- InputParam(id = "outSAMattributes", type = "string[]", prefix = "outSAMattributes",
                 default = list("NH", "HI", "nM", "AS", "CR", "UR", "CB", "UB", "GX", "GN", "sS", "sQ", "sM"))
p9 <- InputParam(id = "readFilesCommand", type = "string", prefix = "--readFilesCommand",
                 default = "zcat")
p10 <- InputParam(id = "runThreadN", type = "int", prefix = "--runThreadN", default = 1L)

o1 <- OutputParam(id = "outAlign", type = "File", glob = "*.bam")
o2 <- OutputParam(id = "outLog", type = "File[]", glob = "Log*")
o3 <- OutputParam(id = "SJ", type = "File", glob = "SJ.out.tab")
o4 <- OutputParam(id = "Solo", type = "Directory", glob = "Solo.out")

STARsolo <- cwlProcess(baseCommand = "STAR",
                       requirements = list(requireDocker("quay.io/biocontainers/star:2.7.10a--h9ee0642_0")),
                       arguments = list(## "--outSAMunmapped", "Within",
                           "--outSAMtype", "BAM", "SortedByCoordinate",
                           "--soloUMIfiltering", "MultiGeneUMI",
                           "--soloCBmatchWLtype", "1MM_multi_pseudocounts"),
                       inputs = InputParamList(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10),
                       outputs = OutputParamList(o1, o2, o3, o4))



STARsolo <- addMeta(
    STARsolo,
    label = "STARsolo",
    doc = "STARsolo is a turnkey solution for analyzing droplet single cell RNA sequencing data (e.g. 10X Genomics Chromium System) built directly into STAR code.",
    inputLabels = c("readFilesIn_cdna","readFilesIn_cb","genomeDir","whiteList","soloType","soloUMIlen","soloCellFilter","outSAMattributes","readFilesCommand","runThreadN"),
    inputDocs = c("paths to files that contain input read1 (and, if needed, read2)","specific input file(s) containing the cell barcodes","specifies path to the genome directory where genome indices where generated","The 10X Chromium whitelist file can be found inside the CellRanger distribution","type of single-cell RNA-seq","UMI length","Which cells are retained in the final output based on criteria","a string of desired SAM attributes, in the order desired for the output SAM",": command line to execute for each of the input file. This command should generate FASTA or FASTQ text and send it to stdout","number of threads to run STAR"),
    outputLabels = c("outAlign","outLog","SJ","Solo"),
    outputDocs = c("Alignment file","Detailed metrics on read processing, alignment quality, and filtering results.","Details splice junctions detected","Provides additional metrics related to barcode detection and UMI processing."),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/alexdobin/STAR/blob/master/docs/STARsolo.md",
        example = paste()
    )
)
