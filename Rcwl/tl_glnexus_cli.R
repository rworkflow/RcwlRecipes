## https://github.com/dnanexus-rnd/GLnexus
p1 <- InputParam(id = "config", type = "string", prefix = "--config")
p2 <- InputParam(id = "bed", type = "File?", prefix = "--bed")
p3 <- InputParam(id = "gvcfs", type = "File[]")
p4 <- InputParam(id = "ovcf", type = "string", position = -1)
o1 <- OutputParam(id = "bcf", type = "File", glob = "$(inputs.ovcf)")

req1 <- requireDocker("quay.io/mlin/glnexus:v1.3.1")
glnexus_cli <- cwlProcess(baseCommand = "/usr/local/bin/glnexus_cli",
                          requirements = list(req1),
                          inputs = InputParamList(p1, p2, p3, p4),
                          outputs = OutputParamList(o1),
                          stdout = "$(inputs.ovcf)")
