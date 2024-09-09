## vatools.org

p1 <- InputParam(id = "ivcf", type = "File", position = 1)
p2 <- InputParam(id = "readcount", type = "File", position = 2)
p3 <- InputParam(id = "ntype", type = "string", position = 3, default = "DNA")
p4 <- InputParam(id = "sample", type = "string?", prefix = "-s")
p5 <- InputParam(id = "vtype", type = "string", prefix = "-t", default = "snv")
p6 <- InputParam(id = "ovcf", type = "string", prefix = "-o")
o1 <- OutputParam(id = "oVcf", type = "File", glob = "$(inputs.ovcf)")

req1 <- list(class = "DockerRequirement",
             dockerPull = "griffithlab/vatools:3.1.0")
vcf_readcount_annotator <- cwlProcess(baseCommand = "vcf-readcount-annotator",
                                    requirements = list(req1),
                                    inputs = InputParamList(p1, p2, p3, p4, p5, p6),
                                    outputs = OutputParamList(o1))


vcf_readcount_annotator <- addMeta(
    vcf_readcount_annotator,
    label = "vcf_readcount_annotator",
    doc = "annotate a VCF (Variant Call Format) file with read count information.",
    inputLabels = c("ivcf","readcount","ntype","sample","vtype","ovcf"),
    inputDocs = c("The input VCF file containing the variants to be annotated with read count information.","A file containing read count data, typically generated from a BAM file using tools like bam-readcount","Specifies whether the annotation should be performed in the context of normal (germline) samples.","If the input_vcf contains multiple samples, the name of the sample to annotate.","The type of variant to process. `snv` will only annotate SNVs.","Path to write the output VCF file."),
    outputLabels = c("oVcf"),
    outputDocs = c("Output vcf file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "vatools.org",
        example = paste()
    )
)
