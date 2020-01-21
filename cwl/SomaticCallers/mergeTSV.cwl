cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- Rscript
- /tmp/RtmpUGQRVi/Funa9757ec4b2d5.R
inputs:
  esnv:
    type: File
    inputBinding:
      prefix: esnv=
      separate: false
  eindel:
    type: File
    inputBinding:
      prefix: eindel=
      separate: false
outputs:
  tsv:
    type: File
    outputBinding:
      glob: Ensemble.sVar.tsv
