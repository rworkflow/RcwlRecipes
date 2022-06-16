## https://github.com/dnanexus-rnd/GLnexus
p1 <- InputParam(id = "config", type = "string", prefix = "--config")
p2 <- InputParam(id = "bed", type = "File?", prefix = "--bed")
p3 <- InputParam(id = "gvcfs", type = "File[]", position = -1)
p4 <- InputParam(id = "ovcf", type = "string", position = -1)
p5 <- InputParam(id = "threads", type = "int", prefix = "-t")
o1 <- OutputParam(id = "bcf", type = "File", glob = "$(inputs.ovcf)")

req1 <- requireDocker("ghcr.io/dnanexus-rnd/glnexus:v1.4.1")
req2 <- requireManifest("gvcfs")
req3 <- requireJS()
glnexus_cli_list <- cwlProcess(baseCommand = "glnexus_cli",
                               requirements = list(req1, req2, req3),
                               arguments = list("--list", "gvcfs"),
                               inputs = InputParamList(p1, p2, p3, p4, p5),
                               outputs = OutputParamList(o1),
                               stdout = "$(inputs.ovcf)")
