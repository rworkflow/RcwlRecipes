## CollectSequencingArtifactMetrics
p1 <- InputParam(id = "bam", type = "File", prefix = "-I")
p2 <- InputParam(id = "ref", type = "File", prefix = "-R")
p3 <- InputParam(id = "ext", type = "string", prefix = "--FILE_EXTENSION", default = ".txt")
p4 <- InputParam(id = "art", type = "string", prefix = "-O")
o1 <- OutputParam(id = "aout", type = "File",
                  glob = "$(inputs.art).pre_adapter_detail_metrics.txt")
req1 <- list(class = "DockerRequirement",
             dockerPull = "broadinstitute/gatk:latest")

ColSeqArtifact <- cwlProcess(baseCommand = c("gatk",
                                           "CollectSequencingArtifactMetrics"),
                           requirements = list(req1),
                           inputs = InputParamList(p1, p2, p3, p4),
                           outputs = OutputParamList(o1))


ColSeqArtifact <- addMeta(
    ColSeqArtifact,
    label = "ColSeqArtifact",
    doc = "Collect metrics to quantify single-base sequencing artifacts.",
    inputLabels = c("bam","ref","ext","art"),
    inputDocs = c("Input SAM/BAM/CRAM file. Required.","Reference sequence file. Required.","Append the given file extension to all metric file names (ex.OUTPUT.pre_adapter_summary_metrics.EXT). None if null Default value: null.","The file to write the output to. Required."),
    outputLabels = c("aout"),
    outputDocs = c("Output of ColSeqArtifact"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/broadinstitute/gatk",
        example = paste()
    )
)
