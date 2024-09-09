## https://github.com/google/deepvariant
p1 <- InputParam(id = "bam", type = "File", prefix = "--reads=",
                 secondaryFiles = ".bai", separate = FALSE)
p2 <- InputParam(id = "model", type = "string", prefix = "--model_type=", separate = FALSE)
p3 <- InputParam(id = "ref", type = "File", prefix = "--ref=",
                 secondaryFiles = ".fai", separate = FALSE)
p4 <- InputParam(id = "regions", type = list("File?", "string?"), prefix = "--regions")
p5 <- InputParam(id = "outVcf", type = "string", prefix = "--output_vcf=", separate = FALSE)
p6 <- InputParam(id = "outGVcf", type = "string?", prefix = "--output_gvcf=", separate = FALSE)
p7 <- InputParam(id = "intermediate", type = "string?", prefix = "--intermediate_results_dir")
p8 <- InputParam(id = "cores", type = "int?", prefix = "--num_shards=", separate = FALSE)
o1 <- OutputParam(id = "vcf", type = "File", secondaryFiles = ".tbi", glob = "$(inputs.outVcf)")
o2 <- OutputParam(id = "gvcf", type = "File?", secondaryFiles = ".tbi", glob = "$(inputs.outGVcf)")
o3 <- OutputParam(id = "report", type = "File", glob = "*.html")
o4 <- OutputParam(id = "intdir", type = "Directory?", glob = "$(inputs.intermediate)")

req1 <- requireDocker("google/deepvariant")
deepvariant <- cwlProcess(baseCommand = "/opt/deepvariant/bin/run_deepvariant",
                          requirements = list(req1),
                          inputs = InputParamList(p1, p2, p3, p4, p5, p6, p7, p8),
                          outputs = OutputParamList(o1, o2, o3, o4))


deepvariant <- addMeta(
    deepvariant,
    label = "deepvariant",
    doc = "DeepVariant is a deep learning-based variant caller that takes aligned reads (in BAM or CRAM format), produces pileup image tensors from them, classifies each tensor using a convolutional neural network, and finally reports the results in a standard VCF or gVCF file.",
    inputLabels = c("bam","model","ref","regions","outVcf","outGVcf","intermediate","cores"),
    inputDocs = c("Required. Aligned, sorted, indexed BAM file containing the reads we want to call. Should be aligned to a reference genome compatible with --ref.","Required. Type of model to use for variant calling. Set this flag to use the default model associated with each type, and it will set necessary flags corresponding to each model. If you want to use a customized model, add --customized_model flag in addition to this flag.","Required. Genome reference to use. Must have an associated FAI index as well. Supports text or gzipped references. Should match the reference used to align the BAM file provided to --reads.","Optional. Space-separated list of regions we want to process. Elements can be region literals (e.g., chr20:10-20) or paths to BED/BEDPE files.","Required. Path where we should write VCF file.","Optional. Path where we should write gVCF file.","Optional. If specified, this should be an existing directory that is visible insider docker, and will be used to to store intermediate outputs.","Optional. Number of shards for make_examples step. (default: '1') (an integer)"),
    outputLabels = c("vcf","gvcf","report","intdir"),
    outputDocs = c("Vcf output file","gVcf output file","run-time information and performance metrics","Intermediate files"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/google/deepvariant",
        example = paste()
    )
)
