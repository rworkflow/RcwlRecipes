## http://varscan.sourceforge.net
p1 <- InputParam(id = "vcf", type = "File", position = 1)
p2 <- InputParam(id = "indel", type = "File", prefix = "--indel-file", position = 2)
p3 <- InputParam(id = "outvcf", type = "string", prefix = "--output-file", position = 3)
o1 <- OutputParam(id = "outVcf", type = "File", glob = "$(inputs.outvcf)")
req1 <- list(class = "DockerRequirement",
             dockerPull = "mgibio/varscan-cwl:v2.4.2-samtools1.3.1")
VarScan2_somaticFilter <- cwlProcess(baseCommand = c("java", "-jar",
                                                   "/opt/varscan/VarScan.jar", "somaticFilter"),
                                    requirements = list(req1),
                                    inputs = InputParamList(p1, p2, p3),
                                    outputs = OutputParamList(o1))


VarScan2_somaticFilter <- addMeta(
    VarScan2_somaticFilter,
    label = "VarScan2_somaticFilter",
    doc = "toolkit designed to apply additional filters to the somatic variant calls identified by VarScan2 somatic.",
    inputLabels = c("vcf","indel","outvcf"),
    inputDocs = c("Input Somantic VCF file","File of indels for filtering nearby SNPs","Optional output file for filtered variants"),
    outputLabels = c("outVcf"),
    outputDocs = c("FIltered vfc file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "http://varscan.sourceforge.net",
        example = paste()
    )
)
