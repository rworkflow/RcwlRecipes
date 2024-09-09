## Merge somatic vcfs from Mutect2, MuSE, Strelka2
mergeVcf3 <- function(vcf_mt, vcf_ms, vcf_ss, vcf_si, id_t, id_n, outvcf){
    library(VariantCombiner)
    ## merge mutect and muse
    v_m <- MergeSomatic(vcf_mt, vcf_ms, sources = c("mutect2", "MuSE"),
                        GENO = c(GT = 1, DP = 1, AD = 1),
                        id_t = id_t, id_n = id_n, pass_only = TRUE)
    ## merge strelka snv and indel
    v1 <- readVcf(vcf_ss)
    v2 <- readVcf(vcf_si)
    v1a <- strelka_snv(v1)
    v2a <- strelka_indel(v2)
    v_s <- MergeSomatic(v1a, v2a, sources = c("strelka2", "strelka2"),
                        GENO = c(GT = 1, DP = 1, AD = 1),
                        id_t = id_t, id_n = id_n, pass_only = TRUE)

    vm <- MergeSomatic(v_m, v_s, sources = c("", ""),
                       GENO = c(GT = 1, DP = 1, AD = 1),
                       id_t = id_t, id_n = id_n)
    writeVcf(vm, outvcf)
}

i1 <- InputParam(id = "mutect", type = "File", prefix = "vcf_mt=", separate = FALSE)
i2 <- InputParam(id = "muse", type = "File", prefix = "vcf_ms=", separate = FALSE)
i3 <- InputParam(id = "strelka_s", type = "File", prefix = "vcf_ss=", separate = FALSE)
i4 <- InputParam(id = "strelka_i", type = "File", prefix = "vcf_si=", separate = FALSE)
i5 <- InputParam(id = "id_t", type = "string", prefix = "id_t=", separate = FALSE)
i6 <- InputParam(id = "id_n", type = "string", prefix = "id_n=", separate = FALSE)
i7 <- InputParam(id = "outvcf", type = "string", prefix = "outvcf=", separate = FALSE)
o1 <- OutputParam(id = "ovcf", type = "File", glob = "$(inputs.outvcf)")

req1 <- requireDocker("hubentu/variantcombiner")
MergeVcf_MMS <- cwlProcess(baseCommand = mergeVcf3,
                           requirements = list(req1),
                           inputs = InputParamList(i1, i2, i3, i4, i5, i6, i7),
                           outputs = OutputParamList(o1))


MergeVcf_MMS <- addMeta(
    MergeVcf_MMS,
    label = "MergeVcf_MMS",
    doc = "Merge somatic vcfs from Mutect2, MuSE, Strelka2",
    inputLabels = c("mutect","muse","strelka_s","strelka_i","id_t","id_n","outvcf"),
    inputDocs = c("Mutect file","Muse file","Strelka SNV file","Strelka Indel file","Tumor ID","Normal ID","Output vcf file name"),
    outputLabels = c("ovcf"),
    outputDocs = c("Merged vcf file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "NA",
        example = paste()
    )
)
