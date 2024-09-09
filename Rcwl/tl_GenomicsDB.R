## Create a GenomicsDB
p1 <- InputParam(id = "vcf", type = InputArrayParam(prefix = "-V", items = "File"), secondaryFiles = ".idx")
p2 <- InputParam(id = "Ref", prefix = "-R", type = "File", secondaryFiles = c(".fai", "^.dict"))
p3 <- InputParam(id = "db", prefix = "--genomicsdb-workspace-path", type = "string", default = "pon_db")
p4 <- InputParam(id = "intervals", prefix = "-L", type = "File")
o1 <- OutputParam(id = "dbout", type = "Directory", glob = "$(inputs.db)")
req1 <- list(class = "DockerRequirement",
             dockerPull = "broadinstitute/gatk:latest")

GenomicsDB <- cwlProcess(baseCommand = c("gatk", "GenomicsDBImport"),
                       requirements = list(req1),
                       arguments = list("--merge-input-intervals"),
                       inputs = InputParamList(p1, p2, p3, p4),
                       outputs = OutputParamList(o1))


GenomicsDB <- addMeta(
    GenomicsDB,
    label = "GenomicsDB",
    doc = "Import single-sample GVCFs into GenomicsDB before joint genotyping.",
    inputLabels = c("vcf","Ref","db","intervals"),
    inputDocs = c("GVCF files to be imported to GenomicsDB. Each file must contain data for only a single sample. Either this or sample-name-map must be specified. This argument may be specified 0 or more times. Default value: null. Cannot be used in conjunction with argument(s) sampleNameMapFile avoidNio","Reference sequence Default value: null.","Workspace for GenomicsDB. Can be a POSIX file system absolute or relative path or a HDFS/GCS URL. Use this argument when creating a new GenomicsDB workspace. Either this or genomicsdb-update-workspace-path must be specified. Must be an empty or non-existent directory. Required. Cannot be used in conjunction with argument(s) incrementalImportWorkspace intervalListOutputPathString","One or more genomic intervals over which to operate This argument may be specified 0 or more times. Default value: null."),
    outputLabels = c("dbout"),
    outputDocs = c("GenomicsDB workspace"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/broadinstitute/gatk",
        example = paste()
    )
)
