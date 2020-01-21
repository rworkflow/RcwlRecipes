cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- samtools
- index
requirements:
- class: DockerRequirement
  dockerPull: biocontainers/samtools:v1.7.0_cv3
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
