cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- picard
- ReorderSam
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/picard:2.21.1--0
inputs:
  ibam:
    type: File
    inputBinding:
      prefix: I=
      separate: false
  obam:
    type: string
    inputBinding:
      prefix: O=
      separate: false
  dict:
    type: File
    inputBinding:
      prefix: SD=
      separate: false
outputs:
  rBam:
    type: File
    outputBinding:
      glob: $(inputs.obam)
