cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- samtools
- flagstat
requirements:
- class: DockerRequirement
  dockerPull: biocontainers/samtools:v1.7.0_cv3
inputs:
  bam:
    type: File
    inputBinding:
      separate: true
outputs:
  flagstat:
    type: File
    outputBinding:
      glob: $(inputs.bam.nameroot).flagstat.txt
stdout: $(inputs.bam.nameroot).flagstat.txt
