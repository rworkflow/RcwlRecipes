## delly two samples
#' @include tl_delly_call.R tl_bcftools_query.R tl_echo.R tl_fpaste.R tl_delly_filter.R
p1 <- InputParam(id = "tbam", type = "File", secondaryFiles = ".bai")
p2 <- InputParam(id = "nbam", type = "File", secondaryFiles = ".bai")
p3 <- InputParam(id = "outbcf", type = "string")
p4 <- InputParam(id = "exclude", type = "File?")
p5 <- InputParam(id = "genome", type = "File", secondaryFiles = ".fai")

s1 <- cwlStep(id = "dellyCall", run = delly_call,
              In = list(exclude = "exclude",
                        genome = "genome",
                        outfile = "outbcf",
                        tbam = "tbam",
                        nbam = "nbam"))
s2 <- cwlStep(id = "listSample", run = bcftools_query,
              In = list(vcf = "dellyCall/outbcf",
                        out = list(valueFrom = "sample.txt"),
                        listSample = list(valueFrom = "$(true)")))
s3 <- cwlStep(id = "echo", run = echo,
              In = list(sth = list(valueFrom = "tumor\ncontrol")))
s4 <- cwlStep(id = "fpaste", run = fpaste,
              In = list(files = list(source = list("listSample/qout", "echo/out"),
                                     linkMerge = "merge_flattened")))
s5 <- cwlStep(id = "dellyFilter", run = delly_filter,
              In = list(outfile = "outbcf",
                        tbcf = "dellyCall/outbcf",
                        samples = "fpaste/out"))
o1 <- OutputParam(id = "bcf", type = "File", outputSource = "dellyFilter/fbcf")
delly_somatic <- cwlWorkflow(inputs = InputParamList(p1, p2, p3, p4, p5),
                             outputs = OutputParamList(o1),
                             requirements = list(requireStepInputExpression(),
                                                 requireMultipleInput(),
                                                 requireJS()))
delly_somatic <- delly_somatic + s1 + s2 + s3 + s4 + s5
