cwlVersion: v1.0
class: CommandLineTool
requirements:
- class: DockerRequirement
  dockerPull: serge2016/varscan:v0.1.1
arguments:
- -o
- '.'
inputs:
  nbam:
    type: File
    secondaryFiles: .bai
    inputBinding:
      position: 1
      separate: true
  tbam:
    type: File
    secondaryFiles: .bai
    inputBinding:
      position: 2
      separate: true
  ref:
    type: File
    secondaryFiles:
    - .fai
    - $(self.nameroot).dict
    inputBinding:
      prefix: -b
      separate: true
  allvcf:
    type: string
    inputBinding:
      prefix: -f
      separate: true
  somvcf:
    type: string
    inputBinding:
      prefix: -y
      separate: true
  proc:
    type: int
    inputBinding:
      prefix: -p
      separate: true
outputs:
  allVcf:
    type: File
    outputBinding:
      glob: $(inputs.allvcf)
  somVcf:
    type: File
    outputBinding:
      glob: $(inputs.somvcf)
