cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- kallisto
- quant
requirements:
- class: DockerRequirement
  dockerPull: zlskidmore/kallisto
arguments:
- -o
- ./
inputs:
  index:
    type: File
    inputBinding:
      prefix: -i
      separate: true
  fastq:
    type: File[]
    inputBinding:
      separate: true
  threads:
    type: int
    inputBinding:
      prefix: -t
      separate: true
outputs:
  h5:
    type: File
    outputBinding:
      glob: abundance.h5
  tsv:
    type: File
    outputBinding:
      glob: abundance.tsv
  info:
    type: File
    outputBinding:
      glob: run_info.json
