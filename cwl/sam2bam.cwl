cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- samtools
- view
requirements:
- class: DockerRequirement
  dockerPull: biocontainers/samtools:v1.7.0_cv3
arguments:
- -b
inputs:
  sam:
    type: File
    inputBinding:
      separate: true
outputs:
  bam:
    type: File
    outputBinding:
      glob: $(inputs.sam.basename).bam
stdout: $(inputs.sam.basename).bam
