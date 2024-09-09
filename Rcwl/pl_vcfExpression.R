#' @include tl_kallisto_quant.R tl_vcf_expression_annotator.R tl_bgzip.R tl_tabix_index.R
#' @importFrom utils read.table write.table
#' @importFrom tximport tximport
cleanExp <- function(afile) {
    exp1 <- read.table(afile, header = TRUE, stringsAsFactors = FALSE)
    exp1[,1] <- sub("\\|ENSG.*", "", exp1[,1])
    write.table(exp1, file = "abundance_clean.tsv",
                row.names = FALSE, quote = FALSE, sep = "\t")
}
p1 <- InputParam(id = "afile", type = "File",
                 prefix = "afile=", separate = FALSE)
o1 <- OutputParam(id = "aout", type = "File", glob = "abundance_clean.tsv")
CleanExp <- cwlProcess(baseCommand = cleanExp,
                     inputs = InputParamList(p1),
                     outputs = OutputParamList(o1))

p1 <- InputParam(id = "rnafqs", type = "File[]")
p2 <- InputParam(id = "kallistoIdx", type = "File")
p3 <- InputParam(id = "threads", type = "int", default = 16L)
p4 <- InputParam(id = "svcf", type = "File")
s1 <- cwlStep(id = "kallistoQuant", run = kallisto_quant,
           In = list(fastq = "rnafqs",
                     index = "kallistoIdx",
                     threads = "threads"))
s2 <- cwlStep(id = "cleanExp", run = CleanExp,
           In = list(afile = "kallistoQuant/tsv"))
s3 <- cwlStep(id = "vcfExpAnn", run = vcf_expression_annotator,
           In = list(ivcf = "svcf",
                     ovcf = list(valueFrom = "$(inputs.ivcf.nameroot)_ExpAnn.vcf"),
                     expression = "cleanExp/aout",
                     gtype = list(valueFrom = "transcript"),
                     etype = list(valueFrom = "kallisto")))
## transcript to gene
t2gene <- function(kexp){
    e1 <- read.table(kexp, header = TRUE, check.names = FALSE,
                     stringsAsFactors = FALSE, sep = "\t")
    ids <- do.call(rbind, base::strsplit(e1$target_id, split = "\\|"))
    tx2gene  <- data.frame(ids[,1:2])
    gexp <- tximport::tximport(kexp, type = "kallisto", tx2gene = tx2gene, ignoreAfterBar=TRUE)
    gExp <- data.frame(gene = sub("\\..*", "", rownames(gexp$abundance)),
                       abundance = gexp$abundance)
    write.table(gExp, file = "abundance_gene.tsv", row.names = FALSE,
                col.names = TRUE, quote = FALSE, sep = "\t")
}
tp1 <- InputParam(id = "kexp", type = "File",
                 prefix = "kexp=", separate = FALSE)
to1 <- OutputParam(id = "gout", type = "File", glob = "abundance_gene.tsv")
req1 <- requireDocker("quay.io/biocontainers/bioconductor-tximport:1.22.0--r41hdfd78af_0")
T2Gene <- cwlProcess(baseCommand = t2gene,
                     requirements = list(req1),
                     inputs = InputParamList(tp1),
                     outputs = OutputParamList(to1))

s4 <- cwlStep(id = "T2Gene", run = T2Gene,
           In = list(kexp = "kallistoQuant/tsv"))
s5 <- cwlStep(id = "vcfgExpAnn", run = vcf_expression_annotator,
           In = list(ivcf = "vcfExpAnn/oVcf",
                     ovcf = list(source = list("svcf"),
                                 valueFrom = "$(self[0].nameroot)_gAnn.vcf"),
                     expression = "T2Gene/gout",
                     gtype = list(valueFrom = "gene"),
                     etype = list(valueFrom = "custom"),
                     idCol = list(valueFrom = "gene"),
                     expCol = list(valueFrom = "abundance")))

s6 <- cwlStep(id = "bgzip", run = bgzip,
           In = list(ifile = "vcfgExpAnn/oVcf"))
s7 <- cwlStep(id = "tabixIndex", run = tabix_index,
           In = list(tfile = "bgzip/zfile",
                     type = list(valueFrom = "vcf")))
o1 <- OutputParam(id = "ExpVcf", type = "File",
                  outputSource = "tabixIndex/idx", secondaryFile = ".tbi")
req1 <- list(class = "InlineJavascriptRequirement")
req2 <- list(class = "StepInputExpressionRequirement")
vcfExpression <- cwlWorkflow(requirements = list(req1, req2),
                              inputs = InputParamList(p1, p2, p3, p4),
                              outputs = OutputParamList(o1))
vcfExpression <- vcfExpression + s1 + s2 + s3 + s4 + s5 + s6 + s7
