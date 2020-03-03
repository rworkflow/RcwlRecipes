cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- Rscript
- cwl/GAlign/mvOut.R
id: mvOut
inputs:
  logFile:
    type: File
    inputBinding:
      prefix: logFile=
      separate: false
outputs:
  OutDir:
    type: Directory
    outputBinding:
      glob: output
