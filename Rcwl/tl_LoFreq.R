## https://csb5.github.io/lofreq/commands/#somatic
p1 <- InputParam(id = "tbam", type = "File", prefix = "-t", secondaryFiles = ".bai")
p2 <- InputParam(id = "nbam", type = "File", prefix = "-n", secondaryFiles = ".bai")
p3 <- InputParam(id = "ref", type = "File", prefix = "-f", secondaryFiles = ".fai")
p4 <- InputParam(id = "region", type = "File", prefix = "-l")
p5 <- InputParam(id = "dbsnp", type = "File", prefix = "-d",
                 secondaryFiles = "$(self.nameext == '.gz' ? self.basename+'.tbi' : self.basename+'.idx')")
p6 <- InputParam(id = "out", type = "string", prefix = "-o")
p7 <- InputParam(id = "threads", type = "int", prefix = "--threads")
o1 <- OutputParam(id = "snp", type = "File",
                  glob = "$(inputs.out)somatic_final.snvs.vcf.gz",
                  secondaryFiles = ".tbi")
o2 <- OutputParam(id = "snpdb", type = "File",
                  glob = "$(inputs.out)somatic_final_minus-dbsnp.snvs.vcf.gz",
                  secondaryFiles = ".tbi")
o3 <- OutputParam(id = "indel", type = "File",
                  glob = "$(inputs.out)somatic_final.indels.vcf.gz",
                  secondaryFiles = ".tbi")
o4 <- OutputParam(id = "indeldb", type = "File",
                  glob = "$(inputs.out)somatic_final_minus-dbsnp.indels.vcf.gz",
                  secondaryFiles = ".tbi")

req1 <- requireDocker("quay.io/biocontainers/lofreq:2.1.5--py37h916d2e8_4")
req2 <- requireJS()
LoFreq <- cwlProcess(baseCommand = c("lofreq", "somatic"),
                     arguments = list("--call-indels"),
                     requirements = list(req1, req2),
                     inputs = InputParamList(p1, p2, p3, p4, p5, p6, p7),
                     outputs= OutputParamList(o1, o2, o3, o4))


LoFreq <- addMeta(
    LoFreq,
    label = "LoFreq",
    doc = "Predict somatic variants from a paired normal/disease sample. The script will produce several output files using the prefix specified.",
    inputLabels = c("tbam","nbam","ref","region","dbsnp","out","threads"),
    inputDocs = c("Tumor BAM file","Normal BAM file","Reference fasta file","BED file listing regions to restrict analysis to","vcf-file (bgzipped and index with tabix) containing known germline variants (e.g. dbsnp for human","Prefix for output files","Use this many threads for each call"),
    outputLabels = c("snp","snpdb","indel","indeldb"),
    outputDocs = c("SNVs before dbsnp removal","SNVs after dbsnp removal","Indels before dbsnp removal","Indels after dbsnp removal"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://csb5.github.io/lofreq/commands/#somatic",
        example = paste()
    )
)
