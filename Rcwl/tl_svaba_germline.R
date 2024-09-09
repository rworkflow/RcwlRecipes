## https://github.com/walaj/svaba
p1 <- InputParam(id = "bam", type = "File", prefix = "-t", secondaryFiles = list(".bai?", "^.bai?"))
p2 <- InputParam(id = "mate", type = "int?", prefix = "-L")
p3 <- InputParam(id = "target", type = "File?", prefix = "-k")
p4 <- InputParam(id = "dbsnp", type = "File?", prefix = "-D",
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
o6 <- OutputParam(id = "vcf", type = "File[]", glob = "*.vcf")
req1 <- requireDocker("hubentu/svaba:1.2.0-bin")
req2 <- requireJS()
svaba_germline <- cwlProcess(cwlVersion = "v1.2",
                             baseCommand = c("svaba", "run"),
                             arguments = list("-I"),
                             requirements = list(req1, req2),
                             inputs = InputParamList(p1, p2, p3, p4, p5, p6, p7),
                             outputs = OutputParamList(o1, o2, o3, o4, o5, o6))


svaba_germline <- addMeta(
    svaba_germline,
    label = "svaba_germline",
    doc = "tool used for detecting germline structural variations (SVs) and small insertions and deletions (indels) in DNA sequencing data.",
    inputLabels = c("bam","mate","target","dbsnp","ref","cores","prefix"),
    inputDocs = c("Case BAM/CRAM/SAM file (eg tumor). Can input multiple.","Minimum number of somatic reads required to attempt mate-region lookup [3]","Run on targeted intervals. Accepts BED file or Samtools-style string","DBsnp database (VCF) to compare indels against","Path to indexed reference genome to be used by BWA-MEM.","Use NUM threads to run svaba. Default: 1","String specifying the analysis ID to be used as part of ID common.Main input"),
    outputLabels = c("raw","contig","discordants","log","align","vcf"),
    outputDocs = c("Contains raw, unfiltered variant calls.","Assembled contigs around variant breakpoints, providing sequence context.","Lists of discordant reads that support potential structural variants.","Records details of the run, useful for troubleshooting and understanding the process.","Realigned reads around regions of interest to confirm variant calls.","The final set of detected variants in VCF format, used for downstream analysis."),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/walaj/svaba",
        example = paste()
    )
)
