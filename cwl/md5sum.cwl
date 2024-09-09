cwlVersion: v1.0
class: CommandLineTool
baseCommand: md5sum
inputs:
  file:
    type: File
    inputBinding:
      separate: true
outputs:
  md5:
    type: File
    outputBinding:
      glob: $(inputs.file.basename).md5
stdout: $(inputs.file.basename).md5
