cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- samtools
- sort
requirements:
- class: DockerRequirement
  dockerPull: biocontainers/samtools:v1.7.0_cv3
inputs:
  bam:
    type: File
    inputBinding:
      separate: true
outputs:
  sbam:
    type: File
    outputBinding:
      glob: $(inputs.bam.nameroot).sorted.bam
stdout: $(inputs.bam.nameroot).sorted.bam
