cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- samtools
- flagstat
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.15--h1170115_1
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
