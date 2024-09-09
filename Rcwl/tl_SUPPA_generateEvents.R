p1 <- InputParam(id = "gtf", type = "File", prefix = "-i")
p2 <- InputParam(id = "outfile", type = "string", prefix = "-o", default = "event")
p3 <- InputParam(id = "events", type = "string", prefix = "-e",
                 shellQuote = FALSE, default = "SE SS MX RI FL")
p4 <- InputParam(id = "format", type = "string", prefix = "-f",
                 default = "ioe")
o1 <- OutputParam(id = "outGTF", type = "File[]", glob = "$(inputs.outfile)_*_strict.gtf")
o2 <- OutputParam(id = "outIOE", type = "File[]", glob = "$(inputs.outfile)_*_strict.ioe")
req1 <- list(class = "DockerRequirement",
             dockerPull = "hubentu/suppa")
req2 <- list(class = "ShellCommandRequirement")
SUPPA_generateEvents <-
    cwlProcess(baseCommand = c("python", "/opt/SUPPA/suppa.py", "generateEvents"),
             requirements = list(req1, req2),
             inputs = InputParamList(p1, p2, p3, p4),
             outputs = OutputParamList(o1, o2))


SUPPA_generateEvents <- addMeta(
    SUPPA_generateEvents,
    label = "SUPPA_generateEvents",
    doc = "identify and catalog all potential alternative splicing events in a given transcriptome based on a gene annotation file",
    inputLabels = c("gtf","outfile","events","format"),
    inputDocs = c("specify input file","specify output path and name without extension","list of events to analyze. (space separated) Options: SE -- Skipping Exon SS -- Alternative Splice Site (5'/3') MX -- Mutually Exclusive Exon RI -- Retained Intron FL -- Alternative First/Last Exon","Format of the annotation file. Required."),
    outputLabels = c("outGTF","outIOE"),
    outputDocs = c("intermediate outputs that contain filtered or reformatted versions of the input GTF file","files listing all detected alternative splicing events in the transcriptome."),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/comprna/SUPPA",
        example = paste()
    )
)
