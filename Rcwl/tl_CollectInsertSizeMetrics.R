p1 <- InputParam(id = "bam", type = "File", prefix = "I=", separate = FALSE)
p2 <- InputParam(id = "metrics", type = "string", prefix = "O=", separate = FALSE)
p3 <- InputParam(id = "hist", type = "string", prefix = "H=", separate = FALSE)
o1 <- OutputParam(id = "Metrics", type = "File", glob = "$(inputs.metrics)")
o2 <- OutputParam(id = "Hist", type = "File", glob = "$(inputs.hist)")
req1 <- requireDocker("quay.io/biocontainers/picard:2.21.1--0")
CollectInsertSizeMetrics <- cwlParam(baseCommand = c("picard", "CollectInsertSizeMetrics"),
                                     requirements = list(req1),
                                     inputs = InputParamList(p1, p2, p3),
                                     outputs = OutputParamList(o1, o2))
