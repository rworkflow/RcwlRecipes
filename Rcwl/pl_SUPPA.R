p1a <- InputParam(id = "quant", type = "File[]")
p1b <- InputParam(id = "qcolumn", type = "string", default = "TPM")
p1c <- InputParam(id = "qcnames", type = "string")
p2 <- InputParam(id = "gtf", type = "File")
p3 <- InputParam(id = "group1", type = "string")
p4 <- InputParam(id = "group2", type = "string")
p5 <- InputParam(id = "method", type = "string", default = "empirical")

#' quant merge
#' @include tl_Rsplit.R
s1 <- cwlStep(id = "quantMerge", run = Rsplit,
           In = list(files = "quant",
                     columns = "qcolumn",
                     cnames = "qcnames",
                     outfile = list(valueFrom = "iso_tpm.txt")))

#' event calculation
#' @include tl_SUPPA_generateEvents.R tl_awk_merge.R
s2 <- cwlStep(id = "genEvents", run = SUPPA_generateEvents,
           In = list(gtf = "gtf",
                     outfile = list(valueFrom = "events")))

s3 <- cwlStep(id = "mergeEvents", run = awk_merge,
           In = list(files = "genEvents/outIOE",
                     outfile = list(valueFrom = "merged.ioe")))

#' psi
#' @include tl_SUPPA_psiPerEvent.R
s4 <- cwlStep(id = "psiPerEvent", run = SUPPA_psiPerEvent,
           In = list(ioe = "mergeEvents/out",
                     exp = "quantMerge/outFile",
                     outfile = list(valueFrom = "events")))

#' split by groups
s5a <- cwlStep(id = "splitEventsG1", run = Rsplit,
            In = list(files = list(source = list("psiPerEvent/outFile"),
                                  linkMerge = "merge_flattened"),
                      outfile = list(valueFrom  = "group1.psi"),
                      columns = "group1"))
s5b <- cwlStep(id = "splitEventsG2", run = Rsplit,
            In = list(files = list(source = list("psiPerEvent/outFile"),
                                  linkMerge = "merge_flattened"),
                      outfile = list(valueFrom  = "group2.psi"),
                      columns = "group2"))
s5c <- cwlStep(id = "splitExpG1", run = Rsplit,
            In = list(files = list(source = list("quantMerge/outFile"),
                                   linkMerge = "merge_flattened"),
                      outfile = list(valueFrom  = "group1.tpm"),
                      columns = "group1"))
s5d <- cwlStep(id = "splitExpG2", run = Rsplit,
            In = list(files = list(source = list("quantMerge/outFile"),
                                   linkMerge = "merge_flattened"),
                      outfile = list(valueFrom  = "group2.tpm"),
                      columns = "group2"))

#' diffSplice
#' @include tl_SUPPA_diffSplice.R
s6 <- cwlStep(id = "diffSplice", run = SUPPA_diffSplice,
           In = list(iox = "mergeEvents/out",
                     method = "method",
                     psi = list(source = list("splitEventsG1/outFile",
                                              "splitEventsG2/outFile"),
                                linkMerge = "merge_flattened"),
                     exp = list(source = list("splitExpG1/outFile",
                                              "splitExpG2/outFile"),
                                linkMerge = "merge_flattened"),
                     output = list(valueFrom = "diffSplice")))

o1 <- OutputParam(id = "res", type = "File[]", outputSource = "diffSplice/outFile")

req1 <- list(class = "MultipleInputFeatureRequirement")
req2 <- list(class = "InlineJavascriptRequirement")
req3 <- list(class = "StepInputExpressionRequirement")
SUPPA <- cwlWorkflow(requirements = list(req1, req2, req3),
                      inputs = InputParamList(p1a, p1b, p1c, p2, p3, p4, p5),
                      outputs = OutputParamList(o1))
SUPPA <- SUPPA + s1 + s2 + s3 + s4 + s5a + s5b + s5c + s5d + s6

