cwlVersion: v1.0
class: CommandLineTool
baseCommand: rmats_bam.sh
requirements:
- class: DockerRequirement
  dockerPull: hubentu/rmats
inputs:
  bam1:
    type: File[]
    inputBinding:
      position: 1
      separate: true
      itemSeparator: ','
  bam2:
    type: File[]
    inputBinding:
      position: 2
      separate: true
      itemSeparator: ','
  type:
    type: string
    inputBinding:
      position: 3
      separate: true
    default: paired
  readLength:
    type: int
    inputBinding:
      position: 4
      separate: true
  gtf:
    type: File
    inputBinding:
      position: 5
      separate: true
  od:
    type: string?
    inputBinding:
      position: 6
      separate: true
    default: ./
  threads:
    type: int
    inputBinding:
      position: 7
      separate: true
    default: 4
  tstat:
    type: int?
    inputBinding:
      position: 8
      separate: true
    default: 4
outputs:
  res:
    type: File[]
    outputBinding:
      glob: '*.txt'
