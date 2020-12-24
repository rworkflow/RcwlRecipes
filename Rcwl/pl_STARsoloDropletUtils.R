p1 <- InputParam(id = "fastq_cdna", type = "File[]")  ## only "id" names will be used for "Step".
p2 <- InputParam(id = "fastq_cb", type = "File[]")
p3 <- InputParam(id = "genomeDir", type = "Directory")
p4 <- InputParam(id = "whiteList", type = "File")
p5 <- InputParam(id = "runThreadN", type = "int")

#' @include tl_STARsolo.R tl_DropletUtils.R 
## STARsolo
s1 <- Step(id = "STARsolo", run = STARsolo,
           In = list(readFilesIn_cdna = "fastq_cdna", 
                     readFilesIn_cb = "fastq_cb",
                     genomeDir = "genomeDir",
                     whiteList = "whiteList",
                     runThreadN = "runThreadN"))

## DropletUtils
s2 <- Step(id = "DropletUtils", run = DropletUtils,
           In = list(dirname = "STARsolo/Solo"))

## outputs
o1 <- OutputParam(id = "sam", type = "File", outputSource = "STARsolo/outAlign")
o2 <- OutputParam(id = "Solo", type = "Directory", outputSource = "STARsolo/Solo")
o3 <- OutputParam(id = "sce", type = "File", outputSource = "DropletUtils/outsce")
o4 <- OutputParam(id = "plots", type = "File", outputSource = "DropletUtils/plots")

## stepParam
STARsoloDropletUtils <- cwlStepParam(inputs = InputParamList(p1, p2, p3, p4, p5),
                                     outputs = OutputParamList(o1, o2, o3, o4))
## pipeline
STARsoloDropletUtils <- STARsoloDropletUtils + s1 + s2






