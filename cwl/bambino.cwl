cwlVersion: v1.0
class: CommandLineTool
baseCommand: /opt/run.sh
requirements:
- class: DockerRequirement
  dockerPull: hubentu/bambino
inputs:
  dbam:
    type: File
    secondaryFiles: .bai
    inputBinding:
      position: 1
      separate: true
  gbam:
    type: File
    secondaryFiles: .bai
    inputBinding:
      position: 2
      separate: true
  out:
    type: string
    inputBinding:
      position: 3
      separate: true
  ref:
    type: File
    secondaryFiles: .fai
    inputBinding:
      position: 4
      separate: true
outputs:
  vout:
    type: File
    outputBinding:
      glob: $(inputs.out)
