cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- kallisto
- index
requirements:
- class: DockerRequirement
  dockerPull: zlskidmore/kallisto
inputs:
  index:
    type: string
    inputBinding:
      prefix: -i
      separate: true
  fasta:
    type: File
    inputBinding:
      separate: true
outputs:
  fidx:
    type: File
    outputBinding:
      glob: $(inputs.index)
