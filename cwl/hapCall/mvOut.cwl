cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- Rscript
- /tmp/RtmpUGQRVi/Funa97523f2a4c0.R
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
