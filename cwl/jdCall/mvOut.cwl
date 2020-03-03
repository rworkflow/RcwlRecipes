cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- Rscript
- cwl/jdCall/mvOut.R
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
