## samtools sam to bam
p1 <- InputParam(id = "sam", type = "File")
o1 <- OutputParam(id = "bam", type = "File", glob = "$(inputs.sam.basename).bam")
req2 <- list(class = "DockerRequirement",
             dockerPull = "quay.io/biocontainers/samtools:1.16.1--h6899075_1")
sam2bam <- cwlProcess(baseCommand = c("samtools", "view"),
                    arguments = list("-b"),
                    requirements = list(req2),
                    inputs = InputParamList(p1),
                    outputs = OutputParamList(o1),
                    stdout = "$(inputs.sam.basename).bam")
