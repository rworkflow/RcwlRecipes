cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- picard
- RenameSampleInVcf
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/picard:2.21.1--0
inputs:
  vcf:
    type: File
    inputBinding:
      prefix: I=
      separate: false
  ovcf:
    type: string
    inputBinding:
      prefix: O=
      separate: false
  NewName:
    type: string
    inputBinding:
      prefix: NEW_SAMPLE_NAME=
      separate: false
outputs:
  oVcf:
    type: File
    outputBinding:
      glob: $(inputs.ovcf)
