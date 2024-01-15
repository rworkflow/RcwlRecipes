# https://github.com/Xinglab/rmats-turbo
p1 <- InputParam(id = "task", type = "string", prefix = "--task", default = "stat")
p2 <- InputParam(id = "outdir", type = "Directory", prefix = "--od")
p3 <- InputParam(id = "tmp", type = "string?", prefix = "--tmp", default = "tmp")
p4 <- InputParam(id = "darts", type = "boolean?", prefix = "--darts-model")
p5 <- InputParam(id = "threads", type = "int", prefix = "--nthread")
o1 <- OutputParam(id = "res", type = "File[]", glob = "$(inputs.outdir.basename)/*.txt")
req1 <- requireDocker("rmats_darts")
req2 <- list(class = "InitialWorkDirRequirement",
             listing = list(
                 list(entry = "$(inputs.outdir)",
                      writable = TRUE)))
## req2 <- requireInitialWorkDir(
##     listing = list(
##         Dirent(entry = "$(inputs.outdir)",
##                writable=TRUE,
##                entryname = "workdir")))
rMATS_task <- cwlProcess(cwlVersion = "v1.2",
                          baseCommand = c("python", "/rmats/rmats.py"),
                          requirements = list(req1, req2),
                          inputs = InputParamList(p1, p2, p3, p4, p5),
                          outputs = OutputParamList(o1))
