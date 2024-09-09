## http://useast.ensembl.org/info/docs/tools/vep/script/index.html
p1 <- InputParam(id = "ivcf", type = "File", prefix = "--input_file")
p2 <- InputParam(id = "ovcf", type = "string", prefix = "--output_file")
p3 <- InputParam(id = "ref", type = "File", prefix = "--fasta", secondaryFiles = ".fai")
p4 <- InputParam(id = "cacheDir", type = "Directory", prefix = "--dir_cache")
o1 <- OutputParam(id = "oVcf", type = "File", glob = "$(inputs.ovcf)")
    
req1 <- list(class = "DockerRequirement",
             dockerPull = "hubentu/ensembl-vep-plugins")
ht1 <- list("cwltool:LoadListingRequirement"=
                list(loadListing = "no_listing"))
ext <- list("$namespaces" = list(cwltool = "http://commonwl.org/cwltool#"))
vep_plugin <- cwlProcess(baseCommand = "vep",
                requirements = list(req1),
                hints = ht1,
                arguments = list("--format", "vcf", "--vcf",
                                 "--symbol", "--terms", "SO",
                                 "--tsl", "--hgvs", "--offline",
                                 "--dir_plugins", "/opt/vep/src/VEP_plugins",
                                 "--plugin", "Downstream",
                                 "--plugin", "Wildtype"),
                inputs = InputParamList(p1, p2, p3, p4),
                outputs = OutputParamList(o1),
                extensions = ext)


vep_plugin <- addMeta(
    vep_plugin,
    label = "vep_plugin",
    doc = "VEP plugins provide additional annotations and extend the functionality of the VEP tool.",
    inputLabels = c("ivcf","ovcf","ref","cacheDir"),
    inputDocs = c("Input VCF file","Name of output fie","Reference file","Specifies the directory where VEP will look for or store its cache files."),
    outputLabels = c("oVcf"),
    outputDocs = c("Output vcf file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "http://useast.ensembl.org/info/docs/tools/vep/script/index.html",
        example = paste()
    )
)
