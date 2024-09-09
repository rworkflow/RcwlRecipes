cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- samtools
- depth
requirements:
- class: DockerRequirement
  dockerPull: biocontainers/samtools:v1.7.0_cv3
inputs:
  bam:
    type: File
    inputBinding:
      separate: true
outputs:
  pileup:
    type: File
    outputBinding:
      glob: $(inputs.bam.nameroot).depth.txt
stdout: $(inputs.bam.nameroot).depth.txt
