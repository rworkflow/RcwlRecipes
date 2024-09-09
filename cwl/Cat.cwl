cwlVersion: v1.0
class: CommandLineTool
baseCommand: cat
inputs:
  infiles:
    type: File[]
    inputBinding:
      separate: true
  outfile:
    type: string
    default: catout.txt
outputs:
  output:
    type: stdout
stdout: $(inputs.outfile)
