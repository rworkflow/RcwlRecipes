cwlVersion: v1.0
class: CommandLineTool
baseCommand: java
inputs:
  cromwell:
    type: File
    inputBinding:
      position: 1
      prefix: -jar
      separate: true
  run:
    type: string
    inputBinding:
      position: 2
      separate: true
    default: run
  wdl:
    type: File
    inputBinding:
      position: 3
      separate: true
  json:
    type: File
    inputBinding:
      position: 4
      prefix: -i
      separate: true
outputs:
  log:
    type: File
    outputBinding:
      glob: $(inputs.wdl.basename).log
stdout: $(inputs.wdl.basename).log
