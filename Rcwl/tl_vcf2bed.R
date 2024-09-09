script <- "
vcf=$1
fai=$2
win=$3

vn=`basename $vcf .bed`
awk '{if($0 !~ \"^#\")print $1\"\\t\"$2-1\"\\t\"$2}' $vcf > vcfbed
bedtools slop -i vcfbed -b $win -g $fai > $vn.$win.bed
"
p1 <- InputParam(id = "vcf", type = "File", position = 1)
p2 <- InputParam(id = "fai", type = "File", position = 2)
p3 <- InputParam(id = "win", type = "int", position = 3)
o1 <- OutputParam(id = "bed", type = "File", glob = "*.bed")
req1 <- requireDocker("quay.io/biocontainers/bedtools:2.30.0--h7d7f7ad_2")
req2 <- requireShellScript(script)
vcf2bed <- cwlProcess(cwlVersion = "v1.2",
                        baseCommand = ShellScript(),
                        requirements = list(req1, req2),
                        inputs = InputParamList(p1, p2, p3),
                        outputs = OutputParamList(o1))

## vcfbed <- function(vcf, out, window = 200){
##     reg <- read.table(vcf, comment = "#", sep = "\t")
##     bed <- cbind(reg[,1], reg[,2]-window, reg[,2]+window)
##     bed <- unique(bed)
##     write.table(bed, out, row.names = FALSE, col.names = FALSE, quote = FALSE, sep = "\t")
## }

## i1 <- InputParam(id = "vcf", type = "File", prefix = "vcf=", separate = FALSE)
## i2 <- InputParam(id = "out", type = "string", prefix = "out=", separate = FALSE)
## i3 <- InputParam(id = "window", type = "int", prefix = "window=", separate = FALSE,
##                  default = 200L)
## o1 <- OutputParam(id = "bed", type = "File", glob = "$(inputs.out)")
## req1 <- requireDocker("hubentu/r-utils")
## vcf2bed <- cwlProcess(baseCommand = vcfbed,
##                       requirements = list(req1),
##                       inputs = InputParamList(i1, i2, i3),
##                       outputs = OutputParamList(o1))


vcf2bed <- addMeta(
    vcf2bed,
    label = "vcf2bed",
    doc = "Convert vcf file to bed file",
    inputLabels = c("vcf","fai","win","out","window"),
    inputDocs = c("Input vcf file","Genome index file (FAI) for chromosome size constraints.","Integer window size around each variant.","Name of the output","Integer window size around each variant."),
    outputLabels = c("bed","bed"),
    outputDocs = c("Output bed file","Output bed file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/arq5x/bedops",
        example = paste()
    )
)
