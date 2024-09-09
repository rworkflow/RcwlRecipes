p1 <- InputParam(id = "index", type = "File", prefix = "-f")
p2 <- InputParam(id = "paired", type = "boolean?", prefix = "-2")
p3 <- InputParam(id = "out", type = "string", prefix = "-o")
p4 <- InputParam(id = "sam", type = "File", position = 10)
o1 <- OutputParam(id = "mbam", type = "File", glob = "$(inputs.out).sorted.markdup.bam")
o2 <- OutputParam(id = "dbam", type = "File", glob = "$(inputs.out).sorted.dedup.bam")
o3 <- OutputParam(id = "report", type = "File", glob = "*log.txt")
req1 <- requireDocker("quay.io/biocontainers/nudup:2.3.3--py_2")
nudup <- cwlProcess(baseCommand = "nudup.py",
                    requirements = list(req1),
                    inputs = InputParamList(p1, p2, p3, p4),
                    outputs = OutputParamList(o1, o2, o3))


nudup <- addMeta(
    nudup,
    label = "nudup",
    doc = "Marks/removes PCR introduced duplicate molecules based on the molecular tagging technology used in NuGEN products.",
    inputLabels = c("index","paired","out","sam"),
    inputDocs = c("FASTQ file containing the molecular tag sequence for each read name in the corresponding SAM/BAM file (required only for CASE 1 detailed above)","use paired end deduping with template. SAM/BAM alignment must contain paired end reads. Degenerate read pairs (alignments for one read of pair) will be discarded.","prefix of output file paths for sorted BAMs (default will create prefix.sorted.markdup.bam, prefix.sorted.dedup.bam, prefix_dup_log.txt)","Input sam file"),
    outputLabels = c("mbam","dbam","report"),
    outputDocs = c("Marked duplicate bam file","Deduplicated bam file","final reoprt"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/CGATOxford/nudup",
        example = paste()
    )
)
