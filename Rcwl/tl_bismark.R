p1 <- InputParam(id = "genome", type = "Directory", prefix = "--genome")
p2 <- InputParam(id = "fq1", type = list("File", "File[]"), prefix = "-1", itemSeparator=",")
p3 <- InputParam(id = "fq2", type = list("File", "File[]"), prefix = "-2", itemSeparator=",")
p4 <- InputParam(id = "sam", type = "boolean?", prefix = "--sam")
p5 <- InputParam(id = "threads", type = "int?", prefix = "-p")
o1 <- OutputParam(id = "align", type = "File", glob = "*_bismark_bt2_pe.*")
o2 <- OutputParam(id = "report", type = "File", glob = "*_report.txt")
req1 <- requireDocker("quay.io/biocontainers/bismark:0.23.1--hdfd78af_0")
bismark <- cwlProcess(cwlVersion = "v1.2",
                      baseCommand = "bismark",
                      arguments = list("-o", "./"),
                      requirements = list(req1),
                      inputs = InputParamList(p1, p2, p3, p4, p5),
                      outputs = OutputParamList(o1, o2))


bismark <- addMeta(
    bismark,
    label = "bismark",
    doc = "Bismark is a set of tools for the time-efficient analysis of Bisulfite-Seq (BS-Seq) data. Bismark performs alignments of bisulfite-treated reads to a reference genome and cytosine methylation calls at the same time.",
    inputLabels = c("genome","fq1","fq2","sam","threads"),
    inputDocs = c("The path to the folder containing the unmodified reference genome as well as the subfolders created by the Bismark_Genome_Preparation script","Paired input fastq file 1","Paired input fastq file 2","The output will be written out in SAM format instead of the default BAM format.","Launch NTHREADS parallel search threads (default: 1)."),
    outputLabels = c("align","report"),
    outputDocs = c("Aligned bam.sam file","report file detailing alignment and methylation call statistics"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/FelixKrueger/Bismark",
        example = paste()
    )
)
