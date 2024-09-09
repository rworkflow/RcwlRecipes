cwlVersion: v1.0
class: CommandLineTool
baseCommand: paste
inputs:
  files:
    type: File[]
    inputBinding:
      separate: true
  sep:
    type: string?
    inputBinding:
      prefix: -d
      separate: true
  outfile:
    type: string
    default: paste.txt
outputs:
  out:
    type: File
    outputBinding:
      glob: $(inputs.outfile)
stdout: $(inputs.outfile)
