cwlVersion: v1.0
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
    type: File
    inputBinding:
      prefix: '-1'
      separate: true
  fq2:
    type: File
    inputBinding:
      prefix: '-2'
      separate: true
  sam:
    type: boolean?
    inputBinding:
      prefix: --sam
      separate: true
outputs:
  algin:
    type: File
    outputBinding:
      glob: '*_bismark_bt2_pe.*'
  report:
    type: File
    outputBinding:
      glob: '*_report.txt'
