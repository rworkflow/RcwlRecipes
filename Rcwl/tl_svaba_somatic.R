## https://github.com/walaj/svaba
p1 <- InputParam(id = "tbam", type = "File", prefix = "-t", secondaryFiles = ".bai")
p2 <- InputParam(id = "nbam", type = "File", prefix = "-n", secondaryFiles = ".bai")
p3 <- InputParam(id = "target", type = "File?", prefix = "-k")
p4 <- InputParam(id = "dbsnp", type = "File", prefix = "-D")
p5 <- InputParam(id = "ref", type = "File", prefix = "-G",
                 secondaryFiles = c(".amb", ".ann", ".bwt", ".pac", ".sa", ".fai"))
p6 <- InputParam(id = "cores", type = "int", prefix = "-p", default = 4L)
o1 <- OutputParam(id = "raw", type = "File", glob = "*.bps.txt.gz")
o2 <- OutputParam(id = "contig", type = "File", glob = "*.contigs.bam")
o3 <- OutputParam(id = "discordants", type = "File", glob = "*.discordant.txt.gz")
o4 <- OutputParam(id = "log", type = "File", glob = "*.log")
o5 <- OutputParam(id = "align", type = "File", glob = "*.alignments.txt.gz")
o6 <- OutputParam(id = "vcf", type = "File[]", glob = "*.vcf")
req1 <- list(class = "DockerRequirement",
             dockerPull = "quay.io/biocontainers/svaba:1.1.0--h7d7f7ad_2")
svaba_somatic <- cwlProcess(baseCommand = c("svaba", "run"),
                          requirements = list(req1),
                          arguments = list("-a", "somatic_run"),
                          inputs = InputParamList(p1, p2, p3, p4, p5, p6),
                          outputs = OutputParamList(o1, o2, o3, o4, o5, o6))
