cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- gatk
- CalculateContamination
requirements:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:latest
inputs:
  ttable:
    type: File
    inputBinding:
      prefix: -I
      separate: true
  ntable:
    type: File
    inputBinding:
      prefix: -matched
      separate: true
  cont:
    type: string
    inputBinding:
      prefix: -O
      separate: true
  seg:
    type: string
    inputBinding:
      prefix: -segments
      separate: true
outputs:
  Cout:
    type: File
    outputBinding:
      glob: $(inputs.cont)
  Seg:
    type: File
    outputBinding:
      glob: $(inputs.seg)
