p1 <- InputParam(id = "bam", type = "File", position = 99)
p2 <- InputParam(id = "format", type = "boolean?", prefix = "--bam")
p3 <- InputParam(id = "paired", type = "boolean?", prefix = "--paired")
p4 <- InputParam(id = "outdir", type = "string?", prefix = "--output_dir")
o1 <- OutputParam(id = "dbam", type = "File", glob = "*.deduplicated.bam")
req1 <- requireDocker("quay.io/biocontainers/bismark:0.23.1--hdfd78af_0")
deduplicate_bismark <- cwlProcess(baseCommand = "deduplicate_bismark",
                                  requirements = list(req1),
                                  inputs = InputParamList(p1, p2, p3, p4),
                                  outputs = OutputParamList(o1))


deduplicate_bismark <- addMeta(
    deduplicate_bismark,
    label = "deduplicate_bismark",
    doc = "This script is supposed to remove alignments to the same position in the genome from the Bismark mapping output (both single and paired-end SAM/BAM files), which can arise by e.g. excessive PCR amplification.",
    inputLabels = c("bam","format","paired","outdir"),
    inputDocs = c("Input bam file","The output will be written out in BAM format.","deduplicate paired-end BAM/SAM Bismark files. Default: [AUTO-DETECT]","Output directory, either relative or absolute. Output is written to the current directory if not specified explicitly."),
    outputLabels = c("dbam"),
    outputDocs = c("deduplicated file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/FelixKrueger/Bismark",
        example = paste()
    )
)
