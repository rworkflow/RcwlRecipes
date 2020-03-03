cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- Rscript
- cwl/SomaticCallers/mergeTSV.R
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
