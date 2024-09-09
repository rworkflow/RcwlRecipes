cwlVersion: v1.0
class: CommandLineTool
baseCommand: arriba
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/arriba:2.4.0--h0033a41_2
inputs:
  align:
    type: File
    inputBinding:
      prefix: -x
      separate: true
  out:
    type: string
    inputBinding:
      prefix: -o
      separate: true
  dout:
    type: string
    inputBinding:
      prefix: -O
      separate: true
  genome:
    type: File
    secondaryFiles: .fai
    inputBinding:
      prefix: -a
      separate: true
  gtf:
    type: File
    inputBinding:
      prefix: -g
      separate: true
  blacklist:
    type: File
    inputBinding:
      prefix: -b
      separate: true
  known:
    type: File
    inputBinding:
      prefix: -k
      separate: true
  tag:
    type: File
    inputBinding:
      prefix: -t
      separate: true
  protein:
    type: File
    inputBinding:
      prefix: -p
      separate: true
outputs:
  fout:
    type: File
    outputBinding:
      glob: $(inputs.out)
  fOut:
    type: File
    outputBinding:
      glob: $(inputs.dout)
