## https://github.com/timothyjamesbecker/SVE
p1 <- InputParam(id = "fqs", type = "File[]",
                 itemSeparator = ",", prefix = "-f")
p2 <- InputParam(id = "ref", type = "File",
                 secondaryFile = ".fai", prefix = "-r")
p3 <- InputParam(id = "outdir", type = "string", prefix = "-o")
p4 <- InputParam(id = "threads", type = "int",
                 prefix = "-T", default = 4L)
o1 <- OutputParam(id = "outs", type = "Directory", glob = "$(inputs.outdir)")

req1 <- list(class = "DockerRequirement",
             dockerPull = "timothyjamesbecker/sve")
SVE <- cwlProcess(baseCommand = "/software/SVE/scripts/auto.py",
                requirements = list(req1),
                inputs = InputParamList(p1, p2, p3, p4),
                outputs = OutputParamList(o1))


SVE <- addMeta(
    SVE,
    label = "SVE",
    doc = "Given a .fa reference file and a pair: NA12878_1.fq.gz,NA12878_2.fq.gz,produce a FusorSV VCF file all_samples_merge.vcf with comprehensive merged SV calls using a fusion model.",
    inputLabels = c("fqs","ref","outdir","threads"),
    inputDocs = c("comma-sep file path list","fasta reference path (if indexes are not found, run (A))","output directory to store resulting files","number of threads per CPU"),
    outputLabels = c("outs"),
    outputDocs = c("SVE output directory"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/timothyjamesbecker/SVE",
        example = paste()
    )
)
