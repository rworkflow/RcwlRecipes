cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- samtools
- merge
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.12--h9aed4be_1
inputs:
  bam:
    type: File[]
    inputBinding:
      position: 99
      separate: true
  mbam:
    type: string
    inputBinding:
      position: 1
      separate: true
outputs:
  mBam:
    type: File
    outputBinding:
      glob: $(inputs.mbam)
