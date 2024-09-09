cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- gatk
- ApplyBQSR
requirements:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:latest
inputs:
  bam:
    type: File
    inputBinding:
      prefix: -I
      separate: true
  ref:
    type: File
    secondaryFiles:
    - .fai
    - $(self.nameroot).dict
    inputBinding:
      prefix: -R
      separate: true
  rtable:
    type: File
    inputBinding:
      prefix: --bqsr-recal-file
      separate: true
  oBam:
    type: string
    inputBinding:
      prefix: -O
      separate: true
outputs:
  Bam:
    type: File
    outputBinding:
      glob: $(inputs.oBam)
