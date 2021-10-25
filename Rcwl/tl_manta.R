## https://github.com/Illumina/manta
p1 <- InputParam(id = "tbam", type = "File", prefix = "--tumorBam",
                 secondaryFiles = ".bai", position = 1)
p2 <- InputParam(id = "nbam", type = "File", prefix = "--normalBam",
                 secondaryFiles = ".bai", position = 2)
p3 <- InputParam(id = "ref", type = "File", prefix = "--referenceFasta",
                 secondaryFiles = ".fai", position = 3)
p4 <- InputParam(id = "callRegions", type = "File?", prefix = "--callRegions",
                 secondaryFiles = ".tbi", position = 4)
p5 <- InputParam(id = "exome", type = "boolean", prefix = "--exome", default = TRUE)
o1 <- OutputParam(id = "somaticSV", type = "File",
                  glob = "mantaRunDir/results/variants/somaticSV.vcf.gz",
                  secondaryFiles = ".tbi")
o2 <- OutputParam(id = "diploidSV", type = "File",
                  glob = "mantaRunDir/results/variants/diploidSV.vcf.gz",
                  secondaryFiles = ".tbi")
o3 <- OutputParam(id = "candidateSV", type = "File",
                  glob = "mantaRunDir/results/variants/candidateSV.vcf.gz",
                  secondaryFiles = ".tbi")
o4 <- OutputParam(id = "candidateSmallIndels", type = "File",
                  glob = "mantaRunDir/results/variants/candidateSmallIndels.vcf.gz",
                  secondaryFiles = ".tbi")

req1 <- list(class = "DockerRequirement",
             dockerPull = "quay.io/biocontainers/manta:1.6.0--h9ee0642_1")
req2 <- list(class = "ShellCommandRequirement")
manta <- cwlProcess(baseCommand = "configManta.py",
                  requirements = list(req1, req2),
                  arguments = list(
                      "--runDir", "mantaRunDir",
                      list(valueFrom = " && ", position = 5L, shellQuote = FALSE),
                      list(valueFrom = "mantaRunDir/runWorkflow.py",
                           position = 6L),
                      list(valueFrom = "-m", position = 7L),
                      list(valueFrom = "local", position = 8L)),
                  inputs = InputParamList(p1, p2, p3, p4, p5),
                  outputs = OutputParamList(o1, o2, o3, o4))
