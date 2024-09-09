
p1 <- InputParam(id = "tfile", type = "File", position = 1)
p2 <- InputParam(id = "type", type = "string",
                 prefix = "-p", default = "vcf")
o1 <- OutputParam(id = "idx", type = "File", glob = "$(inputs.tfile.basename)",
                  secondaryFiles = list(".tbi"))
req1 <- list(class = "DockerRequirement",
             dockerPull = "biocontainers/tabix:v1.3.2-2-deb_cv1")
req2 <- list(class = "InitialWorkDirRequirement",
             listing = list("$(inputs.tfile)"))
tabix_index <- cwlProcess(baseCommand = "tabix",
                        requirements = list(req1, req2),
                        inputs = InputParamList(p1, p2),
                        outputs = OutputParamList(o1))


tabix_index <- addMeta(
    tabix_index,
    label = "tabix_index",
    doc = "Tabix indexes a TAB-delimited genome position file in.tab.bgz and creates an index file",
    inputLabels = c("tfile","type"),
    inputDocs = c("Tab file","gff, bed, sam, vcf"),
    outputLabels = c("idx"),
    outputDocs = c("tab index file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/samtools/htslib",
        example = paste()
    )
)
