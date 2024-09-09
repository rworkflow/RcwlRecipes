cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- vt
- decompose
requirements:
- class: DockerRequirement
  dockerPull: hubentu/vt
arguments:
- -s
inputs:
  ivcf:
    type: File
    inputBinding:
      position: 1
      separate: true
  ovcf:
    type: string
    inputBinding:
      position: 2
      prefix: -o
      separate: true
outputs:
  oVcf:
    type: File
    outputBinding:
      glob: $(inputs.ovcf)
