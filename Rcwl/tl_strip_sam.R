p1 <- InputParam(id = "sam", type = "File")
o1 <- OutputParam(id = "strip", type = "File", glob = "*_stripped.sam")
req1 <- requireInitialWorkDir(listing = list("$(inputs.sam)"))
req2 <- requireDocker("hubentu/rrbs")
strip_sam <- cwlProcess(baseCommand = c("bash", "/opt/strip_bismark_sam.sh"),
                        requirements = list(req1, req2),
                        inputs = InputParamList(p1),
                        outputs = OutputParamList(o1))
