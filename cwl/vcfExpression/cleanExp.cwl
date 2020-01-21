cwlVersion: v1.0
class: CommandLineTool
baseCommand: printf
arguments:
- valueFrom: |-
    '%s
    '
- valueFrom: library(R.utils)
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
