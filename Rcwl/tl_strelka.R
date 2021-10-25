## https://github.com/Illumina/strelka
p1 <- InputParam(id = "tbam", type = "File", prefix = "--tumorBam",
                 secondaryFiles = ".bai", position = 1)
p2 <- InputParam(id = "nbam", type = "File", prefix = "--normalBam",
                 secondaryFiles = ".bai", position = 2)
p3 <- InputParam(id = "ref", type = "File", prefix = "--referenceFasta",
                 secondaryFiles = ".fai", position = 3)
p4 <- InputParam(id = "callRegions", type = "File?", prefix = "--callRegions",
                 secondaryFiles = ".tbi", position = 4)
p5 <- InputParam(id = "indelCandidates", type = "File?", prefix = "--indelCandidates",
                 position = 5)
p6 <- InputParam(id = "exome", type = "boolean", prefix = "--exome", default = TRUE)
o1 <- OutputParam(id = "snvs", type = "File",
                  glob = "strelkaRunDir/results/variants/somatic.snvs.vcf.gz",
                  secondaryFiles = ".tbi")
o2 <- OutputParam(id = "indels", type = "File",
                  glob = "strelkaRunDir/results/variants/somatic.indels.vcf.gz",
                  secondaryFiles = ".tbi")

req1 <- list(class = "DockerRequirement",
             dockerPull = "quay.io/biocontainers/strelka:2.9.10--h9ee0642_1")
req2 <- list(class = "ShellCommandRequirement")
strelka <- cwlProcess(baseCommand = "configureStrelkaSomaticWorkflow.py",
                    requirements = list(req1, req2),
                    arguments = list(
                        "--runDir", "strelkaRunDir",
                        list(valueFrom = " && ", position = 6L, shellQuote = FALSE),
                        list(valueFrom = "strelkaRunDir/runWorkflow.py",
                             position = 7L),
                        list(valueFrom = "-m", position = 8L),
                        list(valueFrom = "local", position = 9L)),
                    inputs = InputParamList(p1, p2, p3, p4, p5, p6),
                    outputs = OutputParamList(o1, o2))
