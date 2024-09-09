cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- salmon
- index
requirements:
- class: DockerRequirement
  dockerPull: combinelab/salmon
- class: InlineJavascriptRequirement
arguments:
- --type
- quasi
inputs:
  threadN:
    type: int
    inputBinding:
      position: 1
      prefix: -p
      separate: true
  kmer:
    type: int
    inputBinding:
      position: 2
      prefix: -k
      separate: true
  refFasta:
    type: File
    inputBinding:
      position: 3
      prefix: -t
      separate: true
  outPrefix:
    type: string
    inputBinding:
      position: 4
      prefix: -i
      separate: true
outputs:
  out1:
    type: Directory
    outputBinding:
      glob: $(inputs.outPrefix)
