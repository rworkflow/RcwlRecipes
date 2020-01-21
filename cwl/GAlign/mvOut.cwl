cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- Rscript
- /tmp/RtmpUGQRVi/Funa9751a39d38e.R
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
