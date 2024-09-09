## http://useast.ensembl.org/info/docs/tools/vep/script/index.html
p1 <- InputParam(id = "ivcf", type = "File", prefix = "--input_file")
p2 <- InputParam(id = "ovcf", type = "string", prefix = "--output_file")
p3 <- InputParam(id = "ref", type = "File", prefix = "--fasta", secondaryFiles = ".fai")
p4 <- InputParam(id = "cacheDir", type = "Directory", prefix = "--dir_cache")
p5 <- InputParam(id = "version", type = "string", prefix = "--cache_version")
p6 <- InputParam(id = "merged", type = "boolean?", prefix = "--merged")
p7 <- InputParam(id = "species", type = "string?", prefix = "--species")
o1 <- OutputParam(id = "oVcf", type = "File", glob = "$(inputs.ovcf)")

req1 <- requireDocker("ensemblorg/ensembl-vep")
ht1 <- list("cwltool:LoadListingRequirement"=
                list(loadListing = "no_listing"))
ext <- list("$namespaces" = list(cwltool = "http://commonwl.org/cwltool#"))
vep <- cwlProcess(baseCommand = "vep",
                requirements = list(req1),
                hints = ht1,
                arguments = list("--format", "vcf", "--vcf", "--cache", "--symbol", "--offline"),
                inputs = InputParamList(p1, p2, p3, p4, p5, p6, p7),
                outputs = OutputParamList(o1),
                extensions = ext)


vep <- addMeta(
    vep,
    label = "vep",
    doc = "Tool developed by the Ensembl project that is used to annotate genetic variants with information about their potential functional effects on genes, transcripts, and protein sequences.",
    inputLabels = c("ivcf","ovcf","ref","cacheDir","version","merged","species"),
    inputDocs = c("Input file","Output file","path to the FASTA file of the reference genome.","Specifies the directory where VEP will look for or store its cache files.","Indicates the version of the Ensembl cache to use.","Instructs VEP to use the merged Ensembl/Havana cache, which includes gene models from both Ensembl and Havana (now part of GENCODE).","Specifies the species for which the variants are being annotated."),
    outputLabels = c("oVcf"),
    outputDocs = c("Annotated vcf file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "http://useast.ensembl.org/info/docs/tools/vep/script/index.html",
        example = paste()
    )
)
