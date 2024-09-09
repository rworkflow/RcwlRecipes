## gatk Mutect2
p1a <- InputParam(id = "tbam", type = "File",
                  prefix = "-I", secondaryFiles = ".bai")
p1b <- InputParam(id = "nbam", type = "File?",
                  prefix = "-I", secondaryFiles = ".bai")
p2 <- InputParam(id = "Ref", prefix = "-R", type = "File",
                 secondaryFiles = list(".fai", "^.dict"))
p3 <- InputParam(id = "normal", type = "string?", prefix = "-normal")
p4 <- InputParam(id = "germline", type = "File?", prefix = "--germline-resource",
                 secondaryFiles = "$(self.nameext == '.gz' ? self.basename+'.tbi' : self.basename+'.idx')")
p5 <- InputParam(id = "pon", type = "File?", prefix = "--panel-of-normals",
                 secondaryFiles = "$(self.nameext == '.gz' ? self.basename+'.tbi' : self.basename+'.idx')")
p6 <- InputParam(id = "interval", type = "File?", prefix = "-L")
p7 <- InputParam(id = "out", type = "string", prefix = "-O")
p8 <- InputParam(id = "f1r2", type = "string?", prefix = "--f1r2-tar-gz",
                 default = "f1r2.tar.gz")
p9 <- InputParam(id = "threads", type = "int?", prefix = "--native-pair-hmm-threads")
o1 <- OutputParam(id = "vout", type = "File", glob = "$(inputs.out)",
                  secondaryFiles = c(".idx", ".stats"))
o2 <- OutputParam(id = "F1r2", type = "File", glob = "$(inputs.f1r2)")
req1 <- requireDocker("broadinstitute/gatk:latest")
req2 <- requireJS()
Mutect2 <- cwlProcess(cwlVersion = "v1.0",
                      baseCommand = c("gatk", "Mutect2"),
                      requirements = list(req1, req2),
                      inputs = InputParamList(p1a, p1b, p2, p3, p4, p5, p6, p7, p8, p9),
                      outputs = OutputParamList(o1, o2))


Mutect2 <- addMeta(
    Mutect2,
    label = "Mutect2",
    doc = "Call somatic SNVs and indels via local assembly of haplotypes GATK4",
    inputLabels = c("tbam","nbam","Ref","normal","germline","pon","interval","out","f1r2","threads"),
    inputDocs = c("Tumer BAM/SAM/CRAM file containing reads This argument must be specified at least once.Required.","Normal BAM/SAM/CRAM file containing reads This argument must be specified at least once.Required.","Reference sequence file Required.","BAM sample name of normal(s), if any. May be URL-encoded as output by GetSampleName with -encode argument. This argument may be specified 0 or more times. Default value: null.","Population vcf of germline sequencing containing allele fractions. Default value: null.","VCF file of sites observed in normal. Default value: null.","One or more genomic intervals over which to operate This argument may be specified 0 or more times. Default value: null.","File to which variants should be written Required.","If specified, collect F1R2 counts and output files into this tar.gz file Default value:null.","How many threads should a native pairHMM implementation use Default value: 4."),
    outputLabels = c("vout","F1r2"),
    outputDocs = c("Variant annotated file","F1R2 counts file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/broadinstitute/gatk",
        example = paste()
    )
)
