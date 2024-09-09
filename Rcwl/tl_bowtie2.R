## bowtie2:v2.2.9_cv2
## Be careful: bowtie2-build genome.fa genome.fa 
## Basename of .bt2 files must be exactly equal to "genome.fa" which is the reference_in

req1 <- list(class = "InlineJavascriptRequirement")
req2 <- list(class = "DockerRequirement", 
             dockerPull = "biocontainers/bowtie2:v2.2.9_cv2")
p1 <- InputParam(id = "threadN", type = "int", prefix = "-p")
p2 <- InputParam(id = "IndexPrefix", type = "File", prefix = "-x",
                 valueFrom = "$(self.dirname + '/' + self.basename)",
                 secondaryFiles = c("$(self.basename + '.1.bt2')",
                                    "$(self.basename + '.2.bt2')", 
                                    "$(self.basename + '.3.bt2')",
                                    "$(self.basename + '.4.bt2')",
                                    "$(self.basename + '.rev.1.bt2')", 
                                    "$(self.basename + '.rev.2.bt2')"), 
                 position = 2) 
p3 <- InputParam(id = "fq1", type = "File", prefix = "-1")
p4 <- InputParam(id = "fq2", type = "File", prefix = "-2")
o1 <- OutputParam(id = "sam", type = "File", glob = "*.sam")
                 
bowtie2 <- cwlProcess(baseCommand = "bowtie2",
                    requirements = list(req1, req2),
                    arguments = list("-S", "output.sam"),
                    inputs = InputParamList(p1, p2, p3, p4),
                    outputs = OutputParamList(o1))


bowtie2 <- addMeta(
    bowtie2,
    label = "bowtie2",
    doc = "Bowtie 2 is an ultrafast and memory-efficient tool for aligning sequencing reads to long reference sequences.",
    inputLabels = c("threadN","IndexPrefix","fq1","fq2"),
    inputDocs = c("number of alignment threads to launch (1)","Index filename prefix (minus trailing .X.bt2).","Files with #1 mates, paired with files in <m2>.","Files with #2 mates, paired with files in <m1>."),
    outputLabels = c("sam"),
    outputDocs = c("Aligned Sam file"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/BenLangmead/bowtie2",
        example = paste()
    )
)
