cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- msisensor-pro
- scan
requirements:
- class: DockerRequirement
  dockerPull: pengjia1110/msisensor-pro
inputs:
  ref:
    type: File
    secondaryFiles: .fai
    inputBinding:
      prefix: -d
      separate: true
  site:
    type: string
    inputBinding:
      prefix: -o
      separate: true
outputs:
  outsite:
    type: File
    outputBinding:
      glob: $(inputs.site)
