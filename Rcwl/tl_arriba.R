## https://github.com/suhrig/arriba
p1 <- InputParam(id = "align", type = "File", prefix = "-x")
p2 <- InputParam(id = "out", type = "string", prefix = "-o")
p3 <- InputParam(id = "dout", type = "string", prefix = "-O")
p4 <- InputParam(id = "genome", type = "File", prefix = "-a", secondaryFiles = ".fai")
p5 <- InputParam(id = "gtf", type = "File", prefix = "-g")
p6 <- InputParam(id = "blacklist", type = "File", prefix = "-b")
p7 <- InputParam(id = "known", type = "File", prefix = "-k")
p8 <- InputParam(id = "tag", type = "File", prefix = "-t")
p9 <- InputParam(id = "protein", type = "File", prefix = "-p")
o1 <- OutputParam(id = "fout", type = "File", glob = "$(inputs.out)")
o2 <- OutputParam(id = "fOut", type = "File", glob = "$(inputs.dout)" )
req1 <- requireDocker(searchContainer("arriba")$container[1])
arriba <- cwlProcess(baseCommand = "arriba",
                     requirements = list(req1),
                     inputs = InputParamList(p1, p2, p3, p4, p5, p6, p7, p8, p9),
                     outputs = OutputParamList(o1, o2))
