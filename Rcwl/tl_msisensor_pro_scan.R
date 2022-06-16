## https://github.com/xjtu-omics/msisensor-pro
p1 <- InputParam(id = "ref", type = "File", prefix = "-d", secondaryFiles = ".fai")
p2 <- InputParam(id = "site", type = "string", prefix = "-o")
o1 <- OutputParam(id = "outsite", type = "File", glob = "$(inputs.site)")
r1 <- requireDocker("pengjia1110/msisensor-pro")
msisensor_pro_scan <- cwlProcess(baseCommand = c("msisensor-pro", "scan"),
                                 requirements = list(r1),
                                 inputs = InputParamList(p1, p2),
                                 outputs = OutputParamList(o1))
