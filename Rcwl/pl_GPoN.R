##2. GenomicsDB + PoN, run with cwltool argument: --relax-path-checks
#' @include tl_GenomicsDB.R tl_PoN.R
p1 <- InputParam(id = "nvcf", type = InputArrayParam(items = "File"), secondaryFiles = ".idx")
p2 <- InputParam(id = "Ref", type = "File",
                 secondaryFiles = c(".fai", "^.dict"))
p3 <- InputParam(id = "interval", type = "File")
p4 <- InputParam(id = "pvcf", type = "string")
p5 <- InputParam(id = "gresource", type = "File?",
                 secondaryFiles = "$(self.nameext == '.gz' ? self.basename+'.tbi' : self.basename+'.idx')")

s1 <- cwlStep(id = "GenomicsDB", run = GenomicsDB,
           In = list(vcf = "nvcf",
                     Ref = "Ref",
                     intervals = "interval"))
s2 <- cwlStep(id = "PoN", run = PoN,
           In = list(db = "GenomicsDB/dbout",
                     Ref = "Ref",
                     pon = "pvcf",
                     gresource = "gresource"))

o1 <- OutputParam(id = "Pvcf", type = "File", outputSource = "PoN/pout")

GPoN <- cwlWorkflow(requirements = list(requireJS()),
                    inputs = InputParamList(p1, p2, p3, p4, p5),
                    outputs = OutputParamList(o1))
GPoN <- GPoN + s1 + s2
