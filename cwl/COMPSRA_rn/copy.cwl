cwlVersion: v1.0
class: CommandLineTool
baseCommand: cp
inputs:
  file1:
    type:
    - File
    - Directory
    inputBinding:
      position: 2
      separate: true
  file2:
    type: string
    inputBinding:
      position: 3
      separate: true
  folder:
    type: boolean?
    inputBinding:
      position: 1
      prefix: -r
      separate: true
outputs:
  cpfile:
    type:
    - File
    - Directory
    outputBinding:
      glob: $(inputs.file2)
