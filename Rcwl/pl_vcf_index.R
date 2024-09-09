#' @include tl_bgzip.R tl_tabix_index.R
p1 <- InputParam(id = "vcf", type = "File")
s1 <- cwlStep(id = "bgzip", run = bgzip,
              In = list(ifile = "vcf"))
s2 <- cwlStep(id = "index", run = tabix_index,
              In = list(tfile = "bgzip/zfile",
                        type = list(valueFrom = "vcf")))
o1 <- OutputParam(id = "tbi", type = "File", outputSource = "index/idx")
req1 <- requireStepInputExpression()
vcf_index <- cwlWorkflow(requirements = list(req1),
                         inputs = InputParamList(p1),
                         outputs = OutputParamList(o1))
vcf_index  <- vcf_index + s1 + s2
