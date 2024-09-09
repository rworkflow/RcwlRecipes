# https://github.com/luntergroup/octopus
p1 <- InputParam(id = "bams", type = "File[]", prefix = "-I", secondaryFiles = list(".bai?", "^.bai?"))
p2 <- InputParam(id = "ref", type = "File", prefix = "-R", secondaryFiles = ".fai")
p3 <- InputParam(id = "normal", type = "string", prefix = "-N")
p4 <- InputParam(id = "ovcf", type = "string", prefix = "-o")
p5 <- InputParam(id = "region", type = "File?", prefix = "-t")
p6 <- InputParam(id = "error", type = "string?", prefix = "--sequence-error-model")
p7 <- InputParam(id = "threads", type = "int?", prefix = "--threads")
p8 <- InputParam(id = "expFreq", type = "float?", prefix = "--min-expected-somatic-frequency")
p9 <- InputParam(id = "creFreq", type = "float?", prefix = "--min-credible-somatic-frequency")
p10 <- InputParam(id = "annotation", type = "string[]?", prefix = "--annotations")
o1 <- OutputParam(id = "oVcf", type = "File", glob = "$(inputs.ovcf)")
req1 <- requireDocker("dancooke/octopus")
octopus_somatic <- cwlProcess(cwlVersion = "v1.2",
                              baseCommand = "octopus",
                              requirements = list(req1),
                              arguments = list("--forest",
                                               "/opt/octopus/resources/forests/germline.v0.7.4.forest",
                                               "--somatic-forest",
                                               "/opt/octopus/resources/forests/somatic.v0.7.4.forest"),
                              inputs = InputParamList(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10),
                              outputs = OutputParamList(o1))


octopus_somatic <- addMeta(
    octopus_somatic,
    label = "octopus_somatic",
    doc = "Calls somatic variants by comparing a tumor sample to a matched normal sample.",
    inputLabels = c("bams","ref","normal","ovcf","region","error","threads","expFreq","creFreq","annotation"),
    inputDocs = c("Indexed BAM/CRAM files to be analysed","Indexed FASTA format reference genome file to be analysed","Normal samples - all other samples are considered tumour","File to where output is written (calls are written to stdout if unspecified)","File containing a list of regions (chrom:begin-end), one per line, to be analysed","Sequencing error model to use by the haplotyoe likelihood model","Maximum number of threads to be used. If no argument is provided unlimited threads are assumed","Minimum expected somatic allele frequency in the sample","Minimum credible somatic allele frequency that will be reported","Annotations to write to final VCF"),
    outputLabels = c("oVcf"),
    outputDocs = c("Output somantic variant file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/luntergroup/octopus",
        example = paste()
    )
)
