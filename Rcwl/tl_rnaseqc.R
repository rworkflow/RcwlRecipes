## https://github.com/getzlab/rnaseqc
p1 <- InputParam(id = "gtf", type="File", position=1)
p2 <- InputParam(id = "bam", type="File", position=2)
p3 <- InputParam(id = "bed", type="File?", prefix="--bed")
p4 <- InputParam(id = "out", type="string?", position=9, default=".")
o1 <- OutputParam(id = "qcOut", type="File[]", glob="$(inputs.bam.nameroot)*")
req1 <- requireDocker("gcr.io/broad-cga-aarong-gtex/rnaseqc:latest")
rnaseqc <- cwlProcess(baseCommand = "rnaseqc",
                      requirements = list(req1),
                      inputs = InputParamList(p1, p2, p3, p4),
                      outputs = OutputParamList(o1))
