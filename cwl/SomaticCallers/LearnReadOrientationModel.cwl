cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- gatk
- LearnReadOrientationModel
requirements:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:latest
inputs:
  f1r2:
    type: File
    inputBinding:
      prefix: -I
      separate: true
  romodel:
    type: string
    inputBinding:
      prefix: -O
      separate: true
    default: read-orientation-model.tar.gz
outputs:
  rofile:
    type: File
    outputBinding:
      glob: $(inputs.romodel)
