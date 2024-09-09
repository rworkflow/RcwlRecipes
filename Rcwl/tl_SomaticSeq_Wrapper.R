
p1 <- InputParam(id = "ref", type = "File",
                 prefix = "--genome-reference",
                 secondaryFiles = c(".fai", "^.dict"))
p2 <- InputParam(id = "tbam", type = "File", prefix = "--tumor-bam",
                 secondaryFile = ".bai")
p3 <- InputParam(id = "nbam", type = "File", prefix = "--normal-bam",
                 secondaryFiles = ".bai")
p4 <- InputParam(id = "mutect2", type = "File?", prefix = "--mutect2")
p5 <- InputParam(id = "varscanSnv", type = "File?", prefix = "--varscan-snv")
p6 <- InputParam(id = "varscanIndel", type = "File?", prefix = "--varscan-indel")
p7 <- InputParam(id = "sniper", type = "File?", prefix = "--sniper")
p8 <- InputParam(id = "vardict", type = "File?", prefix = "--vardict")
p9 <- InputParam(id = "muse", type = "File?", prefix = "--muse")
p10 <- InputParam(id = "strelkaSnv", type = "File?", prefix = "--strelka-snv")
p11 <- InputParam(id = "strelkaIndel", type = "File?", prefix = "--strelka-indel")
p12 <- InputParam(id = "lofreqSnv", type = "File?", prefix = "--lofreq-snv")
p13 <- InputParam(id = "lofreqIndel", type = "File?", prefix = "--lofreq-indel")
p14 <- InputParam(id = "region", type = "File?", prefix = "--inclusion-region")
p15 <- InputParam(id = "dbsnp", type = "File",
                  prefix = "--dbsnp",
                  secondaryFiles = "$(self.nameext == '.gz' ? self.basename+'.tbi' : self.basename+'.idx')")
o1 <- OutputParam(id = "conSNV", type = "File", glob = "Consensus.sSNV.vcf")
o2 <- OutputParam(id = "conINDEL", type = "File", glob = "Consensus.sINDEL.vcf")
o3 <- OutputParam(id = "EnsSNV", type = "File", glob = "Ensemble.sSNV.tsv")
o4 <- OutputParam(id = "EnsINDEL", type = "File", glob = "Ensemble.sINDEL.tsv")

req1 <- list(class = "DockerRequirement",
             dockerPull = "lethalfang/somaticseq:2.7.2")
SomaticSeq_Wrapper <- cwlProcess(baseCommand = "/opt/somaticseq/SomaticSeq.Wrapper.sh",
                               requirements = list(req1),
                               arguments = list("--output-dir", ".", "--gatk",
                                                "/opt/GATK/GenomeAnalysisTK.jar"),
                               inputs = InputParamList(p1, p2, p3, p4, p5, p6, p7, p8,
                                                       p9, p10, p11, p12, p13, p14, p15),
                               outputs = OutputParamList(o1, o2, o3, o4))


SomaticSeq_Wrapper <- addMeta(
    SomaticSeq_Wrapper,
    label = "SomaticSeq_Wrapper",
    doc = "Simplify the execution and management of the SomaticSeq pipeline by handling the various steps involved in somatic mutation detection.",
    inputLabels = c("ref","tbam","nbam","mutect2","varscanSnv","varscanIndel","sniper","vardict","muse","strelkaSnv","strelkaIndel","lofreqSnv","lofreqIndel","region","dbsnp"),
    inputDocs = c("Reference file","Tumar bam file","Matched Normal bam file","Mutec2 file","Varscan snv file","Varscan indel file","Integration of the SomaticSniper tool into the SomaticSeq workflow","Integration of the VarDict tool into the SomaticSeq workflow","Integration of the MuSE tool into the SomaticSeq workflow","Strelka snv file","Strelka indel file","Lofreq SNV file","Lofreq Indel file","Region to include","Known variant information from dbSNP"),
    outputLabels = c("conSNV","conINDEL","EnsSNV","EnsINDEL"),
    outputDocs = c("Consensus sSNV output","Consensus sIndel output","Ensemble sSNV output","Ensemble sIndel output"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/bioinform/somaticseq",
        example = paste()
    )
)
