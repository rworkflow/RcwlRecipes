## https://github.com/dkoboldt/varscan
p1 <- InputParam(id = "nbam", type = "File",
                 position = 1, secondaryFiles = ".bai")
p2 <- InputParam(id = "tbam", type = "File",
                 position = 2, secondaryFiles = ".bai")
p3 <- InputParam(id = "ref", type = "File", prefix = "-b",
                 secondaryFiles = c(".fai", "$(self.nameroot).dict"))
p4 <- InputParam(id = "allvcf", type = "string", prefix = "-f")
p5 <- InputParam(id = "somvcf", type = "string", prefix = "-y")
p6 <- InputParam(id = "proc", type = "int", prefix = "-p")
o1 <- OutputParam(id = "allVcf", type = "File", glob = "$(inputs.allvcf)")
o2 <- OutputParam(id = "somVcf", type = "File", glob = "$(inputs.somvcf)")

req1 <- list(class = "DockerRequirement",
             dockerPull = "serge2016/varscan:v0.1.1")
VarScan2 <- cwlProcess(baseCommand = "",
                     requirements = list(req1),
                     arguments = list("-o", "."),
                     inputs = InputParamList(p1, p2, p3, p4, p5, p6),
                     outputs = OutputParamList(o1, o2))


VarScan2 <- addMeta(
    VarScan2,
    label = "VarScan2",
    doc = "Variant calling and somatic mutation/CNV detection for next-generation sequencing data",
    inputLabels = c("nbam","tbam","ref","allvcf","somvcf","proc"),
    inputDocs = c("normal-exome-BAM","tumor-exome-BAM","refGenomeFile - a full filename of UNPACKED reference genome .fasta file [].fasta.fai file is expected to be in the same directory.When provided together with -a, then downloaded file will be saved as -b.","File name of an output copy of a VCF-file with all (SNPs + InDels; Somatic + Germline + LOH) filtered mutations By default it is <OutputDIR> + '/' + <sampleName> + '.all.hc.fp-filtered.SV-filtered.vcf'. If it is specified then the default output file is copied (with mkdir -p).","File name of an output copy of a file with only Somatic (SNPs + InDels; Somatic) filtered mutations By default it is <OutputDIR> + '/' + <sampleName> + '.all.hc.fp-filtered.SV-filtered.Somatic.vcf'.If it is specified then the default output file is copied (with mkdir -p).","Number of CPUs to use [2] If not provided, script will try to use all existing (nproc).For competability with Universe CWL: 0 - use all existing (nproc) (same as the absence of this option, default)."),
    outputLabels = c("allVcf","somVcf"),
    outputDocs = c("All Variant file","Somantic Variant file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/dkoboldt/varscan",
        example = paste()
    )
)
