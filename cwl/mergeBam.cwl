cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- picard
- MergeSamFiles
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/picard:2.21.1--0
inputs:
  ibam:
    type:
      type: array
      items: File
      inputBinding:
        prefix: I=
        separate: false
    inputBinding:
      separate: true
  obam:
    type: string
    inputBinding:
      prefix: O=
      separate: false
outputs:
  oBam:
    type: File
    outputBinding:
      glob: $(inputs.obam)
