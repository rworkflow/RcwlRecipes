## https://github.com/genepattern/docker-mutsigcv

p1 <- InputParam(id = "maf", type = "File", position = 1)
p2 <- InputParam(id = "coverage", type = "File", position = 2)
p3 <- InputParam(id = "covar", type = "File", position = 3)
p4 <- InputParam(id = "sig", type = "string", position = 4)
p5 <- InputParam(id = "dict", type = "File", position = 5)
o1 <- OutputParam(id = "sigout", type = "File", glob = "$(inputs.sig).sig_genes.txt")
req1 <- requireDocker("genepattern/docker-mutsigcv:2a")
req2 <- list(class = "EnvVarRequirement",
             envDef = list(MCR_INHIBIT_CTF_LOCK = "$(1)"))
MutSigCV <- cwlProcess(baseCommand = "gp_MutSigCV",
                       requirements = list(req1),
                       inputs = InputParamList(p1, p2, p3, p4, p5),
                       outputs = OutputParamList(o1))


MutSigCV <- addMeta(
    MutSigCV,
    label = "MutSigCV",
    doc = "MutSigCV accepts whole genome or whole exome sequencing data from multiple samples, with information about point mutations, small insertions/deletions, and coverage, and identifies genes that are mutated more often than one would expect by chance.",
    inputLabels = c("maf","coverage","covar","sig","dict"),
    inputDocs = c("Mutation list in Mutation Annotation Format (MAF). For more information on the file format, see the Input Files section.","Coverage file in tab-delimited format, containing the number of sequenced bases in each patient, per gene per mutation category. For more information on the file format, see the Input Files section.","Covariates table in a tab-delimited text file. For more information on the file contents and format, see the Input Files section.","Base name for the output files.","The mutation type dictionary to use for automatic category and effect discovery. This is necessary only if you are using a MAF file without the columns 'categ' and 'effect'. See the Input Files section for details."),
    outputLabels = c("sigout"),
    outputDocs = c("A tab-delimited report of significant mutations, listed in descending order from most significant to least significant."),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/genepattern/docker-mutsigcv",
        example = paste()
    )
)
