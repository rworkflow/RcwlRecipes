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
