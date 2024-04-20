## https://github.com/mskilab-org/JaBbA

p1 <- InputParam(id = "junction", type = "File", position = 1)
p2 <- InputParam(id = "coverage", type = "File", position = 2)
p3 <- InputParam(id = "gurobi", type = "string?",
                 prefix = "--gurobi", position = 3, default="TRUE")
p4 <- InputParam(id = "slack", type = "int?",
                 prefix = "--slack", position  = 4)
p5 <- InputParam(id = "license", type = "File", position = -1)
o1 <- OutputParam(id = "gg", type = "File", glob = "jabba.simple.gg.rds")
o2 <- OutputParam(id = "plot", type = "File", glob = "karyograph.rds.ppfit.png")
o3 <- OutputParam(id = "seg", type = "File", glob = "jabba.seg")
o4 <- OutputParam(id = "report", type = "File", glob = "opt.report.rds")
req1 <- requireDocker("hubentu/jabba")
req2 <- requireEnvVar(list(
    GRB_LICENSE_FILE="$(inputs.license.path)"))
req3 <- requireJS()
jabba <- cwlProcess(baseCommand = "jba",
                    requirements = list(req1, req2, req3),
                    inputs = InputParamList(p1, p2, p3, p4, p5),
                    outputs = OutputParamList(o1, o2, o3, o4))
