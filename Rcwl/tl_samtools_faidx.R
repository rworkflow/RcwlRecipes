## bam faidx
p1 <- InputParam(id = "fa", type = "File", secondaryFiles = ".fai")
p2 <- InputParam(id = "region", type = "string", position = 1)
o1 <- OutputParam(id = "fout", type = "File", glob = "$(inputs.fa.nameroot)_$(inputs.region).fa")
req2 <- list(class = "DockerRequirement",
             dockerPull = "quay.io/biocontainers/samtools:1.15--h1170115_1")
samtools_faidx <- cwlProcess(baseCommand = c("samtools", "faidx"),
                             requirements = list(req2),
                             inputs = InputParamList(p1, p2),
                             outputs = OutputParamList(o1),
                             stdout = "$(inputs.fa.nameroot)_$(inputs.region).fa")
