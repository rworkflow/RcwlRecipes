cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- picard
- BedToIntervalList
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/picard:2.21.1--0
inputs:
  bed:
    type: File
    inputBinding:
      prefix: I=
      separate: false
  SD:
    type: File
    inputBinding:
      prefix: SD=
      separate: false
  out:
    type: string
    inputBinding:
      prefix: O=
      separate: false
outputs:
  intval:
    type: File
    outputBinding:
      glob: $(inputs.out)
