cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- samtools
- stats
requirements:
- class: DockerRequirement
  dockerPull: biocontainers/samtools:v1.7.0_cv3
inputs:
  bam:
    type: File
    inputBinding:
      separate: true
outputs:
  stats:
    type: File
    outputBinding:
      glob: $(inputs.bam.nameroot).stats.txt
stdout: $(inputs.bam.nameroot).stats.txt
