cwlVersion: v1.0
class: CommandLineTool
baseCommand: miRDeep2.pl
requirements:
- class: DockerRequirement
  dockerPull: hubentu/mirdeep2
inputs:
  reads:
    type: File
    inputBinding:
      position: 1
      separate: true
  genome:
    type: File
    inputBinding:
      position: 2
      separate: true
  mappings:
    type: File
    inputBinding:
      position: 3
      separate: true
  miRef:
    type:
    - File
    - string
    inputBinding:
      position: 4
      separate: true
    default: none
  miOther:
    type:
    - File
    - string
    inputBinding:
      position: 5
      separate: true
    default: none
  precursors:
    type:
    - File
    - string
    inputBinding:
      position: 6
      separate: true
    default: none
  species:
    type: string
    inputBinding:
      position: 7
      prefix: -t
      separate: true
outputs:
  csvfiles:
    type: File[]
    outputBinding:
      glob: '*.csv'
  htmls:
    type: File[]
    outputBinding:
      glob: '*.html'
  bed:
    type: File
    outputBinding:
      glob: '*.bed'
  expression:
    type: Directory
    outputBinding:
      glob: expression_analyses
  mirna_results:
    type: Directory
    outputBinding:
      glob: mirna_results*
  pdfs:
    type: Directory
    outputBinding:
      glob: pdf*
