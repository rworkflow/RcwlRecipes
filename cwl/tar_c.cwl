cwlVersion: v1.0
class: CommandLineTool
baseCommand: tar
inputs:
  create:
    type: boolean?
    inputBinding:
      position: 1
      prefix: -c
      separate: true
    default: true
  compress:
    type: boolean?
    inputBinding:
      position: 2
      prefix: -z
      separate: true
    default: true
  tar:
    type: string
    inputBinding:
      position: 3
      prefix: -f
      separate: true
  files:
    type:
    - File[]?
    - File?
    inputBinding:
      position: 4
      separate: true
  dir:
    type: Directory[]?
    inputBinding:
      position: 5
      separate: true
outputs:
  tarfile:
    type: File
    outputBinding:
      glob: $(inputs.tar)
