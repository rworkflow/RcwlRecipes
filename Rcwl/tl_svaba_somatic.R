## https://github.com/walaj/svaba
p1 <- InputParam(id = "tbam", type = "File", prefix = "-t", secondaryFiles = list(".bai?", "^.bai?"))
p2 <- InputParam(id = "nbam", type = "File", prefix = "-n", secondaryFiles = list(".bai?", "^.bai?"))
p3 <- InputParam(id = "target", type = "File?", prefix = "-k")
p4 <- InputParam(id = "dbsnp", type = "File", prefix = "-D",
                 secondaryFiles = "$(self.nameext == '.gz' ? self.basename+'.tbi' : self.basename+'.idx')")
p5 <- InputParam(id = "ref", type = "File", prefix = "-G",
                 secondaryFiles = c(".amb", ".ann", ".bwt", ".pac", ".sa", ".fai"))
p6 <- InputParam(id = "cores", type = "int", prefix = "-p", default = 4L)
p7 <- InputParam(id = "prefix", type = "string", prefix = "-a")
o1 <- OutputParam(id = "raw", type = "File", glob = "*.bps.txt.gz")
o2 <- OutputParam(id = "contig", type = "File", glob = "*.contigs.bam")
o3 <- OutputParam(id = "discordants", type = "File", glob = "*.discordant.txt.gz")
o4 <- OutputParam(id = "log", type = "File", glob = "*.log")
o5 <- OutputParam(id = "align", type = "File", glob = "*.alignments.txt.gz")
o6 <- OutputParam(id = "uvcf", type = "File[]", glob = "*unfiltered.*")
o7 <- OutputParam(id = "svcf", type = "File[]", glob = "*svaba.somatic*")
o8 <- OutputParam(id = "gvcf", type = "File[]", glob = "*svaba.germline*")
req1 <- requireDocker("hubentu/svaba:1.2.0-bin")
req2 <- requireJS()
svaba_somatic <- cwlProcess(cwlVersion = "v1.2",
                            baseCommand = c("svaba", "run"),
                            requirements = list(req1, req2),
                            inputs = InputParamList(p1, p2, p3, p4, p5, p6, p7),
                            outputs = OutputParamList(o1, o2, o3, o4, o5, o6, o7, o8))


svaba_somatic <- addMeta(
    svaba_somatic,
    label = "svaba_somatic",
    doc = "tool specifically designed for detecting somatic structural variants (SVs) and small insertions and deletions (indels) from paired tumor-normal DNA sequencing data.",
    inputLabels = c("tbam","nbam","target","dbsnp","ref","cores","prefix"),
    inputDocs = c("Case BAM/CRAM/SAM file (eg tumor). Can input multiple.","(optional) Control BAM/CRAM/SAM file (eg normal). Can input multiple.","Run on targeted intervals. Accepts BED file or Samtools-style string","DBsnp database (VCF) to compare indels against","Path to indexed reference genome to be used by BWA-MEM.","Use NUM threads to run svaba. Default: 1","String specifying the analysis ID to be used as part of ID common. Main input"),
    outputLabels = c("raw","contig","discordants","log","align","uvcf","svcf","gvcf"),
    outputDocs = c("Contains raw, unfiltered variant calls.","Contains assembled contigs generated around breakpoints of detected variants.","Lists discordant reads that support the detected structural variants.","A log file that records the progress and details of the analysis performed by svaba_somatic.","Contains realigned reads after local assembly around detected variant sites.","The unfiltered VCF file containing all small variants (SNVs and indels) detected in the somatic sample.","The filtered somatic VCF file containing structural variants (SVs) and indels detected in the tumor sample that are not present in the matched normal sample.","Germline VCF file containing variants detected in the normal (germline) sample."),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/walaj/svaba",
        example = paste()
    )
)
