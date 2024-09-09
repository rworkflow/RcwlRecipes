cwlVersion: v1.0
class: CommandLineTool
baseCommand: geneBody_coverage.py
requirements:
- class: DockerRequirement
  dockerPull: hubentu/rcwl-rnaseq
inputs:
  bam:
    type: File
    secondaryFiles: .bai
    inputBinding:
      prefix: -i
      separate: true
  bed:
    type: File
    inputBinding:
      prefix: -r
      separate: true
  prefix:
    type: string
    inputBinding:
      prefix: -o
      separate: true
outputs:
  gCovPDF:
    type: File
    outputBinding:
      glob: '*.geneBodyCoverage.curves.pdf'
  gCovTXT:
    type: File
    outputBinding:
      glob: '*.geneBodyCoverage.txt'
