suppressPackageStartupMessages(library(R.utils))
args <- commandArgs(trailingOnly = TRUE, asValues = TRUE)
hrd <-
function(seg, reference, seqz = TRUE, chr.in.names = FALSE){
    Sys.setenv(VROOM_CONNECTION_SIZE = 131072 * 10000)
    ss <- scarHRD::scar_score(seg, reference = reference, seqz = seqz, chr.in.names = chr.in.names)
    write.table(ss, "scarHRD.txt", row.names=FALSE, quote=FALSE, sep="\t")
}
do.call(hrd, args)
