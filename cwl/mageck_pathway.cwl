cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- mageck
- pathway
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/mageck:0.5.9.4--py38hed8969a_0
inputs:
  geneRank:
    type: File
    inputBinding:
      prefix: --gene-ranking
      separate: true
  gmt:
    type: File
    inputBinding:
      prefix: --gmt-file
      separate: true
  prefix:
    type: string
    inputBinding:
      prefix: -n
      separate: true
outputs:
  pouts:
    type: File[]
    outputBinding:
      glob: $(inputs.prefix)*
