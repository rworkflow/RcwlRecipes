vcfbed <- function(vcf, out, window = 200){
    reg <- read.table(vcf, comment = "#", sep = "\t")
    bed <- cbind(reg[,1], reg[,2]-window, reg[,2]+window)
    bed <- unique(bed)
    write.table(bed, out, row.names = FALSE, col.names = FALSE, quote = FALSE, sep = "\t")
}

i1 <- InputParam(id = "vcf", type = "File", prefix = "vcf=", separate = FALSE)
i2 <- InputParam(id = "out", type = "string", prefix = "out=", separate = FALSE)
i3 <- InputParam(id = "window", type = "int", prefix = "window=", separate = FALSE,
                 default = 200L)
o1 <- OutputParam(id = "bed", type = "File", glob = "$(inputs.out)")
req1 <- requireDocker("hubentu/r-utils")
vcf2bed <- cwlProcess(baseCommand = vcfbed,
                      requirements = list(req1),
                      inputs = InputParamList(i1, i2, i3),
                      outputs = OutputParamList(o1))
