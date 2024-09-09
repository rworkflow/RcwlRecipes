## Funcotator
p1 <- InputParam(id = "vcf", type = "File", prefix = "-V")
p2 <- InputParam(id = "ref", prefix = "-R", type = "File",
                 secondaryFiles = c(".fai", "$(self.nameroot).dict"))
p3 <- InputParam(id = "outf", type = "string", prefix = "--output-file-format", default = "MAF")
p4 <- InputParam(id = "dsource", type = "Directory", prefix = "--data-sources-path")
p5 <- InputParam(id = "version", type = "string", prefix = "--ref-version", default = "hg19")
p6 <- InputParam(id = "maf", type = "string", prefix = "-O")
o1 <- OutputParam(id = "mout", type = "File", glob = "$(inputs.maf)")
req1 <- list(class = "DockerRequirement",
             dockerPull = "broadinstitute/gatk:latest")

Funcotator <- cwlProcess(baseCommand = c("gatk",
                                       "Funcotator"),
                       requirements = list(req1),
                       arguments = list("--remove-filtered-variants"),
                       inputs = InputParamList(p1, p2, p3, p4, p5, p6),
                       outputs = OutputParamList(o1))


Funcotator <- addMeta(
    Funcotator,
    label = "Funcotator",
    doc = "Create functional annotations on given variants cross-referenced by a given set of data sources.A GATK functional annotation tool (similar functionality to Oncotator).",
    inputLabels = c("vcf","ref","outf","dsource","version","maf"),
    inputDocs = c("A VCF file containing variants Required.","Reference sequence file Required.","The output file format. Either VCF, MAF, or SEG. Please note that MAF output for germline use case VCFs is unsupported. SEG will generate two output files: a simple tsv and a gene list. Required. Possible values: {VCF, MAF, SEG}","The path to a data source folder for Funcotator. May be specified more than once to handle multiple data source folders. This argument must be specified at least once.Required.","The version of the Human Genome reference to use (e.g. hg19, hg38, etc.). This will correspond to a sub-folder of each data source corresponding to that data source for the given reference. Required.","Output file to which annotated variants should be written. Required."),
    outputLabels = c("mout"),
    outputDocs = c("Annotated vcf or maf file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/broadinstitute/gatk",
        example = paste()
    )
)
