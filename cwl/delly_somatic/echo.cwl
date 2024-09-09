cwlVersion: v1.0
class: CommandLineTool
baseCommand: echo
inputs:
  sth:
    type: string
    inputBinding:
      separate: true
  escape:
    type: boolean?
    inputBinding:
      prefix: -e
      separate: true
  outfile:
    type: string
    default: echo.txt
outputs:
  out:
    type: File
    outputBinding:
      glob: $(inputs.outfile)
stdout: $(inputs.outfile)
