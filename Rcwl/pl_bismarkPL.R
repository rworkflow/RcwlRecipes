#' @include tl_bismark.R
#' @include tl_deduplicate_bismark.R
#' @include tl_bismark_methylation_extractor.R
p1 <- InputParam(id = "fq1", type = "File")
p2 <- InputParam(id = "fq2", type = "File")
p3 <- InputParam(id = "genome", type = "Directory")
p4 <- InputParam(id = "threads", type = "int")
s1 <- cwlStep(id = "bismark_align", run = bismark,
              In = list(fq1 = "fq1",
                        fq2 = "fq2",
                        genome = "genome",
                        threads = "threads"))
s2 <- cwlStep(id = "deduplicate", run = deduplicate_bismark,
              In = list(bam = "bismark_align/align"))
s3 <- cwlStep(id = "meth", run = bismark_methylation_extractor,
              In = list(bam = "deduplicate/dbam",
                          core = "threads"))
o1 <- OutputParam(id = "Align", type = "File", outputSource = "bismark_align/align")
o2 <- OutputParam(id = "AReport", type = "File", outputSource = "bismark_align/report")
o3 <- OutputParam(id = "DBam", type = "File", outputSource = "deduplicate/dbam")
o4 <- OutputParam(id = "mcov", type = "File", outputSource = "meth/cov")
o5 <- OutputParam(id = "mbed", type = "File?", outputSource = "meth/Bed")
o6 <- OutputParam(id = "mreport", type = "File[]", outputSource = "meth/report")
bismarkPL <- cwlWorkflow(inputs = InputParamList(p1, p2, p3, p4),
                            outputs = OutputParamList(o1, o2, o3, o4, o5, o6))
bismarkPL <- bismarkPL + s1 + s2 + s3
