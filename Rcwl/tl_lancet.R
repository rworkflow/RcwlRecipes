## https://github.com/nygenome/lancet

p1 <- InputParam(id = "tbam", type = "File", prefix = "--tumor",
                 secondaryFiles = list("^.bai?", ".bai?"))
p2 <- InputParam(id = "nbam", type = "File", prefix = "--normal",
                 secondaryFiles = list("^.bai?", ".bai?"))
p3 <- InputParam(id = "ref", type = "File", prefix = "--ref",
                 secondaryFiles = ".fai")
p4 <- InputParam(id = "bed", type = "File?", prefix = "--bed")
p5 <- InputParam(id = "reg", type = "string?", prefix = "--reg")
p6 <- InputParam(id = "threads", type = "int", prefix = "--num-threads")
o1 <- OutputParam(id = "vcf", type = "File", glob = "$(inputs.tbam.namerooot)_lancet.vcf")
req1 <- requireDocker("hubentu/lancet")
lancet <- cwlProcess(cwlVersion = "v1.2",
                     baseCommand = "lancet",
                     requirements = list(req1),
                     inputs = InputParamList(p1, p2, p3, p4, p5, p6),
                     outputs = OutputParamList(o1),
                     stdout = "$(inputs.tbam.namerooot)_lancet.vcf")
