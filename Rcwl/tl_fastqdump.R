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
