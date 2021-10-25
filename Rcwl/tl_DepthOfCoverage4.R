
p1 <- InputParam(id = "bam", type = "File",
                 prefix = "-I", secondaryFiles = list(".bai?", "^.bai?"))
p2 <- InputParam(id = "prefix", type = "string", prefix = "-O")
p3 <- InputParam(id = "region", type = "File", prefix = "-L")
p4 <- InputParam(id = "ref", type = "File",
                 prefix = "-R", secondaryFiles = c(".fai", "^.dict"))
p5 <- InputParam(id = "ct", type = InputArrayParam(items = "int",
                                                   prefix = "--summary-coverage-threshold"),
                 default = list(1L, 10L, 20L, 30L))
o1 <- OutputParam(id = "out", type = "File", glob = "$(inputs.prefix).sample_summary")

req1 <- list(class = "DockerRequirement",
             dockerPull = "broadinstitute/gatk:latest")
DepthOfCoverage4 <- cwlProcess(cwlVersion = "v1.2",
                               baseCommand = c("gatk", "DepthOfCoverage"),
                               requirements = list(req1),
                               inputs = InputParamList(p1, p2, p3, p4, p5),
                               outputs = OutputParamList(o1))
