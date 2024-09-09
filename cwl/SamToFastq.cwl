cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- picard
- SamToFastq
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/picard:2.21.1--0
inputs:
  bam:
    type: File
    inputBinding:
      prefix: I=
      separate: false
  fq1:
    type: string
    inputBinding:
      prefix: F=
      separate: false
  fq2:
    type: string
    inputBinding:
      prefix: F2=
      separate: false
outputs:
  FQ1:
    type: File
    outputBinding:
      glob: $(inputs.fq1)
  FQ2:
    type: File
    outputBinding:
      glob: $(inputs.fq2)
