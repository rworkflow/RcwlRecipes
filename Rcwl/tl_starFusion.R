## STAR Fusion
## https://github.com/STAR-Fusion/STAR-Fusion/wiki
p1 <- InputParam(id = "fq1", type = "File", prefix = "--left_fq")
p2 <- InputParam(id = "fq2", type = "File?", prefix = "--right_fq")
p3 <- InputParam(id = "genomedir", type = "Directory", prefix = "--genome_lib_dir")
p4 <- InputParam(id = "odir", type = "string", prefix = "--output_dir")
p5 <- InputParam(id = "cpu", type = "int", prefix = "--CPU")
o1 <- OutputParam(id = "sout", type = "Directory", glob = "$(inputs.odir)")
req1 <- list(class = "DockerRequirement",
             dockerPull = "trinityctat/starfusion")
starFusion <- cwlProcess(baseCommand = "/usr/local/src/STAR-Fusion/STAR-Fusion",
                       requirements = list(req1),
                       inputs = InputParamList(p1, p2, p3, p4, p5),
                                              outputs = OutputParamList(o1))


starFusion <- addMeta(
    starFusion,
    label = "starFusion",
    doc = "STAR-Fusion uses the STAR aligner to identify candidate fusion transcripts supported by Illumina reads.",
    inputLabels = c("fq1","fq2","genomedir","odir","cpu"),
    inputDocs = c("Specifies the left (or single-end) FASTQ file for the RNA-seq reads.","Specifies the right FASTQ file for paired-end RNA-seq reads.","directory containing the STAR-Fusion precompiled reference files, which include the STAR genome index, reference annotation, and other files needed for fusion detection.","Specifies the directory where STAR-Fusion will output the results.","Specifies the number of threads to use for the analysis, which can speed up the process."),
    outputLabels = c("sout"),
    outputDocs = c("list of predicted fusion transcripts identified by STAR-Fusion."),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/STAR-Fusion/STAR-Fusion/wiki",
        example = paste()
    )
)
