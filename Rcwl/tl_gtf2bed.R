script <- "
gtf=$1
name=`basename $gtf .gtf`
awk '{ if ($0 ~ \"transcript_id\") print $0; else print $0\" transcript_id \\\"\\\";\"; }' $gtf | gtf2bed - > $name.bed
"
p1 <- InputParam(id = "gtf", type = "File")
o1 <- OutputParam(id = "bed", type = "File", glob = "*.bed")
req1 <- requireDocker("quay.io/biocontainers/bedops:2.4.39--h7d875b9_1")
req2 <- requireShellScript(script)
gtf2bed <- cwlProcess(cwlVersion = "v1.2",
                      baseCommand = ShellScript(),
                      requirements = list(req1, req2),
                      inputs = InputParamList(p1),
                      outputs = OutputParamList(o1))
