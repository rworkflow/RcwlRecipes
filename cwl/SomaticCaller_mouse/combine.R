suppressPackageStartupMessages(library(R.utils))
args <- commandArgs(trailingOnly = TRUE, asValues = TRUE)
combine <-
function(ss, si, m2, mu, vd, id_t, id_n){
    ## combine
    library(VariantCombiner)

    v1a <- readVcf(ss)
    v1a <- v1a[fixed(v1a)$FILTER == "PASS"]
    v1b <- readVcf(si)
    v1b <- v1b[fixed(v1b)$FILTER == "PASS"]
    s1a <- strelka_snv(v1a)
    s1b <- strelka_indel(v1b)
    ## strelka2
    v_s <- SomaticCombiner(s1a, s1b, sources = c("strelka2", "strelka2"),
                        GENO = c(GT = 1, DP = 1, AD = 1),
                        id_t = id_t, id_n = id_n)
    ## mutect2
    m2v <- readVcf(m2)
    ## m2v <- m2v[fixed(m2v)$FILTER == "PASS"]
    v_m <- SomaticCombiner(m2v, v_s, source = c("mutect2", "strelka2"),
                        GENO = c(GT = 1, DP = 1, AD = 1),
                        id_t = id_t, id_n = id_n)
    
    ## muse
    mu1 <- readVcf(mu)
    mu1 <- mu1[fixed(mu1)$FILTER == "PASS"]
    v_m <- SomaticCombiner(v_m, mu1, source = c("", "muse"),
                        GENO = c(GT = 1, DP = 1, AD = 1),
                        id_t = id_t, id_n = id_n)
    ## vardict
    vd1 <- readVcf(vd)
    vd1 <- vd1[info(vd1)$STATUS == "StrongSomatic" & fixed(vd1)$FILTER == "PASS"]
    vd1 <- vd1[!info(vd1)$TYPE %in% c("DEL", "DUP", "INV")]
    v_m <- SomaticCombiner(v_m, vd1, source = c("", "vardict"),
                        GENO = c(GT = 1, DP = 1, AD = 1),
                        id_t = id_t, id_n = id_n)
    writeVcf(v_m, paste0(id_t, "_", id_n, "_strelka2_mutect2_muse_vardict.vcf"))
}
do.call(combine, args)
