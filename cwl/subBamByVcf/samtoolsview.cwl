cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- samtools
- view
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.12--h9aed4be_1
inputs:
  bam:
    type: File
    inputBinding:
      position: 3
      separate: true
  bed:
    type: File?
    inputBinding:
      position: 1
      prefix: -L
      separate: true
  obam:
    type: string
    inputBinding:
      position: 2
      prefix: -o
      separate: true
  region:
    type: string?
    inputBinding:
      position: 4
      separate: true
  outb:
    type: boolean?
    inputBinding:
      prefix: -b
      separate: true
outputs:
  oBam:
    type: File
    outputBinding:
      glob: $(inputs.obam)
