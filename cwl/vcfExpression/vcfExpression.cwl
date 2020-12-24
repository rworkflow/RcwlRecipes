cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- Rscript
- cwl/vcfExpression/vcfExpression.R
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
