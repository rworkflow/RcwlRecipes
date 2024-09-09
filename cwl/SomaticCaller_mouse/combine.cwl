cwlVersion: v1.0
class: CommandLineTool
baseCommand: Rscript
requirements:
- class: InitialWorkDirRequirement
  listing:
  - entryname: combine.R
    entry: "suppressPackageStartupMessages(library(R.utils))\nargs <- commandArgs(trailingOnly
      = TRUE, asValues = TRUE)\ncombine <-\nfunction(ss, si, m2, mu, vd, id_t, id_n){\n
      \   ## combine\n    library(VariantCombiner)\n\n    v1a <- readVcf(ss)\n    v1a
      <- v1a[fixed(v1a)$FILTER == \"PASS\"]\n    v1b <- readVcf(si)\n    v1b <- v1b[fixed(v1b)$FILTER
      == \"PASS\"]\n    s1a <- strelka_snv(v1a)\n    s1b <- strelka_indel(v1b)\n    ##
      strelka2\n    v_s <- SomaticCombiner(s1a, s1b, sources = c(\"strelka2\", \"strelka2\"),\n
      \                       GENO = c(GT = 1, DP = 1, AD = 1),\n                        id_t
      = id_t, id_n = id_n)\n    ## mutect2\n    m2v <- readVcf(m2)\n    ## m2v <-
      m2v[fixed(m2v)$FILTER == \"PASS\"]\n    v_m <- SomaticCombiner(m2v, v_s, source
      = c(\"mutect2\", \"strelka2\"),\n                        GENO = c(GT = 1, DP
      = 1, AD = 1),\n                        id_t = id_t, id_n = id_n)\n    \n    ##
      muse\n    mu1 <- readVcf(mu)\n    mu1 <- mu1[fixed(mu1)$FILTER == \"PASS\"]\n
      \   v_m <- SomaticCombiner(v_m, mu1, source = c(\"\", \"muse\"),\n                        GENO
      = c(GT = 1, DP = 1, AD = 1),\n                        id_t = id_t, id_n = id_n)\n
      \   ## vardict\n    vd1 <- readVcf(vd)\n    vd1 <- vd1[info(vd1)$STATUS == \"StrongSomatic\"
      & fixed(vd1)$FILTER == \"PASS\"]\n    vd1 <- vd1[!info(vd1)$TYPE %in% c(\"DEL\",
      \"DUP\", \"INV\")]\n    v_m <- SomaticCombiner(v_m, vd1, source = c(\"\", \"vardict\"),\n
      \                       GENO = c(GT = 1, DP = 1, AD = 1),\n                        id_t
      = id_t, id_n = id_n)\n    writeVcf(v_m, paste0(id_t, \"_\", id_n, \"_strelka2_mutect2_muse_vardict.vcf\"))\n}\ndo.call(combine,
      args)"
    writable: false
arguments:
- combine.R
inputs:
  ss:
    type: File
    inputBinding:
      prefix: ss=
      separate: false
  si:
    type: File
    inputBinding:
      prefix: si=
      separate: false
  m2:
    type: File
    inputBinding:
      prefix: m2=
      separate: false
  mu:
    type: File
    inputBinding:
      prefix: mu=
      separate: false
  vd:
    type: File
    inputBinding:
      prefix: vd=
      separate: false
  tid:
    type: string
    inputBinding:
      prefix: id_t=
      separate: false
  nid:
    type: string
    inputBinding:
      prefix: id_n=
      separate: false
outputs:
  cvcf:
    type: File
    outputBinding:
      glob: '*_strelka2_mutect2_muse_vardict.vcf'
