cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- gatk
- Mutect2
requirements:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.1.3.0
inputs:
  tbam:
    type: File
    secondaryFiles: .bai
    inputBinding:
      prefix: -I
      separate: true
  nbam:
    type: File?
    secondaryFiles: .bai
    inputBinding:
      prefix: -I
      separate: true
  Ref:
    type: File
    secondaryFiles:
    - .fai
    - $(self.nameroot).dict
    inputBinding:
      prefix: -R
      separate: true
  normal:
    type: string?
    inputBinding:
      prefix: -normal
      separate: true
  germline:
    type: File?
    secondaryFiles: .idx
    inputBinding:
      prefix: --germline-resource
      separate: true
  pon:
    type: File?
    secondaryFiles: .idx
    inputBinding:
      prefix: --panel-of-normals
      separate: true
  interval:
    type: File?
    inputBinding:
      prefix: -L
      separate: true
  out:
    type: string
    inputBinding:
      prefix: -O
      separate: true
outputs:
  vout:
    type: File
    secondaryFiles:
    - .idx
    - .stats
    outputBinding:
      glob: $(inputs.out)
