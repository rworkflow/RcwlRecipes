## https://github.com/xjtu-omics/msisensor-pro
p1 <- InputParam(id = "site", type = "File", prefix = "-d")
p2 <- InputParam(id = "nbam", type = "File", prefix = "-n", secondaryFile = ".bai")
p3 <- InputParam(id = "tbam", type = "File", prefix = "-t", secondaryFile = ".bai")
p4 <- InputParam(id = "outprefix", type = "string", prefix = "-o")
o1 <- OutputParam(id = "outs", type = "File[]", glob = "$(inputs.outprefix)*")
r1 <- requireDocker("pengjia1110/msisensor-pro")
msisensor_pro_msi <- cwlProcess(baseCommand = c("msisensor-pro", "msi"),
                                requirements = list(r1),
                                inputs = InputParamList(p1, p2, p3, p4),
                                outputs = OutputParamList(o1))
