## vatools.org

p1 <- InputParam(id = "ivcf", type = "File", position = 1)
p2 <- InputParam(id = "expression", type = "File", position = 2)
p3 <- InputParam(id = "etype", type = "string", position = 3, default = "kallisto")
p4 <- InputParam(id = "gtype", type = "string", position = 4, default = "transcript")
p5 <- InputParam(id = "idCol", type = "string?", prefix = "-i")
p6 <- InputParam(id = "expCol", type = "string?", prefix = "-e")
p7 <- InputParam(id = "sample", type = "string?", prefix = "-s")
p8 <- InputParam(id = "ovcf", type = "string", prefix = "-o")
o1 <- OutputParam(id = "oVcf", type = "File", glob = "$(inputs.ovcf)")

req1 <- list(class = "DockerRequirement",
             dockerPull = "griffithlab/vatools:3.1.0")
vcf_expression_annotator <- cwlProcess(baseCommand = "vcf-expression-annotator",
                                     requirements = list(req1),
                                     arguments = list("--ignore-transcript-version"),
                                     inputs = InputParamList(p1, p2, p3, p4, p5, p6, p7, p8),
                                     outputs = OutputParamList(o1))


vcf_expression_annotator <- addMeta(
    vcf_expression_annotator,
    label = "vcf_expression_annotator",
    doc = "The VCF Expression Annotator will take an output file from Cufflinks, Kallisto, or StringTie and add the data from that file to your VCF.",
    inputLabels = c("ivcf","expression","etype","gtype","idCol","expCol","sample","ovcf"),
    inputDocs = c("A VEP-annotated VCF file","A TSV file containing expression estimates {kallisto,stringtie,cufflinks,custom}","Describes the type of expression data associated with the variant","Describes the genotype of the variant in a given sample or individual","The column header in the expression_file for the column containing gene names/transcript ids. Required when using the `custom` format.","The column header in the expression_file for the column containing expression data.","If the input_vcf contains multiple samples, the name of the sample to annotate.","Path to write the output VCF file."),
    outputLabels = c("oVcf"),
    outputDocs = c("Annotated vcf file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "vatools.org",
        example = paste()
    )
)
