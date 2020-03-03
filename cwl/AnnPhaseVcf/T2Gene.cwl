cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- Rscript
- cwl/AnnPhaseVcf/T2Gene.R
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
