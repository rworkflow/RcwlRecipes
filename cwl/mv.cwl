cwlVersion: v1.0
class: CommandLineTool
baseCommand: mv
inputs:
  file1:
    type: File
    inputBinding:
      position: 1
      separate: true
  file2:
    type: string
    inputBinding:
      position: 2
      separate: true
outputs:
  mvfile:
    type: File
    outputBinding:
      glob: $(inputs.file2)
