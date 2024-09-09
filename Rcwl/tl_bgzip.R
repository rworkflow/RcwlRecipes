## bgzip -c file > file.gz
p1 <- InputParam(id = "ifile", type = "File")
o1 <- OutputParam(id = "zfile", type = "File", glob = "$(inputs.ifile.basename).gz")
req1 <- list(class = "DockerRequirement",
             dockerPull = "biocontainers/tabix:v1.3.2-2-deb_cv1")
bgzip <- cwlProcess(baseCommand = c("bgzip", "-c"),
                  requirements = list(req1),
                  inputs = InputParamList(p1),
                  outputs = OutputParamList(o1),
                  stdout = "$(inputs.ifile.basename).gz")


bgzip <- addMeta(
    bgzip,
    label = "bgzip",
    doc = "Bgzip compresses files in a similar manner to, and compatible with, gzip(1). The file is compressed into a series of small (less than 64K) 'BGZF' blocks. This allows indexes to be built against the compressed file and used to retrieve portions of the data without having to decompress the entire file.",
    inputLabels = c("ifile"),
    inputDocs = c("Input file"),
    outputLabels = c("zfile"),
    outputDocs = c("Commpressed file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "NA",
        example = paste()
    )
)
