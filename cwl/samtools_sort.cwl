cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- samtools
- sort
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.12--h9aed4be_1
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
