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


rMATS_task <- addMeta(
    rMATS_task,
    label = "rMATS_task",
    doc = "Provide a flexible and efficient way to run the rMATS software on large RNA-Seq datasets in a distributed computing environment.",
    inputLabels = c("task","outdir","tmp","darts","threads"),
    inputDocs = c("Specify which step(s) of rMATS-turbo to run. Default:both. prep: preprocess BAM files and generate .rmats files. post: load .rmats files into memory, detect and count alternative splicing events, and calculate P value (if not --statoff). both: prep + post. inte (integrity): check that the BAM filenames recorded by the prep task(s) match the BAM filenames for the current command line. stat: run statistical test on existing output files","The directory for final output from the post step","The directory for intermediate output such as '.rmats' files from the prep step","Use the DARTS statistical model","The number of threads. The optimal number of threads should be equal to the number of CPU cores. Default: 1"),
    outputLabels = c("res"),
    outputDocs = c("Alternative splice information"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/Xinglab/rmats-turbo",
        example = paste()
    )
)
