p1 <- InputParam(id = "fastq_cdna", type = "File[]")  ## only "id" names will be used for "cwlStep".
p2 <- InputParam(id = "fastq_cb", type = "File[]")
p3 <- InputParam(id = "genomeDir", type = "Directory")
p4 <- InputParam(id = "whiteList", type = "File")
p5 <- InputParam(id = "runThreadN", type = "int")
p6 <- InputParam(id = "soloCellFilter", type = "string")
#' @include tl_STARsolo.R tl_counts2sce.R 
## STARsolo
s1 <- cwlStep(id = "STARsolo", run = STARsolo,
           In = list(readFilesIn_cdna = "fastq_cdna", 
                     readFilesIn_cb = "fastq_cb",
                     genomeDir = "genomeDir",
                     whiteList = "whiteList",
                     soloCellFilter = "soloCellFilter",
                     runThreadN = "runThreadN"))

## counts2sce
s2 <- cwlStep(id = "counts2sce", run = counts2sce,
           In = list(dirname = "STARsolo/Solo"))

## outputs
o1 <- OutputParam(id = "sam", type = "File", outputSource = "STARsolo/outAlign")
o2 <- OutputParam(id = "Solo", type = "Directory", outputSource = "STARsolo/Solo")
o3 <- OutputParam(id = "sce", type = "File", outputSource = "counts2sce/outsce")

## stepParam
STARsolo2sce <- cwlWorkflow(inputs = InputParamList(p1, p2, p3, p4, p5, p6),
                                     outputs = OutputParamList(o1, o2, o3))
## pipeline
STARsolo2sce <- STARsolo2sce + s1 + s2






