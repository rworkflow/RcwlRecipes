cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- msisensor-pro
- msi
requirements:
- class: DockerRequirement
  dockerPull: pengjia1110/msisensor-pro
inputs:
  site:
    type: File
    inputBinding:
      prefix: -d
      separate: true
  nbam:
    type: File
    secondaryFiles: .bai
    inputBinding:
      prefix: -n
      separate: true
  tbam:
    type: File
    secondaryFiles: .bai
    inputBinding:
      prefix: -t
      separate: true
  outprefix:
    type: string
    inputBinding:
      prefix: -o
      separate: true
outputs:
  outs:
    type: File[]
    outputBinding:
      glob: $(inputs.outprefix)*
