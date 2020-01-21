cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- Rscript
- /tmp/RtmpUGQRVi/Funa97560a7c512.R
inputs:
  afile:
    type: File
    inputBinding:
      prefix: afile=
      separate: false
outputs:
  aout:
    type: File
    outputBinding:
      glob: abundance_clean.tsv
