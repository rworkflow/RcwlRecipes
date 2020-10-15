cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- Rscript
- cwl/STARsoloDropletUtils/DropletUtils.R
inputs:
  dirname:
    type: Directory
    inputBinding:
      prefix: dir.name=
      separate: false
  lower:
    type: int
    inputBinding:
      prefix: lower=
      separate: false
    default: 100
  df:
    type: int
    inputBinding:
      prefix: df=
      separate: false
    default: 20
outputs:
  plots:
    type: File
    outputBinding:
      glob: '*.pdf'
  outsce:
    type: File
    outputBinding:
      glob: '*.rds'
