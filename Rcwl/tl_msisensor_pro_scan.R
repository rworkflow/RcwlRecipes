## https://github.com/xjtu-omics/msisensor-pro
p1 <- InputParam(id = "ref", type = "File", prefix = "-d", secondaryFiles = ".fai")
p2 <- InputParam(id = "site", type = "string", prefix = "-o")
o1 <- OutputParam(id = "outsite", type = "File", glob = "$(inputs.site)")
r1 <- requireDocker("pengjia1110/msisensor-pro")
msisensor_pro_scan <- cwlProcess(baseCommand = c("msisensor-pro", "scan"),
                                 requirements = list(r1),
                                 inputs = InputParamList(p1, p2),
                                 outputs = OutputParamList(o1))


msisensor_pro_scan <- addMeta(
    msisensor_pro_scan,
    label = "msisensor_pro_scan",
    doc = "Scan a reference genome to identify microsatellite regions.",
    inputLabels = c("ref","site"),
    inputDocs = c("reference genome sequences file, *.fasta or *.fa format","output homopolymers and microsatellites file"),
    outputLabels = c("outsite"),
    outputDocs = c("Output files"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/xjtu-omics/msisensor-pro",
        example = paste()
    )
)
