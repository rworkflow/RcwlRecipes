cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- samtools
- sort
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.12--h9aed4be_1
arguments:
- -n
inputs:
  bam:
    type: File
    inputBinding:
      separate: true
  obam:
    type: string
    inputBinding:
      prefix: -o
      separate: true
outputs:
  sbam:
    type: File
    outputBinding:
      glob: $(inputs.obam)
