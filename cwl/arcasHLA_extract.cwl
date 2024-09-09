cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- arcasHLA
- extract
requirements:
- class: DockerRequirement
  dockerPull: hubentu/arcas-hla
arguments:
- -o
- '.'
- -v
inputs:
  bam:
    type: File
    secondaryFiles: .bai
    inputBinding:
      position: 1
      separate: true
  threads:
    type: int
    inputBinding:
      prefix: -t
      separate: true
    default: 4
outputs:
  fqs:
    type: File[]
    outputBinding:
      glob: '*.fq.gz'
