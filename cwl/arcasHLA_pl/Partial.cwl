cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- arcasHLA
- partial
requirements:
- class: DockerRequirement
  dockerPull: hubentu/arcas-hla
arguments:
- -o
- '.'
- -v
inputs:
  fqs:
    type: File[]
    inputBinding:
      position: 1
      separate: true
  gene:
    type: string
    inputBinding:
      prefix: -g
      separate: true
    default: A,B,C,DPB1,DQB1,DQA1,DRB1
  threads:
    type: int
    inputBinding:
      prefix: -t
      separate: true
  genotype:
    type: File
    inputBinding:
      prefix: -G
      separate: true
outputs:
  pg:
    type: File
    outputBinding:
      glob: '*.partial_genotype.json'
  align:
    type: File
    outputBinding:
      glob: '*.partial_alignment.p'
