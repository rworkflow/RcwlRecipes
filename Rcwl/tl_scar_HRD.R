scar_hrd <- function(seg, reference, seqz = TRUE, chr.in.names = FALSE){
    Sys.setenv(VROOM_CONNECTION_SIZE = 131072 * 10000)
    ss <- scarHRD::scar_score(seg, reference = reference, seqz = seqz, chr.in.names = chr.in.names)
    write.table(ss, "scarHRD.txt", row.names=FALSE, quote=FALSE, sep="\t")
}
p1 <- InputParam(id = "seg", type = "File", position = 1)
p2 <- InputParam(id = "reference", type = "string", position = 2)
o1 <- OutputParam(id = "HRD", type = "File", glob = "scarHRD.txt")
scar_HRD <- cwlProcess(baseCommand = scar_hrd,
                       inputs = InputParamList(p1, p2),
                       outputs = OutputParamList(o1))


scar_HRD <- addMeta(
    scar_HRD,
    label = "scar_HRD",
    doc = "Calculates the Homologous Recombination Deficiency (HRD) score",
    inputLabels = c("seg","reference"),
    inputDocs = c("Segmentation file (typically a tab-delimited text file) containing information about copy number alterations in the genome.","reference genome version (e.g., 'hg19' or 'hg38')"),
    outputLabels = c("HRD"),
    outputDocs = c("A text file containing the computed HRD scores"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/OSU-SRLab/scarHRD",
        example = paste()
    )
)
