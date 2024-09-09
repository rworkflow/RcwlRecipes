## https://github.com/genome/somatic-sniper
p1 <- InputParam(id = "ref", type = "File", prefix = "-f", secondaryFiles = ".fai", position = 1)
p2 <- InputParam(id = "tbam", type = "File", secondaryFiles = ".bai", position = 2)
p3 <- InputParam(id = "nbam", type = "File", secondaryFiles = ".bai", position = 3)
p4 <- InputParam(id = "vcf", type = "string", position = 4)
o1 <- OutputParam(id = "outVcf", type = "File", glob = "$(inputs.vcf)")
req1 <- list(class = "DockerRequirement",
             dockerPull = "lethalfang/somaticsniper:1.0.5.0-2")

SomaticSniper <- cwlProcess(baseCommand = "/opt/somatic-sniper/build/bin/bam-somaticsniper",
                          requirements = list(req1),
                          arguments = list("-q", "10", "-F", "vcf"),
                          inputs = InputParamList(p1, p2 , p3, p4),
                          outputs = OutputParamList(o1))


SomaticSniper <- addMeta(
    SomaticSniper,
    label = "SomaticSniper",
    doc = "Identify single nucleotide positions that are different between tumor and normal (or in theory, any two bam files).",
    inputLabels = c("ref","tbam","nbam","vcf"),
    inputDocs = c("reference sequence in the FASTA format","Tumer bam file","Normal bam file","Name of vcf file"),
    outputLabels = c("outVcf"),
    outputDocs = c("Output VCF file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/genome/somatic-sniper",
        example = paste()
    )
)
