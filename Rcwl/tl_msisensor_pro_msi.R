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


msisensor_pro_msi <- addMeta(
    msisensor_pro_msi,
    label = "msisensor_pro_msi",
    doc = "MSIsensor-pro evaluates Microsatellite Instability (MSI) for cancer patients with next generation sequencing data.",
    inputLabels = c("site","nbam","tbam","outprefix"),
    inputDocs = c("homopolymers and microsatellites file","normal bam file with index","tumor bam file with index","output prefix"),
    outputLabels = c("outs"),
    outputDocs = c("Output files"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/xjtu-omics/msisensor-pro",
        example = paste()
    )
)
