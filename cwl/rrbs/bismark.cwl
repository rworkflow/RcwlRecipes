cwlVersion: v1.2
class: CommandLineTool
baseCommand: bismark
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/bismark:0.23.1--hdfd78af_0
arguments:
- -o
- ./
inputs:
  genome:
    type: Directory
    inputBinding:
      prefix: --genome
      separate: true
  fq1:
    type:
    - File
    - File[]
    inputBinding:
      prefix: '-1'
      separate: true
      itemSeparator: ','
  fq2:
    type:
    - File
    - File[]
    inputBinding:
      prefix: '-2'
      separate: true
      itemSeparator: ','
  sam:
    type: boolean?
    inputBinding:
      prefix: --sam
      separate: true
  threads:
    type: int?
    inputBinding:
      prefix: -p
      separate: true
outputs:
  align:
    type: File
    outputBinding:
      glob: '*_bismark_bt2_pe.*'
  report:
    type: File
    outputBinding:
      glob: '*_report.txt'
