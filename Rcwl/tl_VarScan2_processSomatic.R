## http://varscan.sourceforge.net
p1 <- InputParam(id = "vcf", type = "File")
o1 <- OutputParam(id = "somaticHC", type = "File",
                  glob = "$(inputs.vcf.nameroot).Somatic.hc.vcf")
o2 <- OutputParam(id = "somatic", type = "File",
                  glob = "$(inputs.vcf.nameroot).Somatic.vcf")
o3 <- OutputParam(id = "germline", type = "File",
                  glob = "$(inputs.vcf.nameroot).Germline.vcf")
o4 <- OutputParam(id = "germlineHC", type = "File",
                  glob = "$(inputs.vcf.nameroot).Germline.hc.vcf")
o5 <- OutputParam(id = "LOH", type = "File",
                  glob = "$(inputs.vcf.nameroot).LOH.vcf")
o6 <- OutputParam(id = "LOHHC", type = "File",
                  glob = "$(inputs.vcf.nameroot).LOH.hc.vcf")

req1 <- list(class = "DockerRequirement",
             dockerPull = "mgibio/varscan-cwl:v2.4.2-samtools1.3.1")
req2 <- list(class = "InitialWorkDirRequirement",
             listing = list("$(inputs.vcf)"))

VarScan2_processSomatic <- cwlProcess(baseCommand = c("java", "-jar",
                                                    "/opt/varscan/VarScan.jar", "processSomatic"),
                                    requirements = list(req1, req2),
                                    inputs = InputParamList(p1),
                                    outputs = OutputParamList(o1, o2, o3, o4, o5, o6))



VarScan2_processSomatic <- addMeta(
    VarScan2_processSomatic,
    label = "VarScan2_processSomatic",
    doc = "processes the output from the VarScan2 somatic command.",
    inputLabels = c("vcf"),
    inputDocs = c("Somantic vcf file"),
    outputLabels = c("somaticHC","somatic","germline","germlineHC","LOH","LOHHC"),
    outputDocs = c("High-confidence somatic variants; a reliable set for downstream analysis.","All detected somatic variants, including lower-confidence variants.","Variants identified as germline mutations, present in both tumor and normal samples.","High-confidence germline variants, passing all stringent criteria.","Contains all detected LOH events, including both high- and lower-confidence calls.","Contains only high-confidence LOH events, which are more likely to be accurate and are filtered based on stringent criteria."),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "http://varscan.sourceforge.net",
        example = paste()
    )
)
