cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- picard
- MarkDuplicates
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
  matrix:
    type: string
    inputBinding:
      prefix: M=
      separate: false
outputs:
  mBam:
    type: File
    outputBinding:
      glob: $(inputs.obam)
  Mat:
    type: File
    outputBinding:
      glob: $(inputs.matrix)
