## https://github.com/timothyjamesbecker/SVE
p1 <- InputParam(id = "bam", type = "File",
                 secondaryFiles = ".bai", prefix = "-b")
p2 <- InputParam(id = "ref", type = "File",
                 secondaryFile = c(".fai", "$(self.nameroot).dict"), prefix = "-r")
p3 <- InputParam(id = "outdir", type = "string", prefix = "-o")
p4 <- InputParam(id = "tools", type = "string", prefix = "-s",
                 default = "breakdancer,cnmops,gatk_haplo,delly,lumpy,cnvnator,breakseq,tigra,genome_strip,hydra")
o1 <- OutputParam(id = "outs", type = "Directory", glob = "$(inputs.outdir)")

req1 <- list(class = "DockerRequirement",
             dockerPull = "timothyjamesbecker/sve")
SVE_VP <- cwlProcess(baseCommand = "/software/SVE/scripts/variant_processor.py",
                   requirements = list(req1),
                   inputs = InputParamList(p1, p2, p3, p4),
                   outputs = OutputParamList(o1))


SVE_VP <- addMeta(
    SVE_VP,
    label = "SVE_VP",
    doc = "Shortened Version of the SVE that uses pre-made .bam files Allthough .bam files are not compatible with all callers such as Variation Hunter",
    inputLabels = c("bam","ref","outdir","tools"),
    inputDocs = c("BAM comma-sep bam file path list, assuming matching bam.bai is in place","Reference file","output directory to store resulting files","stage name list"),
    outputLabels = c("outs"),
    outputDocs = c("SVE VP directory"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/timothyjamesbecker/SVE",
        example = paste()
    )
)
