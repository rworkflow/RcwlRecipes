## https://github.com/brentp/mosdepth
i1<-InputParam(id="bedfile", type="File", prefix="--by")
i2<-InputParam(id="ct", type="string", prefix="--thresholds")
i3<-InputParam(id="fileID", type="string", position=1)
i4<-InputParam(id="bamfile", type="File", position=2, secondaryFile=".bai")
o1 <- OutputParam(id = "out", type="File[]", glob="$(inputs.fileID)*")
req1 <- requireDocker("quay.io/biocontainers/mosdepth:0.3.3--h37c5b7d_2")
mosdepth <- cwlProcess(baseCommand="mosdepth",
                       arguments = list("-x"),
                       requirements = list(req1),
                       inputs=InputParamList(i1,i2,i3,i4),
                       outputs = OutputParamList(o1))


mosdepth <- addMeta(
    mosdepth,
    label = "mosdepth",
    doc = "fast BAM/CRAM depth calculation for WGS, exome, or targeted sequencing.",
    inputLabels = c("bedfile","ct","fileID","bamfile"),
    inputDocs = c("optional BED file or (integer) window-sizes.","for each interval in --by, write number of bases covered by at least threshold bases. Specify multiple integer values separated by ','.","Output files","Input bam files"),
    outputLabels = c("out"),
    outputDocs = c("Output files"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/brentp/mosdepth",
        example = paste()
    )
)
