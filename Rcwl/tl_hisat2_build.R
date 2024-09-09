## hisat2:v2.0.5-1-deb_cv1
## The ref does not exceed 4 billion characters
## Basename of "ref" should be exactly same with Name of "outPrefix" 

req1 <- list(class = "DockerRequirement",
             dockerPull = "biocontainers/hisat2:v2.0.5-1-deb_cv1")
p1 <- InputParam(id = "ref", type = "File", position = 1)
p2 <- InputParam(id = "outPrefix", type = "string", position = 2)
o1 <- OutputParam(id = "idx", type = "File[]", 
                  glob = "$(inputs.outPrefix).*")
hisat2_build <- cwlProcess(baseCommand = c("hisat2-build"), 
                         requirements = list(req1),
                         inputs = InputParamList(p1, p2), 
                         outputs = OutputParamList(o1))


hisat2_build <- addMeta(
    hisat2_build,
    label = "hisat2_build",
    doc = "hisat2-build builds a HISAT2 index from a set of DNA sequences.",
    inputLabels = c("ref","outPrefix"),
    inputDocs = c("comma-separated list of files with ref sequences","write ht2 data to files with this dir/basename"),
    outputLabels = c("idx"),
    outputDocs = c("Output indexed file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/DaehwanKimLab/hisat2",
        example = paste()
    )
)
