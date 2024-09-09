cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- salmon
- quant
requirements:
- class: DockerRequirement
  dockerPull: combinelab/salmon
- class: InlineJavascriptRequirement
arguments:
- -l
- A
- --validateMappings
inputs:
  threadN:
    type: int
    inputBinding:
      position: 1
      prefix: -p
      separate: true
  ref:
    type: Directory
    inputBinding:
      position: 2
      prefix: -i
      separate: true
  fq1:
    type: File
    inputBinding:
      position: 3
      prefix: '-1'
      separate: true
  fq2:
    type: File
    inputBinding:
      position: 4
      prefix: '-2'
      separate: true
  outPrefix:
    type: string
    inputBinding:
      position: 5
      prefix: -o
      separate: true
outputs:
  out1:
    type: Directory
    outputBinding:
      glob: $(inputs.outPrefix)
