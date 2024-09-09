## https://software.broadinstitute.org/cancer/cga/polysolver_run
## run with --no-read-only
p1 <- InputParam(id = "bam", type = "File",
                 position = 1, secondaryFiles = ".bai")
p2 <- InputParam(id = "race", type = "string",
                 position = 2, default = "Unknown")
p3 <- InputParam(id = "includeFreq", type = "int",
                 position = 3, default = 1L)
p4 <- InputParam(id = "build", type = "string",
                 position = 4, default = "hg19")
p5 <- InputParam(id = "format", type = "string",
                 position = 5, default = "STDFQ")
p6 <- InputParam(id = "insertCalc", type = "int",
                 position = 6, default = 0L)
p7 <- InputParam(id = "outDir", type = "Directory",
                 position = 7)
o1 <- OutputParam(id = "hla", type = "File", glob = "*.hla.txt")
req1 <- list(class = "DockerRequirement",
             dockerPull = "sachet/polysolver:v4")

polysolver <- cwlProcess(baseCommand = c("bash", "/home/polysolver/scripts/shell_call_hla_type"),
                       requirements = list(req1),
                      arguments = list(
                          list(valueFrom = "$(runtime.outdir)", position = 7L)
                      ),
                      inputs = InputParamList(p1, p2, p3, p4, p5, p6),
                      outputs = OutputParamList(o1))


polysolver <- addMeta(
    polysolver,
    label = "polysolver",
    doc = "Computational tool designed to accurately determine HLA (Human Leukocyte Antigen) types from next-generation sequencing (NGS) data, particularly from whole-exome sequencing (WES) or whole-genome sequencing (WGS) data.",
    inputLabels = c("bam","race","includeFreq","build","format","insertCalc","outDir"),
    inputDocs = c("path to the BAM file to be used for HLA typing","ethnicity of the individual (Caucasian, Black, Asian or Unknown)","flag indicating whether population-level allele frequencies should be used as priors (0 or 1)","reference genome used in the BAM file (hg18, hg19 or hg38)","fastq format (STDFQ, ILMFQ, ILM1.8 or SLXFQ; see Novoalign documentation)","flag indicating whether empirical insert size distribution should be used in the model (0 or 1)","output directory"),
    outputLabels = c("hla"),
    outputDocs = c("file containing the two inferred alleles for each of HLA-A, HLA-B and HLA-C"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://software.broadinstitute.org/cancer/cga/polysolver_run",
        example = paste()
    )
)
