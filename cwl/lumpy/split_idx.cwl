cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- samtools
- index
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.12--h9aed4be_1
- class: InitialWorkDirRequirement
  listing:
  - $(inputs.bam)
inputs:
  bam:
    type: File
    inputBinding:
      position: 1
      separate: true
outputs:
  idx:
    type: File
    secondaryFiles:
    - .bai
    outputBinding:
      glob: $(inputs.bam.basename)
