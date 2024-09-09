## cnv_facets
p1 <- InputParam(id = "tbam", type = "File?", prefix = "-t", secondaryFiles = list(".bai?", "^.bai?"))
p2 <- InputParam(id = "nbam", type = "File?", prefix = "-n", secondaryFiles = list(".bai?", "^.bai?"))
p3 <- InputParam(id = "vcf", type = "File?", prefix = "-vcf", secondaryFiles = ".tbi")
p4 <- InputParam(id = "pileup", type = "File?", prefix = "-p")
p5 <- InputParam(id = "out", type = "string", prefix = "-o")
p6 <- InputParam(id = "build", type = "string?", prefix = "-g")
p7 <- InputParam(id = "targets", type = "File?", prefix = "-T")
p8 <- InputParam(id = "cval", type = "int[]?", prefix = "-cv")
p9 <- InputParam(id = "nprocs", type = "int?", prefix = "-N")
o1 <- OutputParam(id = "Out", type = "File[]", glob = "$(inputs.out)*")
req1 <- list(class = "DockerRequirement",
             dockerPull = "hubentu/facets:0.6.2")
cnv_facets <- cwlProcess(cwlVersion = "v1.2",
                         baseCommand = "cnv_facets.R",
                         requirements = list(req1),
                         inputs = InputParamList(p1, p2, p3, p4, p5, p6, p7, p8, p9),
                         outputs = OutputParamList(o1))


cnv_facets <- addMeta(
    cnv_facets,
    label = "cnv_facets",
    doc = "cnv_facets detects somatic copy number variants (CNVs), i.e., variants private to a tumour sample given a matched or unmatched normal sample. cnv_facets uses next generation sequencing data from whole genome (WGS), whole exome (WEX) and targeted (panel) sequencing experiments. In addition, it estimates tumour purity and ploidy.",
    inputLabels = c("tbam","nbam","vcf","pileup","out","build","targets","cval","nprocs"),
    inputDocs = c("BAM file for tumour sample","BAM file for normal sample","VCF file of SNPs where pileup is to be computed","Pileup for matched normal (first sample) and tumour (second sample). Not needed if using BAM input. This file is the <prefix>.cvs.gz output of of a previous run of cnv_facet.R","Output prefix for the output files","String indicating the reference genome build. Default hg38.","BED file of target regions to scan. It may be the target regions from WEX or panel sequencing protocols. It is not required, even for targeted sequencing, but it may improve the results","Critical values for segmentation in pre-processing and processing. Larger values reduce segmentation. [25 150] is facets default based on exome data. For whole genome consider increasing to [25 400] and for targeted sequencing consider reducing them. Default 25 150","Number of parallel processes to run to prepare the read pileup file. Each chromsome is assigned to a process. Default 1"),
    outputLabels = c("Out"),
    outputDocs = c("This is a tab-delimited text file that contains copy number calls and segmentation information for the sample"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/dariober/cnv_facets",
        example = paste()
    )
)
