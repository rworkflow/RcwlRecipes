cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- samtools
- view
requirements:
- class: DockerRequirement
  dockerPull: biocontainers/samtools:1.11--h6270b1f_0
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
outputs:
  oBam:
    type: File
    outputBinding:
      glob: $(inputs.obam)
