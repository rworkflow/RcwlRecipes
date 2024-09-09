#' @include tl_arcasHLA_extract.R
#' @include tl_arcasHLA_genotype.R
#' @include tl_arcasHLA_partial.R
p1 <- InputParam(id = "bam", type = "File", position = 1L, secondaryFiles = ".bai")
p2 <- InputParam(id = "threads", type = "int", default=4L)

s1 <- cwlStep(id = "Extract", run = arcasHLA_extract,
              In = list(bam = "bam",
                        threads = "threads"))
s2 <- cwlStep(id = "Genotype", run = arcasHLA_genotype,
              In = list(fqs = "Extract/fqs",
                        threads = "threads"))
s3 <- cwlStep(id = "Partial", run = arcasHLA_partial,
              In = list(fqs = "Extract/fqs",
                        genotype = "Genotype/genotype",
                        threads = "threads"))
o1 <- OutputParam(id = "gout", type = "File", outputSource = "Genotype/genotype")
o2 <- OutputParam(id = "pout", type = "File", outputSource = "Partial/pg")
arcasHLA_pl <- cwlWorkflow(inputs = InputParamList(p1, p2),
                           outputs = OutputParamList(o1, o2))
arcasHLA_pl <- arcasHLA_pl + s1 + s2 + s3
