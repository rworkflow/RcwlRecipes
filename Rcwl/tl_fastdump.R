p1 <- InputParam(id = "acc", type = list("string", "File"), position = 99)
p2 <- InputParam(id = "split", type = "boolean", prefix = "--split-3", default = TRUE)
p3 <- InputParam(id = "guid", type = "string", position = -1)
o1 <- OutputParam(id = "fqs", type = "File[]", glob = "*.fastq")
req1 <- requireDocker("quay.io/biocontainers/sra-tools:2.11.0--pl5321h314213e_2")
req2 <- requireInitialWorkDir(
    listing =
        list(Dirent(entryname = ".ncbi/user-settings.mkfg",
             entry = "/LIBS/GUID = '666666'")))
fastqdump <- cwlProcess(baseCommand = "fastq-dump",
                        requirements = list(req1, req2),
                        inputs = InputParamList(p1, p2),
                        outputs = OutputParamList(o1))
