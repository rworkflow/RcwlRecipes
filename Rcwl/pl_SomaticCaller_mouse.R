
p1 <- InputParam(id = "tbam", type = "File", secondaryFiles = ".bai")
p2 <- InputParam(id = "nbam", type = "File", secondaryFiles = ".bai")
p3 <- InputParam(id = "Ref", type = "File",
                 secondaryFiles = c(".fai", "^.dict"))
p4 <- InputParam(id = "normal", type = "string")
p5 <- InputParam(id = "tumor", type = "string")
p6 <- InputParam(id = "dbsnp", type = "File",
                 secondaryFiles = "$(self.nameext == '.gz' ? self.basename+'.tbi' : self.basename+'.idx')")
## p7 <- InputParam(id = "gresource", type = "File",
##                  secondaryFiles = "$(self.nameext == '.gz' ? self.basename+'.tbi' : self.basename+'.idx')")
## p8 <- InputParam(id = "pon", type = "File",
##                  secondaryFiles = "$(self.nameext == '.gz' ? self.basename+'.tbi' : self.basename+'.idx')")
p9 <- InputParam(id = "interval", type = "File")
## p10 <- InputParam(id = "comvcf", type = "File",
##                   secondaryFiles = "$(self.nameext == '.gz' ? self.basename+'.tbi' : self.basename+'.idx')")
## p11 <- InputParam(id = "filter", type = "string", default = "PASS")
p12 <- InputParam(id = "threads", type = "int", default = 8)

#' @include tl_Mutect2.R
s1 <- cwlStep(id = "Mutect2", run = Mutect2,
           In = list(tbam = "tbam",
                     nbam = "nbam",
                     Ref = "Ref",
                     normal = "normal",
                     ##tumor = "tumor",
                     out = list(source = list("tumor", "normal"),
                                valueFrom = "$(self[0])_$(self[1])_mutect2.vcf"),
                     threads = "threads",
                     interval = "interval"))

#' @include tl_MuSE.R
s2 <- cwlStep(id = "MuSE", run = MuSE,
           In = list(tbam = "tbam",
                     nbam = "nbam",
                     ref = "Ref",
                     region = "interval",
                     dbsnp = "dbsnp",
                     vcf = list(source = list("tumor", "normal"),
                                valueFrom = "$(self[0])_$(self[1])_MuSE.vcf")))
#' @include pl_mantaStrelka.R tl_bgzip.R tl_tabix_index.R
s3a <- cwlStep(id = "bgzip", run = bgzip,
            In = list(ifile = "interval"))
s3b <- cwlStep(id = "tabixIndex", run = tabix_index,
            In = list(tfile = "bgzip/zfile",
                      type = list(valueFrom = "bed")))
s3 <- cwlStep(id = "mantaStrelka", run = mantaStrelka,
           In = list(tbam = "tbam",
                     nbam = "nbam",
                     ref = "Ref",
                     region = "tabixIndex/idx"))

#' @include tl_VarDict.R
s4 <- cwlStep(id = "VarDict", run = VarDict,
           In = list(tbam = "tbam",
                     nbam = "nbam",
                     ref = "Ref",
                     region = "interval",
                     threads = "threads",
                     vcf = list(source = list("tumor", "normal"),
                                valueFrom = "$(self[0])_$(self[1])_VarDict.vcf"),
                     af = list(valueFrom = "0.05")))

varcombiner <- function(ss, si, m2, mu, vd, id_t, id_n){
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

v1 <- InputParam(id = "ss", type = "File", prefix = "ss=", separate = FALSE)
v2 <- InputParam(id = "si", type = "File", prefix = "si=", separate = FALSE)
v3 <- InputParam(id = "m2", type = "File", prefix = "m2=", separate = FALSE)
v4 <- InputParam(id = "mu", type = "File", prefix = "mu=", separate = FALSE)
v5 <- InputParam(id = "vd", type = "File", prefix = "vd=", separate = FALSE)
v6 <- InputParam(id = "tid", type = "string", prefix = "id_t=", separate = FALSE)
v7 <- InputParam(id = "nid", type = "string", prefix = "id_n=", separate = FALSE)
vo1 <- OutputParam(id = "cvcf", type = "File", glob = "*_strelka2_mutect2_muse_vardict.vcf")
Var4Combiner <- cwlProcess(baseCommand = varcombiner,
                           inputs = InputParamList(v1, v2, v3, v4, v5, v6, v7),
                           outputs = OutputParamList(vo1))

s5 <- cwlStep(id = "combine", run = Var4Combiner,
              In = list(m2 = "Mutect2/vout",
                        vd = "VarDict/outVcf",
                        mu = "MuSE/outVcf",
                        ss = "mantaStrelka/snvs",
                        si = "mantaStrelka/indels",
                        tid = "tumor",
                        nid = "normal"))

## o1a <- OutputParam(id = "mutect2filterVCF", type = "File", outputSource = "Mutect2PL/filterVCF")
## o1b <- OutputParam(id = "mutect2passVCF", type = "File", outputSource = "Mutect2PL/passVCF")
## o1c <- OutputParam(id = "mutect2conTable", type = "File", outputSource = "Mutect2PL/conTable")
## o1d <- OutputParam(id = "mutect2segment", type = "File", outputSource = "Mutect2PL/segment")
o1 <- OutputParam(id = "mutect2out", type = "File", outputSource = "Mutect2/vout")
o2 <- OutputParam(id = "MuSEout", type = "File", outputSource = "MuSE/outVcf")
o3a <- OutputParam(id = "strelka2snv", type = "File", outputSource = "mantaStrelka/snvs")
o3b <- OutputParam(id = "strelka2indel", type = "File", outputSource = "mantaStrelka/indels")
o4 <- OutputParam(id = "VarDictout", type = "File", outputSource = "VarDict/outVcf")
o5 <- OutputParam(id = "combineVcf", type = "File", outputSource = "combine/cvcf")

req1 <- list(class = "InlineJavascriptRequirement")
req2 <- list(class = "StepInputExpressionRequirement")
req3 <- list(class = "SubworkflowFeatureRequirement")
req4 <- list(class = "MultipleInputFeatureRequirement")
SomaticCaller_mouse <- cwlWorkflow(requirements = list(req1, req2, req3, req4),
                                   inputs = InputParamList(p1, p2, p3, p4, p5, p6, p9, p12),
                                   outputs = OutputParamList(o1, o2,
                                                             o3a, o3b, o4, o5))

SomaticCaller_mouse <- SomaticCaller_mouse + s1 + s2 + s3a + s3b + s3 + s4 +s5

