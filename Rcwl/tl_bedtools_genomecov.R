## bam to bedgraph
p1 <- InputParam(id = "bam", type = "File", prefix = "-ibam")
p2 <- InputParam(id = "bedgraph", type = "boolean", prefix = "-bg", default = TRUE)
o1 <- OutputParam(id = "bed", type = "File", glob = "*.bedgraph")
req1 <- list(class = "DockerRequirement",
             dockerPull = "quay.io/biocontainers/bedtools:2.29.2--hc088bd4_0")
bedtools_genomecov <- cwlParam(baseCommand = c("bedtools", "genomecov"),
                               requirements = list(req1),
                               inputs = InputParamList(p1, p2),
                               outputs = OutputParamList(o1),
                               stdout = "$(inputs.bam.nameroot).bedgraph")
