## listOver
p1 <- InputParam(id = "oldFile", type = "File", position = 1)
p2 <- InputParam(id = "chain", type = "File", position = 2)
p3 <- InputParam(id = "newFile", type = "string", position = 3)
p4 <- InputParam(id = "unmap", type = "string", position = 4)
o1 <- OutputParam(id = "outFile", type = "File", glob = "$(inputs.newFile)")
o2 <- OutputParam(id = "unMap", type = "File", glob = "$(inputs.unmap)")
req1 <- requireDocker("biowardrobe2/ucscuserapps:v358_2")
liftOver <- cwlProcess(baseCommand = "liftOver",
                     requirements = list(req1),
                     inputs = InputParamList(p1, p2, p3, p4),
                     outputs = OutputParamList(o1, o2))


liftOver <- addMeta(
    liftOver,
    label = "liftOver",
    doc = "Lift over variants, positions, or intervals from one reference genome to another.",
    inputLabels = c("oldFile","chain","newFile","unmap"),
    inputDocs = c("Input file","chain file liftOver to perform the conversion between genome assemblies","New liftover file","Output file"),
    outputLabels = c("outFile","unMap"),
    outputDocs = c("Liftoverred file","file listing regions that could not be converted"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/ENCODE-DCC/kentUtils",
        example = paste()
    )
)
