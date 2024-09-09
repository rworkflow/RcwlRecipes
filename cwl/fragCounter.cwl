cwlVersion: v1.2
class: CommandLineTool
baseCommand: frag
requirements:
- class: DockerRequirement
  dockerPull: hubentu/jabba
inputs:
  bam:
    type: File
    secondaryFiles:
    - .bai?
    - ^.bai?
    inputBinding:
      prefix: -b
      separate: true
  gcmap:
    type: Directory
    inputBinding:
      prefix: -d
      separate: true
  window:
    type: int
    inputBinding:
      prefix: -w
      separate: true
  mapq:
    type: int?
    inputBinding:
      prefix: -q
      separate: true
outputs:
  bw:
    type: File
    outputBinding:
      glob: cov.corrected.bw
  rds:
    type: File
    outputBinding:
      glob: cov.rds
