## Cutadapt
## Work for paired-end reads
## Input files need to be in one of these formats: 
##   - FASTA with extensions: .fasta, .fa or .fna
##   - FASTQ with extensions: .fastq or .fq
##   - Any of the above, but compressed as .gz, .bz2 or .xz

## req1 <- list(class = "DockerRequirement", 
##              dockerPull = "kfdrc/cutadapt")
req1 <- requireDocker("quay.io/biocontainers/cutadapt:4.2--py310h1425a21_0")

p1 <- InputParam(id = "threadN", type = "int?", prefix = "-j", position = 1, default = 1L)
p2a <- InputParam(id = "adapter1a", type = "string?", prefix = "-a", position = 2)
p2b <- InputParam(id = "adapter2a", type = "string?", prefix = "-A", position = 3)
p2c <- InputParam(id = "adapter1g", type = "string?", prefix = "-g", position = 4)
p2d <- InputParam(id = "adapter2g", type = "string?", prefix = "-G", position = 5)
p2e <- InputParam(id = "adapter1b", type = "string?", prefix = "-b", position = 6)
p2f <- InputParam(id = "adapter2b", type = "string?", prefix = "-B", position = 7)
p3 <- InputParam(id = "out1prefix", type = "string", prefix = "-o", position = 8)
p4 <- InputParam(id = "out2prefix", type = "string?", prefix = "-p", position = 9)
p5 <- InputParam(id = "in1", type = "File", position = 99)
p6 <- InputParam(id = "in2", type = "File?", position = 100)
o1 <- OutputParam(id = "out1", type = "File", glob = "$(inputs.out1prefix)")
o2 <- OutputParam(id = "out2", type = "File?", glob = "$(inputs.out2prefix)")

cutadapt <- cwlProcess(baseCommand = "cutadapt", 
                         requirements = list(req1),
                         inputs = InputParamList(p1, p2a, p2b, p2c, p2d, p2e, p2f, p3, p4, p5, p6), 
                         outputs = OutputParamList(o1, o2))
