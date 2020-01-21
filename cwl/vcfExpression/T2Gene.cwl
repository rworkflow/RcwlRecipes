cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- Rscript
- /tmp/RtmpUGQRVi/Funa97570556f0f.R
inputs:
  kexp:
    type: File
    inputBinding:
      prefix: kexp=
      separate: false
outputs:
  gout:
    type: File
    outputBinding:
      glob: abundance_gene.tsv
