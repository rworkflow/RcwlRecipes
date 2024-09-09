p1 <- InputParam(id = "acc", type = list("string", "File"), position = 99)
p2 <- InputParam(id = "split", type = "boolean", prefix = "--split-3", default = TRUE)
p3 <- InputParam(id = "guid", type = "string?", position = -1)
p4 <- InputParam(id = "gzip", type = "boolean?", prefix = "--gzip")
o1 <- OutputParam(id = "fqs", type = "File[]", glob = "*")
## req1 <- requireDocker("quay.io/biocontainers/sra-tools:2.11.0--pl5321h314213e_2")
req1 <- requireDocker("quay.io/biocontainers/sra-tools:3.1.0--h9f5acd7_0")
req2 <- requireInitialWorkDir(
    listing =
        list(Dirent(entryname = ".ncbi/user-settings.mkfg",
             entry = "/LIBS/GUID = '666666'")))
fastqdump <- cwlProcess(baseCommand = "fastq-dump",
                        requirements = list(req1, req2),
                        inputs = InputParamList(p1, p2, p3, p4),
                        outputs = OutputParamList(o1))


fastqdump <- addMeta(
    fastqdump,
    label = "fastqdump",
    doc = "tool for downloading sequencing reads from NCBI’s Sequence Read Archive (SRA). These sequence reads will be downloaded as FASTQ files.",
    inputLabels = c("acc","split","guid","gzip"),
    inputDocs = c("Accession Id","3-way splitting for mate-pairs. For each spot, if there are two biological reads satisfying filter conditions, the first is placed in the `*_1.fastq` file, and the second is placed in the `*_2.fastq` file. If there is only one biological read satisfying the filter conditions, it is placed in the `*.fastq` file.All otherreads in the spot are ignored.","Path to download file","Compress output using gzip: deprecated, not recommended"),
    outputLabels = c("fqs"),
    outputDocs = c("Downloaded fastq file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/ncbi/sra-tools",
        example = paste()
    )
)
