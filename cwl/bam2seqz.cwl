cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- sequenza-utils
- bam2seqz
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/sequenza-utils:3.0.0--py39h67e14b5_5
inputs:
  normal:
    type: File
    secondaryFiles: .bai
    inputBinding:
      prefix: -n
      separate: true
  tumor:
    type: File
    secondaryFiles: .bai
    inputBinding:
      prefix: -t
      separate: true
  ref:
    type: File
    secondaryFiles: .fai
    inputBinding:
      prefix: --fasta
      separate: true
  gc:
    type: File
    inputBinding:
      prefix: -gc
      separate: true
  out:
    type: string
    inputBinding:
      prefix: -o
      separate: true
outputs:
  seqz:
    type: File
    outputBinding:
      glob: $(inputs.out)
