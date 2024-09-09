cwlVersion: v1.0
class: CommandLineTool
baseCommand: /opt/CREST/CREST.sh
requirements:
- class: DockerRequirement
  dockerPull: hubentu/crest
inputs:
  tbam:
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
  ref:
    type: File
    secondaryFiles: .fai
    inputBinding:
      position: 3
      separate: true
  bit:
    type: File
    inputBinding:
      position: 4
      separate: true
  host:
    type: string
    inputBinding:
      position: 5
      separate: true
    default: localhost
  port:
    type: int
    inputBinding:
      position: 6
      separate: true
    default: 2345
outputs:
  predSV:
    type: File
    outputBinding:
      glob: $(inputs.tbam.basename).predSV.txt
