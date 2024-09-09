## Filter Variants
p1 <- InputParam(id = "vcf", type = "File", prefix = "-V",
                 secondaryFiles = c(".idx", ".stats"))
p2 <- InputParam(id = "cont", type = "File", prefix = "--contamination-table")
p3 <- InputParam(id = "seg", type = "File", prefix = "--tumor-segmentation")
p4 <- InputParam(id = "lro", type = "File", prefix = "--ob-priors")
p5 <- InputParam(id = "fvcf", type = "string", prefix = "-O")
p6 <- InputParam(id = "ref", prefix = "-R", type = "File",
                 secondaryFiles = c(".fai", "^.dict"))
o1 <- OutputParam(id = "fout", type = "File", glob = "$(inputs.fvcf)")
req1 <- list(class = "DockerRequirement",
             dockerPull = "broadinstitute/gatk:latest")

FilterMutectCalls <- cwlProcess(baseCommand = c("gatk", "FilterMutectCalls"),
                              requirements = list(req1),
                              inputs = InputParamList(p1, p2, p3, p4, p5, p6),
                              outputs = OutputParamList(o1))


FilterMutectCalls <- addMeta(
    FilterMutectCalls,
    label = "FilterMutectCalls",
    doc = "FilterMutectCalls applies filters to the raw output of Mutect2.",
    inputLabels = c("vcf","cont","seg","lro","fvcf","ref"),
    inputDocs = c("A VCF file containing variants Required.","Tables containing contamination information. This argument may be specified 0 or more times. Default value: null.","Tables containing tumor segments' minor allele fractions for germline hets emitted by CalculateContamination.This argument may be specified 0 or more times. Default value:null.","File that contains the prior probabilities of observing orientation bias artifacts","The output filtered VCF file Required.","Reference sequence file Required."),
    outputLabels = c("fout"),
    outputDocs = c("Filtered VCF file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/broadinstitute/gatk",
        example = paste()
    )
)
