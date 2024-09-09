cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- samtools
- mpileup
requirements:
- class: DockerRequirement
  dockerPull: biocontainers/samtools:v1.7.0_cv3
inputs:
  bam:
    type: File
    inputBinding:
      separate: true
  ref:
    type: File
    secondaryFiles: .fai
    inputBinding:
      prefix: -f
      separate: true
  region:
    type: File?
    inputBinding:
      prefix: -l
      separate: true
outputs:
  pileup:
    type: File
    outputBinding:
      glob: $(inputs.bam.nameroot).pileup
stdout: $(inputs.bam.nameroot).pileup
