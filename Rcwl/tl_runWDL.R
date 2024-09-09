## RUN WDL
p1 <- InputParam(id = "cromwell", type = "File", position = 1, prefix = "-jar")
p2 <- InputParam(id = "run", type = "string", default = "run", position = 2)
p3 <- InputParam(id = "wdl", type = "File", position = 3)
p4 <- InputParam(id = "json", type = "File", position = 4, prefix = "-i")
o1 <- OutputParam(id = "log", type = "File", glob="$(inputs.wdl.basename).log")
runWDL <- cwlProcess(baseCommand = "java",
                   inputs = InputParamList(p1, p2, p3, p4),
                   outputs = OutputParamList(o1),
                   stdout = "$(inputs.wdl.basename).log")


runWDL <- addMeta(
    runWDL,
    label = "runWDL",
    doc = "Run WDL",
    inputLabels = c("cromwell","run","wdl","json"),
    inputDocs = c("The path to the Cromwell JAR executable.","The command to run the workflow (run by default).","The WDL file defining the workflow to execute.","A JSON file specifying input values for the WDL workflow."),
    outputLabels = c("log"),
    outputDocs = c("The log file capturing the output of the Cromwell execution, named based on the WDL script file."),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/openwdl/wdl",
        example = paste()
    )
)
