## https://github.com/genepattern/docker-mutsigcv

p1 <- InputParam(id = "maf", type = "File", position = 1)
p2 <- InputParam(id = "coverage", type = "File", position = 2)
p3 <- InputParam(id = "covar", type = "File", position = 3)
p4 <- InputParam(id = "sig", type = "string", position = 4)
o1 <- OutputParam(id = "sigout", type = "File", glob = "$(inputs.sig).sig_genes.txt")
req1 <- requireDocker("genepattern/docker-mutsigcv:2a")
req2 <- list(class = "EnvVarRequirement",
             envDef = list(MCR_INHIBIT_CTF_LOCK = "$(1)"))
MutSigCV <- cwlProcess(baseCommand = "gp_MutSigCV",
                       requirements = list(req1),
                       inputs = InputParamList(p1, p2, p3, p4),
                       outputs = OutputParamList(o1))
