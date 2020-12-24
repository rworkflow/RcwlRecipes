cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- Rscript
- cwl/SUPPA/splitEventsG1.R
inputs:
  files:
    type: File[]
    inputBinding:
      prefix: files=
      separate: false
      itemSeparator: ','
  columns:
    type: string
    inputBinding:
      prefix: columns=
      separate: false
  cnames:
    type: string?
    inputBinding:
      prefix: cnames=
      separate: false
  outfile:
    type: string
    inputBinding:
      prefix: outfile=
      separate: false
outputs:
  outFile:
    type: File
    outputBinding:
      glob: $(inputs.outfile)
