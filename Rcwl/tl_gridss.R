## https://github.com/PapenfussLab/gridss

p1 <- InputParam(id = "bam", type = "File", position = 99, secondaryFiles = ".bai")
p2 <- InputParam(id = "ref", type = "File", prefix = "--reference",
                 secondaryFiles = c(".amb", ".ann", ".bwt", ".pac", ".sa", ".fai"))
p3 <- InputParam(id = "vcf", type = "string", prefix = "--output")
p4 <- InputParam(id = "assembly", type = "string?", prefix = "--assembly")
p5 <- InputParam(id = "threads", type = "int?", prefix = "--threads")
p6 <- InputParam(id = "gridss", type = "File?", prefix = "--jar")
p7 <- InputParam(id = "steps", type = "string", prefix = "--steps", default = "all")
o1 <- OutputParam(id = "ovcf", type = "File", glob = "$(inputs.vcf)")
o2 <- OutputParam(id = "abam", type = "File?", glob = "$(inputs.assembly)")

req1 <- requireDocker("quay.io/biocontainers/gridss:2.13.2--h20b1175_1")
req2 <- list(class = "InitialWorkDirRequirement",
             listing = list("$(inputs.ref)"))

gridss <- cwlProcess(baseCommand = "gridss",
                     requirements = list(req1, req2),
                     inputs = InputParamList(p1, p2, p3, p4, p5, p6, p7),
                     outputs = OutputParamList(o1, o2))
